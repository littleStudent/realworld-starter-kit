import RxSwift
import Moya
import SwiftyJSON

struct ArticleViewModel {
    
    let disposeBag = DisposeBag()
    let provider: ServiceProviderType!
    
    var article$ = ReplaySubject<Article>.create(bufferSize: 1)
    var comments$: Observable<[Comment]?>
    let error$: BehaviorSubject<String?> = BehaviorSubject(value: nil)
    let requestInProgress$ = BehaviorSubject(value: false)
    
    init(provider: ServiceProviderType, article: Article) {
        self.provider = provider
        self.article$.onNext(article)
        self.comments$ = provider.commentService.comments$
            .unwrap()
            .withLatestFrom(article$)  { ($0, $1) }
            .map { (commentMap, article) in
                article.slug != nil ? commentMap[article.slug!] : []
        }
    }
    
    func fetchComments() {
        requestInProgress$.onNext(true)
        self.article$
            .take(1)
            .subscribe(onNext: { article in
                self.provider.commentService.fetchCommentsForArticle(slug: article.slug!)
                    .subscribe { event in
                        self.requestInProgress$.onNext(false)
                        switch event {
                        case let .error(error):
                            self.error$.onNext(error.localizedDescription)
                        default:
                            break
                        }
                    }
                    .disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
        
    }
    
}
