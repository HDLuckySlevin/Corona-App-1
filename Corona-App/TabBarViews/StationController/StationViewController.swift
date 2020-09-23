//
//  StationViewController.swift
//  Corona-App
//
//  Created by BB1151 on 07.06.20.
//  Copyright © 2020 BB1151. All rights reserved.
//

import UIKit
import MapKit

protocol ChangeToStationNavControllerDelegate {
    // functions of data
}

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

// 1. erstelle erst einen SearchRequest
// 2. durch eine Annotation auf die Map anzeigen
// 3. in der TableView

struct Station {
    var name: String
    var adress: String
    var destination: String
    var lattitude: CLLocationDegrees
    var longtitude: CLLocationDegrees
}

class StationViewController: UIViewController{
    
    private enum AnnotationReuseID: String {
        case pin
    }
    
    
    private var places: [MKMapItem]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var stationMapKit: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    //Delegate
    var stationDelegate: ChangeToStationNavControllerDelegate?
    
    var selectedPin:MKPlacemark?
    var resultSearchController:UISearchController!
    
    private var searchCompleter: MKLocalSearchCompleter?
    private var searchRegion: MKCoordinateRegion = MKCoordinateRegion(MKMapRect.world)
    private var currentPlacemark: CLPlacemark?
    
    var completerResults: [MKLocalSearchCompletion]?
    
    var mapDistance: [Double] = []
    var mapItems: [MKMapItem]?
    
    var mapsButton = UIButton()
    
    private var boundingRegion: MKCoordinateRegion = MKCoordinateRegion(MKMapRect.world)
    
    private var foregroundRestorationObserver: NSObjectProtocol?
    
    private var localSearch: MKLocalSearch? {
        willSet {
            // Clear the results and cancel the currently running local search before starting a new search.
            places = nil
            localSearch?.cancel()
        }
    }
    
    // own Location by Locationmanager
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 3000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stationMapKit.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        
        
