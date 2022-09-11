import UIKit

//Implementasi BlockOperation dan OperationQueue

enum Color: String {
   case red = "red"
   case blue = "blue"
}
 
let count = 5
 
func show(color: Color, count: Int) {
   for _ in 1...count {
       print(color.rawValue)
   }
}

let queue = OperationQueue()
queue.maxConcurrentOperationCount = 2

let operation1 = BlockOperation(block: {
    show(color: .red, count: count)
})
operation1.qualityOfService = .userInteractive

let operation2 = BlockOperation(block: {
    show(color: .blue, count: count)
})

operation1.completionBlock = {
    print("Operation 1 completed")
}
 
operation2.completionBlock = {
    print("Operation 2 completed")
}

operation2.addDependency(operation1)

queue.addOperation(operation1)
queue.addOperation(operation2)
