/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Custom pin annotation for display found places.
*/

import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    

    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    var title: String?
    var url: URL?
    var distance: Double = 0
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
