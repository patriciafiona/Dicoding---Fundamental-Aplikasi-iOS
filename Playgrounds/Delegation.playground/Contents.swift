import UIKit

protocol TaskDelegate {
    func taskFinished(result: String)
}
 
struct Task {
    var delegate: TaskDelegate?
    func expensiveTask(data: String) {
        let queue = DispatchQueue(label: "com.dicoding.completionblock")
        queue.async {
            print("Processing: \(data)")
            sleep(2) // Imitate expensive task
            self.delegate?.taskFinished(result: "Processing \(data) finished")
        }
    }
}
 
struct Main: TaskDelegate {
    func run() {
        let mainQueue = DispatchQueue(label: "com.dicoding.main", qos: .userInteractive)
        mainQueue.async {
            var task = Task()
            task.delegate = self
            task.expensiveTask(data: "Get User")
            print("Main Queue Run")
        }
    }
 
    func taskFinished(result: String) {
        print(result)
    }
}
 
let main = Main()
main.run()
