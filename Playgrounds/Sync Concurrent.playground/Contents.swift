import UIKit

let concurrent = DispatchQueue(label: "com.dicoding.sync.concurrent"
                               , attributes: .concurrent)
 
concurrent.sync {
    for _ in 0..<5 {
        print("red")
    }
}
 
concurrent.sync {
    for _ in 0..<5 {
        print("blue")
    }
}
 
print("Proses selanjutnya")
