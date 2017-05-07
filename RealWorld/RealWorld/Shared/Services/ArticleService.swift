import RxSwift
import Moya
import SwiftyJSON

protocol ArticleServiceType {
    var articles$: Observable<[Article]?> { get }
    
    func fetch() -> Observable<Void>
}

final class ArticleService: BaseService, ArticleServiceType {
    
    let disposeBag = DisposeBag()
    
    fileprivate let articlesSubject = ReplaySubject<[Article]?>.create(bufferSize: 1)
    lazy var articles$: Observable<[Article]?> = self.articlesSubject.asObservable()
        .startWith(nil)
        .shareReplay(1)
    
    func fetch() -> Observable<Void> {
        let provider = RxMoyaProvider<ArticleApi>()
        return provider.request(.articles)
            .do(onNext: { response in
                let json = JSON(data: response.data)
                let articles = json["articles"].map { Article(json: $0.1) }
                self.articlesSubject.onNext(articles)
            }, onError: { error in
            })
            .map { _ in Void() }
    }
    
}
