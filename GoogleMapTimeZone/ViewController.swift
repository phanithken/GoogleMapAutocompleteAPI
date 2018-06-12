//
//  ViewController.swift
//  GoogleMapTimeZone
//
//  Created by Ken Phanith on 2018/06/12.
//  Copyright © 2018 Quad. All rights reserved.
//

import UIKit
import SnapKit
import GooglePlaces

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let timestamp = NSDate().timeIntervalSince1970
        APIClient.Timezone.getTimezone(location: "\(place.coordinate.latitude),\(place.coordinate.longitude)", timestamp: timestamp).subscribe { event in
            switch event {
            case .next(let resp):
                let timezoneValue = NSTimeZone(name: resp.timeZoneId)
                let info = "latitude: \(place.coordinate.latitude)\n longitude: \(place.coordinate.longitude)\ntimezoneId: \(resp.timeZoneId)\ntimezoneName: \(resp.timeZoneName)\ntimezoneValue: \(timezoneValue?.abbreviation ?? "")"
                let alert = UIAlertController(title: place.name, message: info, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                viewController.present(alert, animated: true)
            case .error(let error): print("error \(error)")
            case .completed: print("completed")
            }
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("user cancel search")
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
