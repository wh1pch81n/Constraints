
import XCTest
@testable import Constraint

class DictionaryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDictionaryUnion() {
        do {
            var d: [String: Int] = ["h": 9]
            d.union(["m": 10])
            XCTAssertEqual(d["h"], 9)
            XCTAssertEqual(d["m"], 10)
        }
        do {
            var d: [String: Int] = ["h": 9]
            d += ["m": 10]
            XCTAssertEqual(d["h"], 9)
            XCTAssertEqual(d["m"], 10)
        }
    }
    
    func testDictionaryUnioned() {
        do {
            let d: [String: Int] = ["h": 9].unioned(["m": 10])
            XCTAssertEqual(d["h"], 9)
            XCTAssertEqual(d["m"], 10)
        }
        do {
            let d: [String: Int] = ["h": 9] + ["m": 10]
            XCTAssertEqual(d["h"], 9)
            XCTAssertEqual(d["m"], 10)
        }
    }
    
}
