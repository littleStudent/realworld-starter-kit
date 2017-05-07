//
//  Comment.swift
//
//  Created by  on 07/05/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct Comment {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let updatedAt = "updatedAt"
        static let id = "id"
        static let body = "body"
        static let author = "author"
        static let createdAt = "createdAt"
    }
    
    // MARK: Properties
    public var updatedAt: String?
    public var id: Int?
    public var body: String?
    public var author: Author?
    public var createdAt: String?
    
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
        updatedAt = json[SerializationKeys.updatedAt].string
        id = json[SerializationKeys.id].int
        body = json[SerializationKeys.body].string
        author = Author(json: json[SerializationKeys.author])
        createdAt = json[SerializationKeys.createdAt].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = body { dictionary[SerializationKeys.body] = value }
        if let value = author { dictionary[SerializationKeys.author] = value.dictionaryRepresentation() }
        if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
        return dictionary
    }
    
}
