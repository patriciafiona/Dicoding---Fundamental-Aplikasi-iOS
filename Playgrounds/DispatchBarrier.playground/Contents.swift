import UIKit
/*
 DispatchBarrier
 
 Biasa digunakan untuk menjalankan operasi read dan write secara serial dalam suatu thread. Karena dijalankan secara serial, kita terhindar dari masalah yang berhubungan dengan proses membaca dan menulis object non thread-safe yang sama di dalam thread yang berbeda. Dapat disimpulkan bahwa DispatchBarrier bisa mengubah object non thread-safe menjadi sebuah object thread-safe.
 */

class ThreadSafeArray {
    let isolation = DispatchQueue(label: "com.dicoding.dispatchbarrier",
                                  attributes: .concurrent)
    
    private var _array: [Int] = []
    
    var array: [Int] {
        get {
            return isolation.sync {
                _array
            }
        }
        set {
            isolation.async(flags: .barrier) {
                self._array = newValue
            }
        }
    }
}
