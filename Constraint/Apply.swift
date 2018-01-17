
import Foundation

extension Constraint {
    public struct Apply<V: UIView> {
        public let view: V
        public let direction: Direction
        public let options: NSLayoutFormatOptions
        
        public init(to view: V, direction: Direction, options: NSLayoutFormatOptions = NSLayoutFormatOptions())
        {
            self.view = view
            self.direction = direction
            self.options = options
        }
    }
}
