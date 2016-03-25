import Foundation

public class Combinations<T> : SequenceType {
    let possibilities: [T]
    var k: Int
    
    init<S : SequenceType where S.Generator.Element == T>(sequence: S, count: Int) {
        self.possibilities = Array(sequence)
        self.k = count
    }
    
    public func generate() -> AnyGenerator<[T]> {
        var curix = 0
        if (self.k == 0 || self.possibilities.count == 0) {
            return AnyGenerator<[T]> {
                return nil
            }
        }
        if self.k == 1 {
            return AnyGenerator<[T]> {
                if curix < self.possibilities.count {
                    let ix = curix
                    curix += 1
                    return [self.possibilities[ix]]
                }
                return nil
            }
        }
        let sub_list: [T] = Array(possibilities[1..<possibilities.count])
        var sub_combos = Combinations(sequence: sub_list, count: self.k - 1).generate()
        
        return AnyGenerator<[T]> {
            if let sub_combo = sub_combos.next() {
                return [self.possibilities[curix]] + sub_combo
            }
            
            if curix + 1 + self.k > self.possibilities.count {
                return nil
            }
            curix += 1
            
            let sub_list: [T] = Array(self.possibilities[curix+1..<self.possibilities.count])
            sub_combos = Combinations(sequence: sub_list, count: self.k - 1).generate()
            
            if let sub_combo = sub_combos.next() {
                return [self.possibilities[curix]] + sub_combo
            } else {
                print("This should be impossible.")
                return nil
            }
        }
    }
    
    public func print_combos() {
        print("-- [")
        for cset in self {
            print("[", terminator: "")
            for v in cset[0..<1] {
                print("\(v)", terminator: "")
            }
            for v in cset[1..<cset.count] {
                print(", \(v)", terminator: "")
            }
            print("]")
        }
        print("] --")
    }
}
