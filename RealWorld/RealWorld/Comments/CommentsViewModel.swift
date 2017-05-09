import RxSwift
import Moya
import SwiftyJSON

struct CommentsViewModel {
    
    let disposeBag = DisposeBag()
    let provider: ServiceProviderType!
    
    var comments$: Observable<[Comment]?>
    var articleSlug$ = ReplaySubject<String>.create(bufferSize: 1)
    let error$: BehaviorSubject<String?> = BehaviorSubject(value: nil)
    let requestInProgress$ = BehaviorSubject(value: false)
    
    init(provider: ServiceProviderType, articleSlug: String) {
        self.provider = provider
        self.articleSlug$.onNext(articleSlug)
        self.comments$ = provider.commentService.comments$
            .unwrap()
            .withLatestFrom(articleSlug$)  { ($0, $1) }
            .filter { (commentMap, articleSlug) in
                commentMap[articleSlug] != nil
            }
            .map { (commentMap, articleSlug) in
                commentMap[articleSlug]
            }
    }
    
    func fetchComments() {
        requestInProgress$.onNext(true)
        self.articleSlug$
            .subscribe(onNext: { articleSlug in
                self.provider.commentService.fetchCommentsForArticle(slug: articleSlug)
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
