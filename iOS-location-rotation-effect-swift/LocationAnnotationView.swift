//
//  LocationAnnotationView.swift
//  iOS-location-rotation-effect
//
//  Created by 翁乐 on 09/12/2016.
//  Copyright © 2016 Autonavi. All rights reserved.
//

import UIKit

class LocationAnnotationView: MAAnnotationView {
    
    var contentImageView: UIImageView!
    
    var rotateDegree:CGFloat{
        set {
            self.contentImageView.transform = CGAffineTransform(rotationAngle: newValue * CGFloat(M_PI) / 180.0)
        }
        get {
            return self.rotateDegree
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init!(annotation: MAAnnotation!, reuseIdentifier: String!) {
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.contentImageView = UIImageView()
        self.addSubview(self.contentImageView)
        self.rotateDegree = 0
    }

    func updateImage(image: UIImage!) {
        
        self.bounds = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        self.contentImageView.image = image
        self.contentImageView.sizeToFit()
    }
    
    
}
