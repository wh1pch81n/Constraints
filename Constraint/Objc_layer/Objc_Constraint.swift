
import Foundation

extension NSObject {
    
    @objc private static func _constraint_Leading() -> Any {
        return Constraint.leading
    }
    
    @objc private static func _constraint_Trailing() -> Any {
        return Constraint.trailing
    }
    
    @objc private static func _constraint_View(_ view: UIView, withRelation relation: Objc_ConstraintRelation, value: CGFloat, priority: Int) -> Any {
        let _relation: Constraint.Relation?
        let scalar = Constraint.Scalar.cgfloatWithPriority(value, Constraint.Priority.init(rawValue: priority))
        switch relation.rawValue {
        case Objc_ConstraintRelation.greaterThanOrEqual.rawValue:
            _relation = Constraint.Relation.greaterThanOrEqual(to: scalar)
        case Objc_ConstraintRelation.lessThanOrEqual.rawValue:
            _relation = Constraint.Relation.lessThanOrEqual(to: scalar)
        case Objc_ConstraintRelation.equal.rawValue:
            _relation = Constraint.Relation.equal(to: scalar)
        default:
            _relation = nil
        }
        return Constraint.view(view, length: _relation)
    }
    
    @objc private static func _constraint_lengthOfView(_ view1: UIView, equalsView view2: UIView) -> Any {
        return Constraint.length(of: view1, equals: view2)
    }
    
    @objc private static func _constraint_spacer(relation: Objc_ConstraintRelation, value: CGFloat, priority: Int) -> Any {
        let _relation: Constraint.Relation
        let scalar = Constraint.Scalar.cgfloatWithPriority(value, Constraint.Priority.init(rawValue: priority))
        switch relation {
        case .greaterThanOrEqual:
            _relation = Constraint.Relation.greaterThanOrEqual(to: scalar)
        case .lessThanOrEqual:
            _relation = Constraint.Relation.lessThanOrEqual(to: scalar)
        default:
            _relation = Constraint.Relation.equal(to: scalar)
        }
        return Constraint.spacer(length: _relation)
    }

}

extension NSObject {

    @objc private static func _constraint_Appended(_ previous: Any, toCurrent current: Any) -> Any {
        if let previous = previous as? Constraint
            , let current = current as? Constraint
        {
            return previous.appended(current)
        }
        return previous
    }
    
    @objc private static func _constraint_toNSLayoutConstraintsHorizontally(_ previous: Any, withOptions options: NSLayoutConstraint.FormatOptions) -> [NSLayoutConstraint] {
        return (previous as? Constraint)?.toNSLayoutConstraints(.horizontal, with: options) ?? []
    }
    
    @objc private static func _constraint_toNSLayoutConstraintsVertically(_ previous: Any, withOptions options: NSLayoutConstraint.FormatOptions) -> [NSLayoutConstraint] {
        return (previous as? Constraint)?.toNSLayoutConstraints(.vertical, with: options) ?? []
    }
    
}
