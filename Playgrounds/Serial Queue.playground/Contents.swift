import UIKit

/*
 Akan mengeksekusi tugas yang diberikan secara berurutan, dan tidak akan melanjutkan tugas berikutnya sebelum tugas yang sedang dikerjakan selesai.
 */

DispatchQueue.main.async {
    for _ in 0..<5 {
        print("blue")
    }
}
 
DispatchQueue.main.async {
    for _ in 0..<5 {
        print("red")
    }
}
