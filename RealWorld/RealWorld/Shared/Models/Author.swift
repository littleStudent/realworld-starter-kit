
import Foundation
import SwiftyJSON

public struct Author {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let following = "following"
        static let image = "image"
        static let username = "username"
        static let bio = "bio"
    }
    
    // MARK: Properties
    public var following: Bool? = false
    public var image: String?
    public var username: String?
    public var bio: String?
    
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
        following = json[SerializationKeys.following].boolValue
        image = json[SerializationKeys.image].string
        username = json[SerializationKeys.username].string
        bio = json[SerializationKeys.bio].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary[SerializationKeys.following] = following
        if let value = image { dictionary[SerializationKeys.image] = value }
        if let value = username { dictionary[SerializationKeys.username] = value }
        if let value = bio { dictionary[SerializationKeys.bio] = value }
        return dictionary
    }
    
}
