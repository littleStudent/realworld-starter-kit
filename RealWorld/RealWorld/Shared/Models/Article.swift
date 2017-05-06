
import Foundation
import SwiftyJSON

public struct Article {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let favorited = "favorited"
        static let slug = "slug"
        static let body = "body"
        static let createdAt = "createdAt"
        static let tagList = "tagList"
        static let favoritesCount = "favoritesCount"
        static let updatedAt = "updatedAt"
        static let title = "title"
        static let descriptionValue = "description"
        static let author = "author"
    }
    
    // MARK: Properties
    public var favorited: Bool? = false
    public var slug: String?
    public var body: String?
    public var createdAt: Date?
    public var tagList: [String]?
    public var favoritesCount: Int?
    public var updatedAt: Date?
    public var title: String?
    public var descriptionValue: String?
    public var author: Author?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public init(json: JSON) {
        favorited = json[SerializationKeys.favorited].boolValue
        slug = json[SerializationKeys.slug].string
        body = json[SerializationKeys.body].string
        createdAt = json[SerializationKeys.createdAt].dateTime
        if let items = json[SerializationKeys.tagList].array { tagList = items.map { $0.stringValue } }
        favoritesCount = json[SerializationKeys.favoritesCount].int
        updatedAt = json[SerializationKeys.updatedAt].dateTime
        title = json[SerializationKeys.title].string
        descriptionValue = json[SerializationKeys.descriptionValue].string
        author = Author(json: json[SerializationKeys.author])
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary[SerializationKeys.favorited] = favorited
        if let value = slug { dictionary[SerializationKeys.slug] = value }
        if let value = body { dictionary[SerializationKeys.body] = value }
        if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
        if let value = tagList { dictionary[SerializationKeys.tagList] = value }
        if let value = favoritesCount { dictionary[SerializationKeys.favoritesCount] = value }
        if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
        if let value = title { dictionary[SerializationKeys.title] = value }
        if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
        if let value = author { dictionary[SerializationKeys.author] = value.dictionaryRepresentation() }
        return dictionary
    }
    
}
