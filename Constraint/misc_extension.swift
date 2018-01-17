import Foundation

extension Dictionary {
    public static func +(left: [Key: Value], right: [Key: Value]) -> [Key: Value] {
        return left.unioned(right)
    }
    
    public static func +=(left: inout [Key: Value], right: [Key: Value]) {
        left.union(right)
    }
}

extension Dictionary {
    public func unioned(_ dict: [Key: Value]) -> [Key: Value] {
        var new = self
        for (k, v) in dict { new[k] = v }
        return new
    }
    
    public mutating func union(_ dict: [Key: Value]) {
        for (k, v) in dict { self[k] = v }
    }
}
