import UIKit
/*
 DispatchGroup
 
 DispatchGroup adalah sekumpulan tugas yang dikelompokan yang dapat dimonitor sebagai satu unit.
 */

func task1(dispatchGroup: DispatchGroup) {
   let queue = DispatchQueue(label: "com.dicoding.dispatchgroup.task1")

   queue.async {
        sleep(1)
        print("Task 1 executed")
        dispatchGroup.leave()
    }
}

func task2(dispatchGroup: DispatchGroup) {
    DispatchQueue.global().async {
        sleep(2)
        print("Task 2 executed")
        dispatchGroup.leave()
    }
}

func task3(dispatchGroup: DispatchGroup) {
    DispatchQueue.main.async {
        print("Task 3 executed")
        dispatchGroup.leave()
    }
}

let dispatchGroup = DispatchGroup()

dispatchGroup.enter()
task1(dispatchGroup: dispatchGroup)
dispatchGroup.enter()
task2(dispatchGroup: dispatchGroup)
dispatchGroup.enter()
task3(dispatchGroup: dispatchGroup)

dispatchGroup.notify(queue: DispatchQueue.main) {
   print("All task finished")
}
