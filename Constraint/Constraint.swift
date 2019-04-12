import Foundation
import UIKit

public indirect enum Constraint {
    /// represents the view.
    case view(UIView, length: Relation?)
    case length(of: UIView, equals: UIView)
    
    /// represents the space between views
    case spacer(length: Relation)
    
    /// if horizontal it means the left of superview.  if vertical it means the top of superview
    case leading
    
    /// if horizontal it means the right of superview.  if vertical it means the bottom of superview
    case trailing
    
    case add(Constraint, Constraint)
}

extension Constraint {
    
    public func addConstraints(to view: UIView, direction: Direction, with options: NSLayoutConstraint.FormatOptions = NSLayoutConstraint.FormatOptions()) {
        view.addConstraints(self.toNSLayoutConstraints(direction, with: options))
    }
    
    public func toNSLayoutConstraints(_ direction: Direction
        , with options: NSLayoutConstraint.FormatOptions = NSLayoutConstraint.FormatOptions()) -> [NSLayoutConstraint]
    {
        var n = 0
        let pc = produceConstraints(view_index: &n)
        let visualFormatString = direction.rawValue + pc.formatString
        return NSLayoutConstraint.constraints(withVisualFormat: visualFormatString
            , options: options
            , metrics: nil
            , views: pc.viewDict)
    }
    
    internal func produceConstraints(view_index: inout Int) -> ProcessedConstraint
    {
        switch self {
        case .leading:
            return ProcessedConstraint(formatString: "|", viewDict: [:])
        case .trailing:
            return ProcessedConstraint(formatString: "|", viewDict: [:])
        case .length(of: let v1, equals: let v2):
            [v1, v2].forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
            let v1Str = "view_\(view_index)"
            view_index += 1
            let v2Str = "view_\(view_index)"
            view_index += 1
            
            let formatString = String(format: "[%@(==%@)]", v1Str, v2Str)
            
            return ProcessedConstraint(formatString: formatString, viewDict: [
                v1Str: v1
                , v2Str: v2
            ])
        case .view(let v, let length):
            v.translatesAutoresizingMaskIntoConstraints = false
            // increment level
            defer { view_index += 1 }
            
            let viewStr = "view_\(view_index)"
            let formatString: String
            if let length = length {
                formatString = String(format: "[%@(%@)]", viewStr, length.toString)
            } else {
                formatString = "[\(viewStr)]"
            }
            return ProcessedConstraint(formatString: formatString, viewDict: [viewStr: v])
        case .spacer(let length):
            return ProcessedConstraint(
                formatString: String(format: "(%@)", length.toString)
                , viewDict: [:]
            )
        case .add(let c0, let c1):
            let pc0 = c0.produceConstraints(view_index: &view_index)
            let pc1 = c1.produceConstraints(view_index: &view_index)
            return ProcessedConstraint(
                formatString: pc0.formatString + "-" + pc1.formatString
                , viewDict: pc0.viewDict + pc1.viewDict
            )
        }
    }
}

extension Constraint {    
    mutating public func append(_ constraint: Constraint) {
        self = Constraint.add(self, constraint)
    }
    
    public func appended(_ constraint: Constraint) -> Constraint {
        var new = self
        new = Constraint.add(new, constraint)
        return new
    }
}

extension Constraint {
    struct ProcessedConstraint {
        let formatString: String
        let viewDict: [String: Any]
    }
}

// MARK: - Class extensions

extension UIView {
    public func length(equalTo view: UIView) -> Constraint {
        return Constraint.length(of: self, equals: view)
    }
    
    public func length(equalTo length: Int, priority: Constraint.Priority = .high) -> Constraint {
        return Constraint.view(self, length: Constraint.Relation.equal(to: Constraint.Scalar.intWithPriority(length, priority)))
    }
    
    public func length(equalTo length: CGFloat, priority: Constraint.Priority = .high) -> Constraint {
        return Constraint.view(self, length: Constraint.Relation.equal(to: Constraint.Scalar.cgfloatWithPriority(length, priority)))
    }
    
    public func length(greaterThanOrEqualTo length: Int, priority: Constraint.Priority = .high) -> Constraint {
        return Constraint.view(self, length: Constraint.Relation.greaterThanOrEqual(to: Constraint.Scalar.intWithPriority(length, priority)))
    }
    
    public func length(greaterThanOrEqualTo length: CGFloat, priority: Constraint.Priority = .high) -> Constraint {
        return Constraint.view(self, length: Constraint.Relation.greaterThanOrEqual(to: Constraint.Scalar.cgfloatWithPriority(length, priority)))
    }
    
    public func length(lessThanOrEqualTo length: Int, priority: Constraint.Priority = .high) -> Constraint {
        return Constraint.view(self, length: Constraint.Relation.lessThanOrEqual(to: Constraint.Scalar.intWithPriority(length, priority)))
    }
    
    public func length(lessThanOrEqualTo length: CGFloat, priority: Constraint.Priority = .high) -> Constraint {
        return Constraint.view(self, length: Constraint.Relation.lessThanOrEqual(to: Constraint.Scalar.cgfloatWithPriority(length, priority)))
    }
}

extension Double {
    public func with(priority: Int) -> Constraint.Scalar {
        return Constraint.Scalar.cgfloatWithPriority(CGFloat(self), Constraint.Priority.init(rawValue: priority))
    }
}

extension Int {
    public func with(priority: Int) -> Constraint.Scalar {
        return Constraint.Scalar.intWithPriority(self, Constraint.Priority.init(rawValue: priority))
    }
}
