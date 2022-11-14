//
//  LocationManager.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 14.11.22.
//

import Combine
import CoreLocation

final class LocationManager: NSObject {

    /**
    Returns the default singleton instance.
    */
    static let shared = LocationManager()

    private lazy var locationManager: CLLocationManager = {
        let location = CLLocationManager()
        location.delegate = self
        location.pausesLocationUpdatesAutomatically = false
        location.showsBackgroundLocationIndicator = true
        location.desiredAccuracy = kCLLocationAccuracyBest

        return location
    }()

    var authorizationStatus: CLAuthorizationStatus {
        locationManager.authorizationStatus
    }

    func requestAlwaysAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }

    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        DispatchQueue.global().async {
            self.requestAlwaysAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startUpdatingLocation()
            }
        }
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    override init() {
        super.init()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        LocationObserver.didChangeAuthorization.send(status)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        LocationObserver.didUpdateLocations.send(locations)
    }
}

struct LocationObserver {
    static let didUpdateLocations = PassthroughSubject<[CLLocation], Never>()
    static let didChangeAuthorization = PassthroughSubject<CLAuthorizationStatus, Never>()
}
