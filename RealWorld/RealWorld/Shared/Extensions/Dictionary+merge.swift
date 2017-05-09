
extension Dictionary {
    func updatedValue(_ value: Value, forKey key: Key) -> Dictionary {
        var newDictionary = self
        newDictionary[key] = value
        
        return newDictionary
    }
    
    func removedValue(forKey key: Key) -> Dictionary {
        var newDictionary = self
        newDictionary.removeValue(forKey: key)
        
        return newDictionary
    }
}
