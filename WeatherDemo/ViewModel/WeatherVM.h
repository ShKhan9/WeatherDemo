//
//  WeatherViewModel.h
//  WeatherDemo
//
//  Created by MacBook Pro on 9/3/21.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionBlock)(NSDictionary* _Nullable result);

NS_ASSUME_NONNULL_BEGIN

@interface WeatherVM : NSObject
 
-(void) getWeatherDataFor:(NSString*)cityName completionAction:(CompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
