//
//  ViewController.swift
//  Stormy
//
//  Created by Iván Martínez on 24/09/17.
//  Copyright © 2017 Iván Martínez. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    lazy var locationAlertController: UIAlertController = {
        let alertController = UIAlertController(title: "Oops! :(", message: "We don't have access to your location.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        return alertController
    }()
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
    }

}

extension ViewController: CLLocationManagerDelegate {
    
    // MARK: - CLLocationManager
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("We have access to the current location")
            
            guard let location = locationManager.location else { return }
            
            getWeather(for: location)
        } else if status == .denied {
            present(locationAlertController, animated: true, completion: nil)
        }
    }
    
}