        // Make sure `MKPinAnnotationView` and the reuse identifier is recognized in this map view.
        stationMapKit.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: AnnotationReuseID.pin.rawValue)
        stationMapKit.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        checkLocationServices()
        tableView.reloadData()
        
    }
    private func userDistance(from point: PlaceAnnotation) -> Double? {
        guard let userLocation = stationMapKit.userLocation.location else {
            return nil // User location unknown!
        }
        let pointLocation = CLLocation(
            latitude:  point.coordinate.latitude,
            longitude: point.coordinate.longitude
        )
        return userLocation.distance(from: pointLocation)
    }
    
    func addAnnotation() {
        guard let mapItems = mapItems else { return }
        
        if mapItems.count == 1, let item = mapItems.first {
            title = item.name
        }
        
        // Turn the array of MKMapItem objects into an annotation with a title and URL that can be shown on the map.
        let annotations = mapItems.compactMap { (mapItem) -> PlaceAnnotation? in
            guard let coordinate = mapItem.placemark.location?.coordinate else { return nil }
            
            let annotation = PlaceAnnotation(coordinate: coordinate)
            annotation.title = mapItem.name
            annotation.url = mapItem.url
            annotation.distance = userDistance(from: annotation) ?? 0
            tableView.reloadData()
            mapDistance.append(annotation.distance / 1000)
            
            return annotation
        }
        stationMapKit.addAnnotations(annotations)
    }
    
    func createMessagePopUp(message: String) {
        let alert = UIAlertController(title: "Fehler: ", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        // best location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            stationMapKit.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // setup our location manager
            setupLocationManager()
            checkLocationAuthorization()
        }else{
            // Show alert letting the user know they have to turn this on
            
            //createMessagePopUp(message: "Position fehlgeschlagen!")
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // Do Map Stuff
            stationMapKit.showsUserLocation = true // kann in den einstellungen unternommen werden
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them to turn on permision
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
            //case .authorizedAlways: working always
        //break
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestLocation()
        tableView.reloadData()
    }
    
    func placemarkOnMap() {
        // Get the single item.
        guard let selectedItemPath = tableView.indexPathForSelectedRow, let mapItem = places?[selectedItemPath.row] else { return }
        
        // Pass the new bounding region to the map destination view controller and center it on the single placemark.
        var region = boundingRegion
        region.center = mapItem.placemark.coordinate
        self.boundingRegion = region
        
        // Pass the individual place to our map destination view controller.
        self.mapItems = [mapItem]
        
        
        // Pass the list of places found to our map destination view controller.
        self.mapItems = places
    }
    
    /// - Parameter suggestedCompletion: A search completion provided by `MKLocalSearchCompleter` when tapping on a search completion table row
    private func search(for suggestedCompletion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: suggestedCompletion)
        search(using: searchRequest)
    }
    
    /// - Parameter queryString: A search string from the text the user entered into
    private func search(for queryString: String?) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = queryString
        search(using: searchRequest)
    }
    
    /// - Tag: SearchRequest
    private func search(using searchRequest: MKLocalSearch.Request) {
        // Confine the map search area to an area around the user's current location.
        searchRequest.region = boundingRegion
        
        // Include only point of interest results. This excludes results based on address matches.
        searchRequest.resultTypes = .pointOfInterest
        
        localSearch = MKLocalSearch(request: searchRequest)
        localSearch?.start { [unowned self] (response, error) in
            guard error == nil else {
                self.displaySearchError(error)
                return
            }
            
            self.places = response?.mapItems
            
            self.mapItems = self.places
            self.placemarkOnMap()
            self.addAnnotation()
            
            
            // Used when setting the map's region in `prepareForSegue`.
            if let updatedRegion = response?.boundingRegion {
                self.boundingRegion = updatedRegion
            }
        }
    }
    
    private func displaySearchError(_ error: Error?) {
        if let error = error as NSError?, let errorString = error.userInfo[NSLocalizedDescriptionKey] as? String {
            let alertController = UIAlertController(title: "Fehler: ", message: errorString, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Location Handling
    private func requestLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
            displayLocationServicesDisabledAlert()
            return
        }
        
        let status = CLLocationManager.authorizationStatus()
        guard status != .denied else {
            displayLocationServicesDeniedAlert()
            return
        }
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    private func displayLocationServicesDisabledAlert() {
        let message = NSLocalizedString("LOCATION_SERVICES_DISABLED", comment: "Location services are disabled")
        let alertController = UIAlertController(title: NSLocalizedString("LOCATION_SERVICES_ALERT_TITLE", comment: "Location services alert title"),
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("BUTTON_OK", comment: "OK alert button"), style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func displayLocationServicesDeniedAlert() {
        let message = NSLocalizedString("LOCATION_SERVICES_DENIED", comment: "Location services are denied")
        let alertController = UIAlertController(title: NSLocalizedString("LOCATION_SERVICES_ALERT_TITLE", comment: "Location services alert title"),
                                                message: message,
                                                preferredStyle: .alert)
        let settingsButtonTitle = NSLocalizedString("BUTTON_SETTINGS", comment: "Settings alert button")
        let openSettingsAction = UIAlertAction(title: settingsButtonTitle, style: .default) { (_) in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                // Take the user to the Settings app to change permissions.
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
        
        let cancelButtonTitle = NSLocalizedString("BUTTON_CANCEL", comment: "Location denied cancel button")
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(openSettingsAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
}

// MARK: - MapView Delegate methods
extension StationViewController: MKMapViewDelegate {
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        createMessagePopUp(message: "Beim laden der Map ist folgender Fehler aufgetreten: \(error)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? PlaceAnnotation else { return nil }
        
        // Annotation views should be dequeued from a reuse queue to be efficent.
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationReuseID.pin.rawValue, for: annotation) as? MKMarkerAnnotationView
        view?.canShowCallout = true
        //view?.clusteringIdentifier = "searchResult"

        // If the annotation has a URL, add an extra Info button to the annotation so users can open the URL.
        if annotation.url != nil {
            let infoButton = UIButton(type: .infoDark)
            view?.rightCalloutAccessoryView = infoButton
        }
        
        tableView.reloadData()
        return view
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? PlaceAnnotation else { return }
        if let url = annotation.url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}


//MARK: - CLLocation Manager delegate methods
extension StationViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // updating Locations in Array
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        stationMapKit.setRegion(region, animated: true)
        boundingRegion = region
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemark, error) in
            guard error == nil else { return }
            
            self.currentPlacemark = placemark?.first
            self.boundingRegion = region
        }
        search(for: "Hausarzt")
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle any errors returned from Location Services.
    }
}


// MARK: - UITableViewDataSource
extension StationViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath) as! StationTableViewCell
        
        if let mapItem = places?[indexPath.row] {
            cell.stationHeaderLabel.text = mapItem.name
            cell.stattionAdressLabel.text = mapItem.placemark.parseAddress()
            let tmp = String(format: "%.1f", mapDistance[indexPath.row])
            cell.stationDestinationLabel.text = "\(tmp) km"
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header = NSLocalizedString("SEARCH_RESULTS", comment: "Standard result text")
        if let city = currentPlacemark?.locality {
            let templateString = NSLocalizedString("SEARCH_RESULTS_LOCATION", comment: "Search result text with city")
            header = String(format: templateString, city)
        }
        
        return header
    }
    
}

// MARK: - UITableViewDelegate
extension StationViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // select One cell and show it on the map
        
        if let mapItem = places?[indexPath.row] {
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
        }
    }
}


class MapsButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton(){
        self.setImage(UIImage.init(named: "placeholder"), for: .normal)
        self.setBackgroundImage(UIImage(named: "placeholder"), for: .normal)
        
    }
    
    
}
