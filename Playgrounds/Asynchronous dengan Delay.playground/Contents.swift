import UIKit

let concurrent = DispatchQueue(label: "com.dicoding.sync.concurrent", attributes: .concurrent)
 
concurrent.asyncAfter(deadline: .now() + 1) {
    for _ in 0..<5 {
        print("red")
    }
}
