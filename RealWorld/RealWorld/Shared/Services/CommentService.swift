import RxSwift
import Moya
import SwiftyJSON

protocol CommentServiceType {
    var comments$: Observable<[String: [Comment]]?> { get }
    
    func fetchCommentsForArticle(slug: String) -> Observable<Void>
}

final class CommentService: BaseService, CommentServiceType {
    
    let disposeBag = DisposeBag()
    
    fileprivate let commentsSubject = ReplaySubject<[String: [Comment]]?>.create(bufferSize: 1)
    lazy var comments$: Observable<[String: [Comment]]?> = self.commentsSubject.asObservable()
        .startWith(nil)
        .shareReplay(1)
    
    override init(provider: ServiceProviderType) {
        super.init(provider: provider)
        commentsSubject.onNext(nil)
    }

    
    func fetchCommentsForArticle(slug: String) -> Observable<Void> {
        let provider = RxMoyaProvider<ArticleApi>()
        return provider.request(.articleComments(slug: slug))
            .do(onNext: { response in
                let json = JSON(data: response.data)
                let comments = json["comments"].map { Comment(json: $0.1) }
                self.commentsSubject
                    .subscribe(onNext: { commentMap in
                        if let commentMap = commentMap {
                            self.commentsSubject.onNext(commentMap.updatedValue(comments, forKey: slug))
                        } else {
                            self.commentsSubject.onNext([slug : comments])
                        }
                    })
                    .disposed(by: self.disposeBag)
            }, onError: { error in
            })
            .map { _ in Void() }
    }
    
}
