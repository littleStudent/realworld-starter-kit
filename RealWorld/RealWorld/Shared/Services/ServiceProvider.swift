protocol ServiceProviderType: class {
    var articleService: ArticleServiceType { get }
    var commentService: CommentServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var articleService: ArticleServiceType = ArticleService(provider: self)
    lazy var commentService: CommentServiceType = CommentService(provider: self)
}
