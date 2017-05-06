import RxSwift
import Moya
import SwiftyJSON

struct GlobalFeedViewModel {
    
    let disposeBag = DisposeBag()
    
    let articles$: BehaviorSubject<[Article]> = BehaviorSubject(value: [])
    let error$: BehaviorSubject<String?> = BehaviorSubject(value: nil)
    let requestInProgress$ = BehaviorSubject(value: false)
    
    func fetchArticles() {
        let provider = RxMoyaProvider<ArticleService>()
        requestInProgress$.onNext(true)
        provider.request(.articles)
            .subscribe { event in
                self.requestInProgress$.onNext(false)
                switch event {
                case let .next(response):
                    let json = JSON(data: response.data)
                    let articles = json["articles"].map { Article(json: $0.1) }
                    self.articles$.onNext(articles)
                case let .error(error):
                    self.error$.onNext(error.localizedDescription)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
   
}
