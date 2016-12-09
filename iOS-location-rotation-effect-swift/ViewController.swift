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
    var _record:CLLocationCoordinate2D
    
    required init?(coder aDecoder: NSCoder) {
        self._record = CLLocationCoordinate2DMake(0, 0)
        super.init(coder: aDecoder)
        
    }
    
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay.isEqual(mapView.userLocationAccuracyCircle) {
            let accuracyCircleRender:MACircleRenderer! = MACircleRenderer.init(circle: overlay as! MACircle!)
            
            accuracyCircleRender.lineWidth = 2.0
            accuracyCircleRender.strokeColor = UIColor.lightGray
            accuracyCircleRender.fillColor = UIColor.init(colorLiteralRed: 1, green: 0, blue: 0, alpha: 0.3)
            
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
            }
            
            annotationView.image = UIImage(named: "userPosition")
            annotationView.canShowCallout = true
            _locationAnnotationView = annotationView as! LocationAnnotationView
            
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        if !updatingLocation && _locationAnnotationView != nil {
            UIView.animate(withDuration: 0.1, animations: { 
                self._locationAnnotationView.rotateDegree = CGFloat(userLocation.heading.trueHeading) - mapView.rotationDegree
            })
        }
        
        if _record.latitude != userLocation.coordinate.latitude || _record.longitude != userLocation.coordinate.longitude {
            _record = userLocation.coordinate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AMapServices.shared().enableHTTPS = true
        
        _mapView = MAMapView(frame: view.bounds)
        _mapView.delegate = self
        _mapView.customizeUserLocationAccuracyCircleRepresentation = true
        
        _mapView.zoomLevel = 18
        _mapView.userTrackingMode = .follow
        
        
        
        view.addSubview(_mapView)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

