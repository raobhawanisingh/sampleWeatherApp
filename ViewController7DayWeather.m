//
//  ViewController7DayWeather.m
//  weatherApp
//
//  Created by Student 01 on 18/03/18.
//  Copyright © 2018 FelixIT. All rights reserved.
//

#import "ViewController7DayWeather.h"

@interface ViewController7DayWeather ()

@end

@implementation ViewController7DayWeather

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"7Day Weather";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:1521270000];
    NSLog(@"----%@",date);
    [self weather7Day];
    
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrayDaily.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if(cell==nil){
        cell = [[CellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
    }
    NSDictionary *details = [arrayDaily objectAtIndex:indexPath.row];
    double time = [[details valueForKey:@"time"] doubleValue];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"%@",date1);
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"dd/MMM/yyyy"];
    NSString *strdate = [format stringFromDate:date1];
    NSString *min = [NSString stringWithFormat:@"%0.2f C",((([[details valueForKey:@"temperatureMin"] floatValue]-32)*5)/9)];
    NSString *max = [NSString stringWithFormat:@"%0.2f C",((([[details valueForKey:@"temperatureMax"] floatValue]-32)*5)/9)];
    cell.mintemp.text = min;
    cell.maxtemp.text = max;
    cell.summery.text = [details valueForKey:@"summary"];
    cell.date.text = strdate;
    return cell;
}


- (void)weather7Day{
    [_activityIndicator startAnimating];
    NSString *apiStr = [NSString stringWithFormat:@"https://api.darksky.net/forecast/55b35cc93850c9f263eb10d8ddbd9634/%f,%f",_latitude,_logitude];
    NSURL *url = [NSURL URLWithString:apiStr];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activityIndicator stopAnimating];
            _activityIndicator.hidden = YES;
        });
        if(error){
            NSString *title = @"ERROR";
            [self alertMethod:title withMessage:error.localizedDescription];
        }else{
            NSError *jsonError;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            if(jsonError){
                NSString *title = @"JSONERROR";
                [self alertMethod:title withMessage:jsonError.localizedDescription];
            }else {
                NSLog(@"%@",dict);
                NSDictionary *dailyDict = [dict valueForKey:@"daily"];
                arrayDaily = [dailyDict valueForKey:@"data"];
                NSLog(@"%@",arrayDaily);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
                
                
            }
        }
    }];
    [dTask resume];
}

- (void)alertMethod:(NSString *)title withMessage:(NSString *)message{
    UIAlertController *alertc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alertc addAction:action];
    [self presentViewController:alertc animated:YES completion:nil];
    
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
