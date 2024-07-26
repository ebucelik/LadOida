//
//  LocationManager.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 14.07.24.
//

import CoreLocation
import Combine

public class LocationManagerService: CLLocationManager, CLLocationManagerDelegate {
    override init() {
        super.init()

        delegate = self
        desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }

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
        case .restricted, .denied:
            isLocationPermissionActivated = false

        case .authorizedWhenInUse, .authorizedAlways:
            isLocationPermissionActivated = true

        default:
            break
        }
    }

    public func convertLocationToAddress(_ location: CLLocation) async throws -> String {
        let geocoder = CLGeocoder()

        guard let placemark = try await geocoder.reverseGeocodeLocation(location).first
        else { throw APIError.responseError }

        var address = ""

        // Street address
        if let street = placemark.thoroughfare {
            address.append(street)
        }

        // Zip code
        if let zipCode = placemark.postalCode {
            address.append(", \(zipCode) ")
        }

        // City
        if let city = placemark.locality {
            address.append(city)
        }

        return address
    }
}
