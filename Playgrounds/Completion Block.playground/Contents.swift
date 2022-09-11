import UIKit

func expensiveTask(data: String, completion: @escaping (String) -> Void) {
    let queue = DispatchQueue(label: "com.dicoding.completionblock")
 
    queue.async {
        print("Processing: \(data)")
        sleep(2) // Imitate expensive task
        completion("Processing \(data) finished")
    }
}

let mainQueue = DispatchQueue(label: "com.dicoding.main", qos: .userInteractive)
 
mainQueue.async {
    expensiveTask(data: "Get User") { result in
        print(result)
    }
    
    print("Main Queue Run")
}
