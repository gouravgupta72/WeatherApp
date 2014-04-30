//
//  ViewController.h
//  weatherInfo
//
//  Created by Mac Book on 29/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Request.h"
#import "weatherCell.h"
#import "weatherDataClass.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<RequestDelegate,CLLocationManagerDelegate>
{
    Request *reqObj;
    NSMutableArray *arrWeatherInfo;
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}
@property (strong, nonatomic) IBOutlet UISearchBar *searchTab;
@property (strong, nonatomic) IBOutlet UITableView *tblWeather;
@end
