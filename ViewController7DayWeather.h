//
//  ViewController7DayWeather.h
//  weatherApp
//
//  Created by Student 01 on 18/03/18.
//  Copyright © 2018 FelixIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellTableViewCell.h"

@interface ViewController7DayWeather : UIViewController{
    NSArray *arrayDaily;
}
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (assign,nonatomic) float latitude,logitude;
@end
