//
//  ViewController16dayweather.m
//  weatherApp
//
//  Created by Student 01 on 11/03/18.
//  Copyright © 2018 FelixIT. All rights reserved.
//

#import "ViewController16dayweather.h"

@interface ViewController16dayweather ()

@end

@implementation ViewController16dayweather

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"16Day Weather";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:1521270000];
    NSLog(@"----%@",date);
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
