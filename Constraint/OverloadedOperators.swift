
import Foundation

precedencegroup ConstraintPrecedenceGroup {
    associativity: left
    higherThan: AdditionPrecedence
}

// MARK: - infix operators

infix operator |-* : ConstraintPrecedenceGroup

public func |-*(lhs: Void, rhs: Constraint) -> Constraint {
    return Constraint.leading.appended(rhs)
}

public func |-*(lhs: Void, rhs: Int) -> Constraint {
    return Constraint.leading.appended(Constraint.spacer(length: Constraint.Relation.equal(to: Constraint.Scalar.int(rhs))))
}

public func |-*(lhs: Void, rhs: CGFloat) -> Constraint {
    return Constraint.leading.appended(Constraint.spacer(length: Constraint.Relation.equal(to: Constraint.Scalar.cgfloat(rhs))))
}

public func |-*(lhs: Void, rhs: UIView) -> Constraint {
    return Constraint.leading.appended(Constraint.view(rhs, length: nil))
}

// MARK: -

infix operator *-| : ConstraintPrecedenceGroup

public func *-|(lhs: Constraint, rhs: Void) -> Constraint {
    return lhs.appended(Constraint.trailing)
}

public func *-|(lhs: Int, rhs: Void) -> Constraint {
    return Constraint.spacer(length: Constraint.Relation.equal(to: Constraint.Scalar.int(lhs)))
        .appended(Constraint.trailing)
}

public func *-|(lhs: CGFloat, rhs: Void) -> Constraint {
    return Constraint.spacer(length: Constraint.Relation.equal(to: Constraint.Scalar.cgfloat(lhs)))
        .appended(Constraint.trailing)
}

public func *-|(lhs: UIView, rhs: Void) -> Constraint {
    return Constraint.view(lhs, length: nil)
        .appended(Constraint.trailing)
}

// MARK: -

infix operator *-* : ConstraintPrecedenceGroup

public func *-*(lhs: Constraint, rhs: Constraint) -> Constraint {
    return lhs.appended(rhs)
}

public func *-*(lhs: Constraint, rhs: UIView) -> Constraint {
    return lhs.appended(Constraint.view(rhs, length: nil))
}

public func *-*(lhs: Constraint, rhs: Int) -> Constraint {
    return lhs.appended(Constraint.spacer(length: Constraint.Relation.equal(to: Constraint.Scalar.int(rhs))))
}


// MARK: - prefix operators

prefix operator ==

public prefix func ==(rhs: CGFloat) -> Constraint {
    return Constraint.spacer(length: Constraint.Relation.equal(to: Constraint.Scalar.cgfloat(rhs)))
}

public prefix func ==(rhs: Int) -> Constraint {
    return Constraint.spacer(length: Constraint.Relation.equal(to: Constraint.Scalar.int(rhs)))
}

public prefix func ==(rhs: Constraint.Scalar) -> Constraint {
    return Constraint.spacer(length: Constraint.Relation.equal(to: rhs))
}

// MARK: -

prefix operator <=

public prefix func <=(rhs: CGFloat) -> Constraint {
    return Constraint.spacer(length: Constraint.Relation.lessThanOrEqual(to: Constraint.Scalar.cgfloat(rhs)))
}

public prefix func <=(rhs: Int) -> Constraint {
    return Constraint.spacer(length: Constraint.Relation.lessThanOrEqual(to: Constraint.Scalar.int(rhs)))
}

public prefix func <=(rhs: Constraint.Scalar) -> Constraint {
    return Constraint.spacer(length: Constraint.Relation.lessThanOrEqual(to: rhs))
}

// MARK: -

prefix operator >=

public prefix func >=(rhs: Int) -> Constraint {
    return Constraint.spacer(length: Constraint.Relation.greaterThanOrEqual(to: Constraint.Scalar.int(rhs)))
}

public prefix func >=(rhs: CGFloat) -> Constraint {
    return Constraint.spacer(length: Constraint.Relation.greaterThanOrEqual(to: Constraint.Scalar.cgfloat(rhs)))
}

public prefix func >=(rhs: Constraint.Scalar) -> Constraint {
    return Constraint.spacer(length: Constraint.Relation.greaterThanOrEqual(to: rhs))
}

// MARK: -

infix operator *->> : ConstraintPrecedenceGroup

public func *->>(lhs: Constraint, rhs: Constraint.Direction) -> [NSLayoutConstraint] {
    return lhs.toNSLayoutConstraints(rhs)
}

public func *->>(lhs: Constraint, rhs: Constraint.Apply<UIView>) {
    lhs.addConstraints(to: rhs.view, direction: rhs.direction)
}

/////////

// MARK: -

extension Constraint {
    static public func +=(lhs: inout Constraint, rhs: Constraint) {
        lhs.append(rhs)
    }
    
    static public func +(lhs: Constraint, rhs: Constraint) -> Constraint {
        return lhs.appended(rhs)
    }
}

