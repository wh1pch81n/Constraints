//: [Previous](@previous)

import UIKit
@testable import Constraints

// Example code
let painting = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))

var n = 0

(() |-* 5).produceConstraints(view_index: &n).formatString
(() |-* 1.23).produceConstraints(view_index: &n).formatString
(() |-* painting).produceConstraints(view_index: &n).formatString
(() |-* ==5).produceConstraints(view_index: &n).formatString
(() |-* >=5.with(priority: 999)).produceConstraints(view_index: &n).formatString

(5 *-| ()).produceConstraints(view_index: &n).formatString
(1.23 *-| ()).produceConstraints(view_index: &n).formatString
(painting *-| ()).produceConstraints(view_index: &n).formatString
(==5 *-| ()).produceConstraints(view_index: &n).formatString
(>=5.with(priority: 999) *-| ()).produceConstraints(view_index: &n).formatString

(() |-* painting *-| ()).produceConstraints(view_index: &n).formatString
(() |-* painting *-* 9 *-| ()).produceConstraints(view_index: &n).formatString
(() |-* 9 *-* painting *-| ()).produceConstraints(view_index: &n).formatString

(() |-* painting *-* >=9 *-| ()).produceConstraints(view_index: &n).formatString
(() |-* >=9 *-* painting *-| ()).produceConstraints(view_index: &n).formatString

(() |-* painting *-* >=9.with(priority: 999) *-| ()).produceConstraints(view_index: &n).formatString
(() |-* >=9.with(priority: 5) *-* painting *-| ()).produceConstraints(view_index: &n).formatString

//: [Next](@next)
