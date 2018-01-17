import Foundation

extension Constraint {
    public struct Priority: Equatable {
        public let rawValue: Int
        public init(rawValue: Int) { self.rawValue = max(0, min(rawValue, 1000)) }
    }
}

extension Constraint.Priority {
    public static func ==(lhs: Constraint.Priority, rhs: Constraint.Priority) -> Bool { return lhs.rawValue == rhs.rawValue }
    public static let high = Constraint.Priority(rawValue: 1000)
    public static let medium = Constraint.Priority(rawValue: 750)
    public static let low = Constraint.Priority(rawValue: 250)
    
    
    internal var toString: String { return (self == Constraint.Priority.high ) ? "" : "@\(rawValue)" }
}
