//
//  weatherDataClass.h
//  weatherInfo
//
//  Created by Mac Book on 30/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weatherDataClass : NSObject
{
    NSString *strDate, *strMin, *strMax, *strCity;
}
@property(nonatomic,retain) NSString *strDate, *strMin, *strMax, *strCity;
@end
