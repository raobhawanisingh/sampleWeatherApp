//
//  ViewController.h
//  weatherApp
//
//  Created by Student 01 on 11/03/18.
//  Copyright © 2018 FelixIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ViewController16dayweather.h"


@interface ViewController : UIViewController<CLLocationManagerDelegate>{
    CLLocationManager *loctnManager;
}
@property (strong, nonatomic) IBOutlet UILabel *templbl;
@property (strong, nonatomic) IBOutlet MKMapView *MapKit;
@property (strong, nonatomic) IBOutlet UILabel *minTemplbl;
@property (strong, nonatomic) IBOutlet UILabel *citylbl;

- (IBAction)btnWeatherAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *maxTemplbl;
@property (strong, nonatomic) IBOutlet UILabel *discirption;

@end

