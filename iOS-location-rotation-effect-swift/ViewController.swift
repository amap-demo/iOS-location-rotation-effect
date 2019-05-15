//
//  ViewController.swift
//  iOS-location-rotation-effect-swift
//
//  Created by 翁乐 on 09/12/2016.
//  Copyright © 2016 Autonavi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MAMapViewDelegate {

    var _mapView:MAMapView!
    var _locationAnnotationView:LocationAnnotationView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func mapViewRequireLocationAuth(_ locationManager: CLLocationManager!) {
        locationManager.requestAlwaysAuthorization()
    }
    
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay.isEqual(mapView.userLocationAccuracyCircle) {
            let accuracyCircleRender:MACircleRenderer! = MACircleRenderer.init(circle: overlay as! MACircle!)
            
            accuracyCircleRender.lineWidth = 2.0
            accuracyCircleRender.strokeColor = UIColor.lightGray
            accuracyCircleRender.fillColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.3)
            
            return accuracyCircleRender
        }
        
        return nil
    }
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKind(of: MAUserLocation.self) {
            let userLocationStyleReuseIndetifier = "userLocationStyleReuseIndetifier"
            
            var annotationView:MAAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: userLocationStyleReuseIndetifier)
            
            if annotationView == nil {
                annotationView = LocationAnnotationView(annotation: annotation, reuseIdentifier: userLocationStyleReuseIndetifier)
                annotationView.canShowCallout = true
            }
            
            _locationAnnotationView = annotationView as! LocationAnnotationView
            _locationAnnotationView.updateImage(image: UIImage(named: "userPosition"))
   
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        if !updatingLocation && _locationAnnotationView != nil {
            self._locationAnnotationView.rotateDegree = CGFloat(userLocation.heading.trueHeading) - mapView.rotationDegree
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AMapServices.shared().enableHTTPS = true
        
        _mapView = MAMapView(frame: view.bounds)
        _mapView.delegate = self
        _mapView.customizeUserLocationAccuracyCircleRepresentation = true
        
        view.addSubview(_mapView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _mapView.userTrackingMode = .follow
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

