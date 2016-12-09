//
//  LocationAnnotationView.swift
//  iOS-location-rotation-effect
//
//  Created by 翁乐 on 09/12/2016.
//  Copyright © 2016 Autonavi. All rights reserved.
//

import UIKit

class LocationAnnotationView: MAAnnotationView{
    var rotateDegree:CGFloat{
        set {
            self.transform = CGAffineTransform(rotationAngle: newValue * CGFloat(M_PI) / 180.0)
        }
        get {
            return self.rotateDegree
        }
    }
    
    override init!(annotation: MAAnnotation!, reuseIdentifier: String!) {
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.rotateDegree = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
