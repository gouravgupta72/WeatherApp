//
//  weatherCell.m
//  weatherInfo
//
//  Created by Mac Book on 30/04/14.
//  Copyright (c) 2014 Gourav Gupta. All rights reserved.
//

#import "weatherCell.h"

@implementation weatherCell
@synthesize lblDate,lblMaxTemp,lblMinTemp,lblCity;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Delegate:(id)del tag:(int)tagValue
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        lblDate = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 120, 20)];
        lblDate.textColor = [UIColor blueColor];
        lblDate.textAlignment = NSTextAlignmentLeft;
        lblDate.backgroundColor = [UIColor clearColor];
        [self addSubview:lblDate];
        
        lblCity = [[UILabel alloc]initWithFrame:CGRectMake(130, 5, 180, 20)];
        lblCity.textColor = [UIColor redColor];
        lblCity.textAlignment = NSTextAlignmentRight;
        lblCity.backgroundColor = [UIColor clearColor];
        [self addSubview:lblCity];
        
        lblMaxTemp = [[UILabel alloc]initWithFrame:CGRectMake(5, 30, 120, 20)];
        lblMaxTemp.textColor = [UIColor blackColor];
        lblMaxTemp.textAlignment = NSTextAlignmentLeft;
        lblMaxTemp.backgroundColor = [UIColor clearColor];
        [self addSubview:lblMaxTemp];
        
        lblMinTemp = [[UILabel alloc]initWithFrame:CGRectMake(130, 30, 180, 20)];
        lblMinTemp.textColor = [UIColor blackColor];
        lblMinTemp.textAlignment = NSTextAlignmentRight;
        lblMinTemp.backgroundColor = [UIColor clearColor];
        [self addSubview:lblMinTemp];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
