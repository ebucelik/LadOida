//
//  LocationManager.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 14.07.24.
//

import CoreLocation
import Combine

public class LocationManager: CLLocationManager, CLLocationManagerDelegate {
    fileprivate override init() {
        super.init()

        delegate = self
    }

    public static let shared = LocationManager()

    @Published var isLocationPermissionActivated: Bool = false
    private var cancellable: AnyCancellable?

    var locationPermissionChanged: AsyncStream<Bool> {
        return AsyncStream { continuation in
            cancellable = $isLocationPermissionActivated.sink { value in
                continuation.yield(value)
            }
        }
    }

    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()

        case .restricted, .denied:
            isLocationPermissionActivated = false

        case .authorizedWhenInUse, .authorizedAlways:
            isLocationPermissionActivated = true

        default:
            break
        }
    }
}
