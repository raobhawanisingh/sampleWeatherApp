//
//  ViewController.m
//  weatherApp
//
//  Created by Student 01 on 11/03/18.
//  Copyright © 2018 FelixIT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Current Weather";
    //NSString *weatherApi = @"api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=9df7536494a4907549d7639b6b149364";
    [self getLocation];
    [self getPinPoint];
    [self getWeatherAPI];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)getLocation{
    loctnManager = [[CLLocationManager alloc]init];
    loctnManager.desiredAccuracy = kCLLocationAccuracyBest;
    loctnManager.distanceFilter = kCLDistanceFilterNone;
    loctnManager.delegate = self;
    [loctnManager requestAlwaysAuthorization];//Used for pop up for Authorization from user we have add privacy location in info.plist
    [loctnManager requestWhenInUseAuthorization];//Used for pop up for Authorization from user we have add privacy location in info.plist
    [loctnManager startUpdatingLocation];
    NSLog(@"lat:-%f----Long%f",loctnManager.location.coordinate.latitude,loctnManager.location.coordinate.longitude);
    
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_6, __MAC_NA, __IPHONE_2_0, __IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED{
    
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations __OSX_AVAILABLE_STARTING(__MAC_10_9,__IPHONE_6_0){
    
}
- (void)getPinPoint{
    [_MapKit setRegion:MKCoordinateRegionMakeWithDistance(loctnManager.location.coordinate, 1000, 1000) animated:YES];
    MKPointAnnotation *pinPoint = [[MKPointAnnotation alloc]init];
    pinPoint.coordinate = loctnManager.location.coordinate;
    pinPoint.title = @"I am Here";
    pinPoint.subtitle = @"Weather here is";
    [_MapKit addAnnotation:pinPoint];
}
- (void)getWeatherAPI{
    [_activity startAnimating];
   // NSString *weatherApi = @"api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=9df7536494a4907549d7639b6b149364";
    NSString *strURLApi = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=9df7536494a4907549d7639b6b149364",loctnManager.location.coordinate.latitude,loctnManager.location.coordinate.longitude];
    NSLog(@"%@",strURLApi);
    NSURL *url = [NSURL URLWithString:strURLApi];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *jsondata = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activity stopAnimating];
            _activity.hidden = YES;
        });
        [_activity stopAnimating];
        _activity.hidden = YES;
        if(error){
            NSString *title = @"ERROR";
            [self alertMethod:title withMessage:error.localizedDescription];
            NSLog(@"%@",error.localizedDescription);
        }else{
            NSError *jsonError;
            NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if(jsonError){
                NSString *title = @"JSONERROR";
                [self alertMethod:title withMessage:jsonError.localizedDescription];

                NSLog(@"%@",jsonError.localizedDescription);
            }
            else{
                NSLog(@"%@",dict);
                NSDictionary *main = [dict valueForKey:@"main"];
                float temp = [[main valueForKey:@"temp"]
                            floatValue];
                float tempmin = [[main valueForKey:@"temp_min"]floatValue];
                float tempmax = [[main valueForKey:@"temp_max"]floatValue];
                //NSDictionary *sys = [dict valueForKey:@"sys"];
                NSString *city =[dict valueForKey:@"name"];
                NSArray *weather = [dict valueForKey:@"weather"];
                NSDictionary *diss =[weather objectAtIndex:0];
                NSString *discrip = [diss valueForKey:@"description"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.templbl.text = [NSString stringWithFormat:@"%0.2f  C",temp/10];
                    self.citylbl.text = city;
                    self.minTemplbl.text = [NSString stringWithFormat:@"%0.2f C",tempmin/10];
                    self.maxTemplbl.text = [NSString stringWithFormat:@"%0.2f C",tempmax/10];
                    self.discirption.text = discrip;
                });
            }
        }
    }];
    [jsondata resume];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertMethod:(NSString *)title withMessage:(NSString *)message{
    UIAlertController *alertc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alertc addAction:action];
    [self presentViewController:alertc animated:YES completion:nil];

}

- (IBAction)btnWeatherAction:(id)sender {
    //float lat = loctnManager.location.coordinate.latitude;
    //float log = loctnManager.location.coordinate.longitude;
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController7DayWeather *vc = [story instantiateViewControllerWithIdentifier:@"7day"];
    vc.latitude = loctnManager.location.coordinate.latitude ;
     vc.logitude = loctnManager.location.coordinate.longitude;
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
