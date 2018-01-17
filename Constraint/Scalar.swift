import Foundation
import UIKit

extension Constraint {
    public enum Scalar {
        case int(Int)
        case intWithPriority(Int, Priority)
        case cgfloat(CGFloat)
        case cgfloatWithPriority(CGFloat, Priority)
    }
}

extension Constraint.Scalar {
    internal var toString: String {
        switch self {
        case .cgfloatWithPriority(let n, let p):
            return "\(n)" + p.toString
        case .cgfloat(let n):
            return "\(n)"
        case .intWithPriority(let n, let p):
            return "\(n)" + p.toString
        case .int(let n):
            return "\(n)"
        }
    }
}
