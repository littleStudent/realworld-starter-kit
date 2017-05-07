//
//  User.swift
//
//  Created by  on 07/05/2017
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct User {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let token = "token"
        static let email = "email"
        static let bio = "bio"
        static let username = "username"
    }
    
    // MARK: Properties
    public var token: String?
    public var email: String?
    public var bio: String?
    public var username: String?
    
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
        token = json[SerializationKeys.token].string
        email = json[SerializationKeys.email].string
        bio = json[SerializationKeys.bio].string
        username = json[SerializationKeys.username].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = token { dictionary[SerializationKeys.token] = value }
        if let value = email { dictionary[SerializationKeys.email] = value }
        if let value = bio { dictionary[SerializationKeys.bio] = value }
        if let value = username { dictionary[SerializationKeys.username] = value }
        return dictionary
    }
    
}
