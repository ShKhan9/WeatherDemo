//
//  WeatherViewModel.m
//  WeatherDemo
//
//  Created by MacBook Pro on 9/3/21.
//

#import "WeatherVM.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
const NSString* apiKey = @"f5cb0b965ea1564c50c6f1b74534d823";
@implementation WeatherVM

-(void) getWeatherDataFor:(NSString*)cityName completionAction:(CompletionBlock)completion{
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString* urlStr = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@",cityName,apiKey];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:urlStr parameters:NULL headers:NULL progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable results) {
       // NSLog(@" operation.responseData  %@",results);
    
        id weather = [[results objectForKey:@"weather"] objectAtIndex:0];

        NSNumber* date  = [results objectForKey:@"dt"];
        
        NSNumber* cityId  = [results objectForKey:@"id"];
        
        NSString* description  = [weather objectForKey:@"description"];
        
       NSString* icon  = [weather objectForKey:@"icon"];
     //  NSString* iconId  = [weather objectForKey:@"id"];
       NSString* main  = [weather objectForKey:@"main"];
       
//        NSLog(@"description==%@",description);
//
//        NSLog(@"icon==%@",icon);
//
//      //  NSLog(@"iconId==%@",iconId);
//
//        NSLog(@"id==%@",main);
 
        NSNumber* speed = [[results objectForKey:@"wind"] objectForKey:@"speed"];
        
        NSNumber* temp = [[results objectForKey:@"main"] objectForKey:@"temp"];

        NSNumber* humidity = [[results objectForKey:@"main"] objectForKey:@"humidity"];

//        NSLog(@"speed==%@",speed);
//
//        NSLog(@"temp==%@",temp);
//
//        NSLog(@"humidity==%@",humidity);
//
//        NSLog(@"date==%@",date);
        
        NSDictionary*dic = @{@"description":description,@"icon":icon,@"iconId":icon,
                             @"speed":speed.stringValue,@"temp":temp.stringValue,@"humidity":humidity.stringValue,@"date":date.stringValue,@"cityId":cityId.stringValue};
        
        // NSData*data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingFragmentsAllowed error:NULL];
        completion(dic);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(NULL);
        [SVProgressHUD dismiss];
    }];
    
}

@end
