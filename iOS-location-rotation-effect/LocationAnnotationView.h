//
//  LocationAnnotationView.h
//  iOS-location-rotation-effect
//
//  Created by 翁乐 on 25/11/2016.
//  Copyright © 2016 Autonavi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface LocationAnnotationView : MAAnnotationView

@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, assign) CGFloat rotateDegree;

- (void)updateImage:(UIImage *)image;

@end
