
import Moya


enum ArticleApi {
    case articles
    case articleComments(slug: String)
}

// MARK: - TargetType Protocol Implementation
extension ArticleApi: TargetType {
    var baseURL: URL { return URL(string: "https://conduit.productionready.io/api")! }
    var path: String {
        switch self {
        case .articles:
            return "/articles"
        case .articleComments(let slug):
            return "/articles/\(slug)/comments"
        }
    }
    var method: Moya.Method {
        switch self {
        case .articles, .articleComments:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .articles, .articleComments:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .articles, .articleComments:
            return URLEncoding.default
        }
    }
    var sampleData: Data {
        switch self {
        case .articles, .articleComments:
            return "asdf".utf8Encoded
        }
    }
    var task: Task {
        switch self {
        case .articles, .articleComments:
            return .request
        }
    }
}

extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
