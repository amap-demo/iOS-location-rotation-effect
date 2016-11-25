本工程主要介绍了 高德地图iOS SDK 3D版本 在基于地图的定位图标旋转
## 前述 ##

- [高德官方网站申请key](http://id.amap.com/?ref=http%3A%2F%2Fapi.amap.com%2Fkey%2F).
- 阅读[开发指南](http://lbs.amap.com/api/ios-sdk/summary/).
- 工程基于iOS 3D地图SDK实现

## 功能描述 ##
自定义定位类，会更随手机定位角度进行旋转

## 核心类/接口 ##
| 类    | 接口  | 说明   | 版本  |
| -----|:-----:|:-----:|:-----:|
| LocationAnnotationView	| rotateDegree | 继承自MAAnnotationView | ---- |

## 核心难点 ##

``` objc

///定位回调
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!updatingLocation && _locationAnnotationView != nil)
    {
    [UIView animateWithDuration:0.1 animations:^{
    _locationAnnotationView.rotateDegree = userLocation.heading.trueHeading - _mapView.rotationDegree;
    }];
    }

    if (_record.latitude != userLocation.coordinate.latitude || _record.longitude != userLocation.coordinate.longitude) {
        NSLog(@"changed");
        _record = userLocation.coordinate;
    }
}

```
