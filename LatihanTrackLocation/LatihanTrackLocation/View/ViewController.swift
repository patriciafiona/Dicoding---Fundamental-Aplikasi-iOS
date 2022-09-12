//
//  ViewController.swift
//  LatihanTrackLocation
//
//  Created by Patricia Fiona on 11/09/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var trackSwitch: UISwitch!
    @IBOutlet weak var mapView: MKMapView!
    
    private var locations: [MKPointAnnotation] = []
    
    private lazy var locationManager: CLLocationManager = {
            let manager = CLLocationManager()
            manager.delegate = self
            manager.requestAlwaysAuthorization()
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.allowsBackgroundLocationUpdates = true
            return manager
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Menghidupkan dan mematikan Track Location.
    @IBAction func trackSwitch(_ sender: UISwitch) {
        if sender.isOn {
          locationManager.startUpdatingLocation()
        } else {
          locationManager.stopUpdatingLocation()
        }
    }

}

// MARK: Ini adalah implementasi dari CLLocationManagerDelegate.
extension ViewController: CLLocationManagerDelegate {
    
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
  ) {
    guard let mostRecentLocation = locations.last else { return }
        
    let annotationToAdd = MKPointAnnotation()
    annotationToAdd.coordinate = mostRecentLocation.coordinate
        
    self.locations.append(annotationToAdd)
        
    while self.locations.count > 50 {
      if let annotationToRemove = self.locations.first {
        self.locations.remove(at: 0)
        mapView.removeAnnotation(annotationToRemove)
      }
    }
        
    mapView.showAnnotations(self.locations, animated: true)
 
    if UIApplication.shared.applicationState == .background {
      print("Aplikasi dalam background state. Lokasi baru saat ini ", mostRecentLocation)
    }
  }
    
}
