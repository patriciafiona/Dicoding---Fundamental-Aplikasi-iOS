import UIKit
/*
 Kebalikan dari metode sinkron, metode ini akan langsung mengembalikan kontrol ke thread pemanggil setelah task dimasukkan ke dalam antrian tanpa perlu menunggu sampai selesai.
 
 Metode asinkron tidak akan melakukan blocking di thread pemanggil.
 */

let serial = DispatchQueue(label: "com.dicoding.async.serial")
 
serial.async {
    for _ in 0..<5 {
        print("red")
    }
}
 
serial.async {
    for _ in 0..<5 {
        print("blue")
    }
}
 
print("Proses selanjutnya")
