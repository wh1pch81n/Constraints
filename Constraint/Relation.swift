import Foundation

extension Constraint {
    public enum Relation {
        case equal(to: Scalar)
        case greaterThanOrEqual(to: Scalar)
        case lessThanOrEqual(to: Scalar)
    }
}

extension Constraint.Relation {
    internal var toString: String {
        switch self {
        case .equal(to: let scalar):
            return "==" + scalar.toString
        case .greaterThanOrEqual(to: let scalar):
            return ">=" + scalar.toString
        case .lessThanOrEqual(to: let scalar):
            return "<=" + scalar.toString
        }
    }
}
