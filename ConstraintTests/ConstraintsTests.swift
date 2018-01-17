
import XCTest
@testable import Constraint

class ConstraintsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testFormatString_usingConstraintType() {
//        let dummyView = UIView()
//        let arr: [(input: Constraint, output: String)] = [
//            (input: Constraint.view(dummyView, length: Constraint.Relation.equal(to: Constraint.Scalar.int(4))), output: "[view_0(==4)]")
//        ]
//
//        testFormatStrings(with: arr, block: { (r, e) in XCTAssertEqual(r, e) })
//    }
    func testAppendConstraint() {
        do {
            var c: Constraint = Constraint.leading
            c.append(Constraint.view(UIView(), length: nil))
            var n = 0
            let pc = c.produceConstraints(view_index: &n)
            XCTAssertEqual(pc.formatString, "|-[view_0]")
        }
        
        do {
            var c: Constraint = Constraint.leading
            c += (Constraint.view(UIView(), length: nil))
            var n = 0
            let pc = c.produceConstraints(view_index: &n)
            XCTAssertEqual(pc.formatString, "|-[view_0]")
        }
    }
    
    func testAppendedConstraint() {
        do {
            let c: Constraint = Constraint.leading.appended(Constraint.view(UIView(), length: nil))
            var n = 0
            let pc = c.produceConstraints(view_index: &n)
            XCTAssertEqual(pc.formatString, "|-[view_0]")
        }
        
        do {
            let c: Constraint = Constraint.leading + (Constraint.view(UIView(), length: nil))
            var n = 0
            let pc = c.produceConstraints(view_index: &n)
            XCTAssertEqual(pc.formatString, "|-[view_0]")
        }
    }
    
    func testFormatString_overloadedOperators() {
        let dummyView = UIView()
        let arr: [(input: Constraint, output: String)] = [
            (input: () |-* 5, output: "|-(==5)"),
            (input: () |-* 1.23, output: "|-(==1.23)"),
            (input: () |-* dummyView, output: "|-[view_0]"),
            (input: () |-* ==5, output: "|-(==5)"),
            (input: () |-* <=5, output: "|-(<=5)"),
            (input: () |-* >=5, output: "|-(>=5)"),
            (input: () |-* >=5.with(priority: 999), output: "|-(>=5@999)"),
            (input: () |-* <=5.with(priority: 999), output: "|-(<=5@999)"),
            (input: () |-* ==5.6, output: "|-(==5.6)"),
            (input: () |-* <=5.6, output: "|-(<=5.6)"),
            (input: () |-* >=5.6, output: "|-(>=5.6)"),

            (input: 5 *-| (), output: "(==5)-|"),
            (input: 1.23 *-| (), output: "(==1.23)-|"),
            (input: dummyView *-| (), output: "[view_0]-|"),
            (input: ==5 *-| (), output: "(==5)-|"),
            (input: ==5.with(priority: 999) *-| (), output: "(==5@999)-|"),
            (input: >=5.with(priority: 999) *-| (), output: "(>=5@999)-|"),
            (input: >=5.9.with(priority: 999) *-| (), output: "(>=5.9@999)-|"),
            
            (input: () |-* dummyView *-| (), output: "|-[view_0]-|"),
            (input: () |-* dummyView *-* 9 *-| (), output: "|-[view_0]-(==9)-|"),
            (input: () |-* 9 *-* dummyView *-| (), output: "|-(==9)-[view_0]-|"),

            (input: () |-* dummyView *-* >=9 *-| (), output: "|-[view_0]-(>=9)-|"),
            (input: () |-* >=9 *-* dummyView *-| (), output: "|-(>=9)-[view_0]-|"),

            (input: () |-* dummyView *-* >=9.with(priority: 999) *-| (), output: "|-[view_0]-(>=9@999)-|"),
            (input: () |-* >=9.with(priority: 5) *-* dummyView *-| (), output: "|-(>=9@5)-[view_0]-|"),
            
            (input: dummyView.length(equalTo: 4), output: "[view_0(==4)]"),
            (input: dummyView.length(greaterThanOrEqualTo: 5), output: "[view_0(>=5)]"),
            (input: dummyView.length(lessThanOrEqualTo: 6), output: "[view_0(<=6)]"),
            
            (input: dummyView.length(equalTo: 4.5), output: "[view_0(==4.5)]"),
            (input: dummyView.length(greaterThanOrEqualTo: 5.6), output: "[view_0(>=5.6)]"),
            (input: dummyView.length(lessThanOrEqualTo: 6.7), output: "[view_0(<=6.7)]"),
            (input: dummyView.length(equalTo: UIView()), output: "[view_0(==view_1)]"),

        ]
        
        testFormatStrings(with: arr, block: { (r, e) in XCTAssertEqual(r, e) })
    }
    
    func testAddViewToSuperViewWithValidConstraints() {
        let canvas = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let painting = UIView()
        canvas.addSubview(painting)
        
        (() |-* 4 *-* painting *-* 4 *-| ()).addConstraints(to: canvas, direction: .horizontal)
        (() |-* 4 *-* painting *-* 4 *-| ()).addConstraints(to: canvas, direction: .vertical)
        
        canvas.setNeedsLayout()
        canvas.layoutIfNeeded()
        XCTAssertEqual(painting.frame, CGRect(x: 4, y: 4, width: 92, height: 92))
    }
    
    func testApplyOperatorOverloadByAddingViewToSuperViewWithValidConstraints() {
        let canvas = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let painting = UIView()
        canvas.addSubview(painting)
        
        () |-* 4 *-* painting *-* 4 *-| () *->> Constraint.Apply(to: canvas, direction: .horizontal)
        () |-* 8 *-* painting *-* 8 *-| () *->> Constraint.Apply(to: canvas, direction: .vertical)
        
        canvas.setNeedsLayout()
        canvas.layoutIfNeeded()
        XCTAssertEqual(painting.frame, CGRect(x: 4, y: 8, width: 92, height: 84))
    }
    
    func testNSLayoutConstraintsOperatorOverloadByAddingViewToSuperViewWithValidConstraints() {
        let canvas = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let painting = UIView()
        canvas.addSubview(painting)
        
        canvas.addConstraints(() |-* 4 *-* painting *-* 4 *-| () *->> .horizontal)
        canvas.addConstraints(() |-* 8 *-* painting *-* 8 *-| () *->> .vertical)
        
        canvas.setNeedsLayout()
        canvas.layoutIfNeeded()
        XCTAssertEqual(painting.frame, CGRect(x: 4, y: 8, width: 92, height: 84))
    }
}

extension ConstraintsTests {
    func testFormatStrings(with array: [(input: Constraint, output: String)], block: (String, String) -> ()) {
        for (input, output) in array {
            var n = 0
            block(input.produceConstraints(view_index: &n).formatString, output)
        }
    }
}
