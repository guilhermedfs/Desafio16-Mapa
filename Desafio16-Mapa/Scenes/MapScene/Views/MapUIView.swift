//
//  MapUIView.swift
//  Desafio16-Mapa
//
//  Created by Guilherme - ília on 13/01/22.
//

import MapKit
import SwiftUI

struct MapUIView: UIViewRepresentable {
    
    @Binding var location: MKCoordinateRegion
    @Binding var adress: PlaceDetails
    @Binding var pressed: Bool
    @Binding var pinSelected: Bool
    @ObservedObject var viewModel: MapViewModel
    
    let userLocation = MKPointAnnotation()
    let map = MKMapView(frame: .zero)
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        let region = location
        mapView.setRegion(region, animated: true)
        viewModel.originCoordinate = location.center

        if pressed {
            context.coordinator.retrieve(origin: viewModel.originCoordinate, destination: viewModel.destinationCoordinate)
        }
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        // Create a Long Press Gesture and select an action to it
        let press = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.addAnnotation(gesture:)))
        
        // Set minimum press duration
        press.minimumPressDuration = 0.4
        
        // Add gesture to the map
        map.addGestureRecognizer(press)
        
        map.delegate = context.coordinator
        map.mapType = .standard
        map.showsUserLocation = true
        
        // Set how the map will deal with users location change
        map.setUserTrackingMode(.follow, animated: true)
        
        return map
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(mapUIView: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var mapUIView: MapUIView
        
        init(mapUIView: MapUIView) {
            self.mapUIView = mapUIView
        }
        
        @objc func addAnnotation(gesture: UIGestureRecognizer) {
            
            if gesture.state == .ended {
                
                if let mapView = gesture.view as? MKMapView {
                    // Pick the location where user tapped based on the map view.
                    let location = gesture.location(in: mapView)
                    
                    // Transform this location to coordinates.
                    let coordinates = mapView.convert(location, toCoordinateFrom: mapView)
                    
                    // Create a new annotation object and pass to it its coordinates.
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinates
                    
                    // Remove previous annotations (just one is permitted).
                    if !mapView.annotations.isEmpty {
                        mapView.removeAnnotations(mapView.annotations.filter { $0 !== mapView.userLocation })
                    }
                    
                    // Add the coordinates to the map view.
                    mapView.addAnnotation(annotation)
                    
                    // Pass values to the view model (these values will be used later by external functions).
                    mapUIView.viewModel.destinationCoordinate = coordinates
                    mapUIView.viewModel.shouldChange = true
                    
                    // Remove previous routes (overlays). Just one can be shown.
                    removePreviousOverlays()
                }
            }
        }
        
        // This function checks if it has any stored overlays and removes it from the map view.
        func removePreviousOverlays() {
            let overlays = mapUIView.map.overlays
            
            if !overlays.isEmpty {
                self.mapUIView.map.removeOverlays(self.mapUIView.map.overlays)
            }
        }
        
        // Calls the function to retrieve the route.
        func retrieve(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
            retrieveRoute(origin: origin, destination: destination)
        }
        
        // Maps view function that is responsible to render overlays.
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
            render.strokeColor = .systemPurple
            
            return render
        }
        
        // Handles taps on the markers.
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            let geocoder = CLGeocoder()
            
            guard let latitude = view.annotation?.coordinate.latitude else {return}
            guard let longitude = view.annotation?.coordinate.longitude else {return}
            
            // This part of code is responsible to pick user-friendly informations of the location based on the latitude and longitude.
            DispatchQueue.main.async {
                geocoder.reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { placemarks, error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    
                    guard let placemark = placemarks?.first else {return}
                    
                    guard let placeName = placemark.name else {return}
                    
                    guard let placeRegion = placemark.administrativeArea else {return}
                    
                    guard let placeLocality = placemark.locality else {return}
                    
                    guard let placeCountry = placemark.country else {return}
                    
                    // Store the informations retrieved to use in the view.
                    self.mapUIView.adress = PlaceDetails(name: placeName, region: placeRegion, country: placeCountry, locality: placeLocality)
                    
                    // Calls the BottomSheet view and show these informations.
                    self.mapUIView.pinSelected.toggle()
                    
                }
            }
        }
        
        func retrieveRoute(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
            
            let originPlacemarker = MKPlacemark(coordinate: origin)
            let destinationPlacemarker = MKPlacemark(coordinate: destination)
            
            let originItem = MKMapItem(placemark: originPlacemarker)
            let destinationItem = MKMapItem(placemark: destinationPlacemarker)
            
            // Create an object to request directions and set its properties.
            let directionsRequest = MKDirections.Request()
            directionsRequest.source = originItem
            directionsRequest.destination = destinationItem
            directionsRequest.transportType = .any
            directionsRequest.requestsAlternateRoutes = false
            
            // Request directions.
            let directions = MKDirections(request: directionsRequest)
            directions.calculate { (response, error) in
                guard let response = response else {
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    return
                }
                
                // Remove previous overlays stored in the map.
                self.removePreviousOverlays()
                
                // Stores the first response.
                let route = response.routes[0]
                
                // Adds the overlay (route) and make it visible.
                self.mapUIView.map.addOverlay(route.polyline)
                self.mapUIView.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                
                // Sets pressed to false to stop retrieving directions.
                self.mapUIView.pressed = false
            }
            
        }
    }
}
