import RxSwift
import Moya
import SwiftyJSON

struct GlobalFeedViewModel {
    
    let disposeBag = DisposeBag()
    let provider: ServiceProviderType!
    
    var articles$: Observable<[Article]?>
    let error$: BehaviorSubject<String?> = BehaviorSubject(value: nil)
    let requestInProgress$ = BehaviorSubject(value: false)
    
    init(provider: ServiceProviderType) {        
        self.provider = provider
        self.articles$ = provider.articleService.articles$
    }
    
    func fetchArticles() {
        requestInProgress$.onNext(true)
        self.provider.articleService.fetch()
            .subscribe{ event in
                self.requestInProgress$.onNext(false)
                switch event {
                case let .error(error):
                    self.error$.onNext(error.localizedDescription)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
   
}
