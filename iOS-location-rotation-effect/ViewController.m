//
//  ViewController.m
//  iOS-location-rotation-effect
//
//  Created by 翁乐 on 25/11/2016.
//  Copyright © 2016 Autonavi. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "LocationAnnotationView.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface ViewController ()<MAMapViewDelegate>
{
    MAMapView *_mapView;
    LocationAnnotationView *_locationAnnotationView;
}
    
@end

@implementation ViewController


- (void)mapViewRequireLocationAuth:(CLLocationManager *)locationManager {
    [locationManager requestAlwaysAuthorization];
}
    
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    /* 自定义定位精度对应的MACircleView. */
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        accuracyCircleRenderer.lineWidth    = 2.f;
        accuracyCircleRenderer.strokeColor  = [UIColor lightGrayColor];
        accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        return accuracyCircleRenderer;
    }
    
    return nil;
}
    
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    /* 自定义userLocation对应的annotationView. */
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[LocationAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
            
            annotationView.canShowCallout = YES;
        }
        
        _locationAnnotationView = (LocationAnnotationView *)annotationView;
        [_locationAnnotationView updateImage:[UIImage imageNamed:@"userPosition"]];
        
        return annotationView;
    }
        
    return nil;
}
    
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!updatingLocation && _locationAnnotationView != nil)
    {
        _locationAnnotationView.rotateDegree = userLocation.heading.trueHeading - _mapView.rotationDegree;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    
    [self.view addSubview:_mapView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
}

@end
