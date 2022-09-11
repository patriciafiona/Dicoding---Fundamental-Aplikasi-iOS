import UIKit
/*
 Metode ini akan menyebabkan blocking di thread pemanggil. Dengan menggunakan sync maka thread pemanggil akan menunggu tugas-tugas yang ada di dalam antrian selesai dieksekusi baik secara serial ataupun concurrent.
 */

let serial = DispatchQueue(label: "com.dicoding.sync.serial")
 
serial.sync {
    for _ in 0..<5 {
        print("red")
    }
}
 
serial.sync {
    for _ in 0..<5 {
        print("blue")
    }
}
 
print("Proses selanjutnya")
