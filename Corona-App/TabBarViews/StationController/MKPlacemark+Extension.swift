/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Helper extension for formatting an address for display.
*/

import MapKit
import Contacts

extension MKPlacemark {
    
    var formattedAddress: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter.string(from: postalAddress, style: .mailingAddress).replacingOccurrences(of: "\n", with: ", ")
    }
    
    func parseAddress() -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (subThoroughfare != nil && thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (subThoroughfare != nil || thoroughfare != nil) && (subAdministrativeArea != nil || administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (subAdministrativeArea != nil && administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street name
            thoroughfare ?? "",
            firstSpace,
            // street number
            subThoroughfare ?? "",
            comma,
            // postal code
            postalCode ?? "",
            secondSpace,
            // city
            locality ?? ""
        )
        return addressLine
    }
}
