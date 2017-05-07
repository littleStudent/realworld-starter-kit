protocol ServiceProviderType: class {
    var articleService: ArticleServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var articleService: ArticleServiceType = ArticleService(provider: self)
}
