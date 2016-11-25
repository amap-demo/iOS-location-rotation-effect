//
//  LocationAnnotationView.m
//  iOS-location-rotation-effect
//
//  Created by 翁乐 on 25/11/2016.
//  Copyright © 2016 Autonavi. All rights reserved.
//

#import "LocationAnnotationView.h"

@implementation LocationAnnotationView
    
@synthesize rotateDegree = _rotateDegree;


-(void)setRotateDegree:(CGFloat)rotateDegree
{
    self.transform = CGAffineTransformMakeRotation(rotateDegree * M_PI / 180.f );
}

    
@end
