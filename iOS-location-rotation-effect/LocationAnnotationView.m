//
//  LocationAnnotationView.m
//  iOS-location-rotation-effect
//
//  Created by 翁乐 on 25/11/2016.
//  Copyright © 2016 Autonavi. All rights reserved.
//

#import "LocationAnnotationView.h"

@interface LocationAnnotationView ()

@end

@implementation LocationAnnotationView

@synthesize rotateDegree = _rotateDegree;


- (UIImageView *)contentImageView
{
    if (_contentImageView == nil) {
        _contentImageView = [[UIImageView alloc] init];
        [self addSubview:_contentImageView];
    }
    
    return _contentImageView;
}

- (void)setRotateDegree:(CGFloat)rotateDegree
{
    self.contentImageView.transform = CGAffineTransformMakeRotation(rotateDegree * M_PI / 180.f );
}

- (void)updateImage:(UIImage *)image
{
    self.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    self.contentImageView.image = image;
    [self.contentImageView sizeToFit];
}
    
@end
