//
//  CellTableViewCell.h
//  weatherApp
//
//  Created by Student 01 on 18/03/18.
//  Copyright © 2018 FelixIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *mintemp;
@property (strong, nonatomic) IBOutlet UILabel *maxtemp;
@property (strong, nonatomic) IBOutlet UILabel *summery;

@end
