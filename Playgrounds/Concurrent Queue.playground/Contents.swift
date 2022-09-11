import UIKit
/*
 Seperti halnya antrian, tugas akan dieksekusi secara berurutan, tetapi antrian concurrent tidak perlu menunggu tugas pertama selesai untuk memulai tugas berikutnya.
 
 Alhasil antrian concurrent dapat selesai secara tidak berurutan.
 
 Hal ini dapat terjadi misal tugas pertama ternyata memakan waktu proses lebih panjang dari tugas lainnya. Sehingga, meskipun tugas pertama dieksekusi paling awal, bisa saja ia selesai paling akhir.
 */

DispatchQueue.global().async {
    for _ in 0..<5 {
        print("blue")
    }
}
 
DispatchQueue.global().async {
    for _ in 0..<5 {
        print("red")
    }
}
