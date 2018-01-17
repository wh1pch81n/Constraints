//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
@testable import Constraint
//import WBMDCommonFramework

////////
let canvas = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
canvas.backgroundColor = .blue
let painting = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
painting.adjustsFontSizeToFitWidth = true
painting.numberOfLines = 0
painting.text = "hello adfa das  "
painting.backgroundColor = .red

canvas.addSubview(painting)

() |-* 10 *-* painting *-* 26 *-| ()
    *->> Constraint.Apply(to: canvas, direction: .horizontal)

let m = (() |-* ==0 *-* painting *-* >=0 *-| ())

var n = 0
m.produceConstraints(view_index: &n).formatString
canvas.addConstraints(m.toNSLayoutConstraints(.vertical))

PlaygroundPage.current.liveView = canvas
