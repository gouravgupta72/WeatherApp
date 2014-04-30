//
//  weatherCell.h
//  weatherInfo
//
//  Created by Mac Book on 30/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface weatherCell : UITableViewCell
{
    UILabel *lblDate, *lblMaxTemp, *lblMinTemp, *lblCity;
}
@property(nonatomic,retain)UILabel *lblDate, *lblMaxTemp, *lblMinTemp, *lblCity;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Delegate:(id)del tag:(int)tagValue;
@end
