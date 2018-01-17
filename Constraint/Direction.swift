import Foundation

extension Constraint {
    public enum Direction: String {
        case horizontal = "H:"
        case vertical = "V:"
    }
}

extension Constraint.Direction {
    public static let H = Constraint.Direction.horizontal
    public static let V = Constraint.Direction.vertical
}

