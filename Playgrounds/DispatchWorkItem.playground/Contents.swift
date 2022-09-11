import UIKit
/*
 DispatchWorkItem
 
 Adalah sebuah blok kode yang bisa dijalankan di antrian mana saja. Biasa berisi kode yang akan dieksekusi di dalam thread.
 */

var value = 5
let workItem = DispatchWorkItem {
    value += 5
}

workItem.perform()

let queue = DispatchQueue(label: "com.dicoding.dispatchworkitem", qos: .utility)
queue.async(execute: workItem)

workItem.notify(queue: DispatchQueue.main) {
    print("Final value: \(value)")
}
