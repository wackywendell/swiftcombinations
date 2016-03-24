@testable import Combinations
import XCTest

func compare_list<T: Equatable>(in1: [T], _ in2:[T]) -> Bool {
    if in1.count != in2.count {
        return false
    }
    
    for (item1, item2) in Zip2Sequence(in1, in2) {
        if item1 != item2 {
            return false
        }
    }
    
    return true
}

func compare_list_of_lists<T: Equatable>(in1: [[T]], _ in2:[[T]]) -> Bool {
    if in1.count != in2.count {
        return false
    }
    
    for (item1, item2) in Zip2Sequence(in1, in2) {
        if !(compare_list(item1, item2)) {
            return false
        }
    }
    
    return true
}

class SimpleCombinationTest: XCTestCase {

    func testSimpleCombination() {
        let plist1: [Int] = []
        let combos1: Combinations<Int> = Combinations(sequence: plist1, count: 0)
        let combo_list1: [[Int]] = Array(combos1)
        XCTAssertEqual(combo_list1.count, 0)
        
        let plist2: [Int] = []
        let combos2: Combinations<Int> = Combinations(sequence: plist2, count: 1)
        let combo_list2: [[Int]] = Array(combos2)
        XCTAssertEqual(combo_list2.count, 0)
        
        let plist3: [Int] = [4]
        let combos3: Combinations<Int> = Combinations(sequence: plist3, count: 0)
        let combo_list3: [[Int]] = Array(combos3)
        XCTAssertEqual(combo_list3.count, 0)
        
        let plist4: [Int] = [4]
        let combos4: Combinations<Int> = Combinations(sequence: plist4, count: 1)
        let combo_list4: [[Int]] = Array(combos4)
        XCTAssert(compare_list_of_lists(combo_list4, [[4]]))
        
        let plist5: [Int] = [4, 1, 3, 8]
        let combos5: Combinations<Int> = Combinations(sequence: plist5, count: 2)
        let combo_list5: [[Int]] = Array(combos5)
        XCTAssert(compare_list_of_lists(combo_list5, [[4, 1], [4, 3], [4, 8], [1, 3], [1, 8], [3, 8]]))
    }
}

#if os(Linux)
extension SimpleCombinationTest: XCTestCaseProvider {
    var allTests : [(String, () throws -> Void)] {
        return [
            ("testSimpleCombination", testSimpleCombination),
        ]
    }
}
#endif
