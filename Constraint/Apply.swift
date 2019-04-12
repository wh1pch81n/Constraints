
import Foundation

extension Constraint {
    public struct Apply<V: UIView> {
        public let view: V
        public let direction: Direction
        public let options: NSLayoutConstraint.FormatOptions
        
        public init(to view: V, direction: Direction, options: NSLayoutConstraint.FormatOptions = NSLayoutConstraint.FormatOptions())
        {
            self.view = view
            self.direction = direction
            self.options = options
        }
    }
}
