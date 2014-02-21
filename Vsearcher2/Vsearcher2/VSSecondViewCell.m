//
//  VSSecondViewCell.m
//  Vsearcher2
//
//  Created by Fabre Jean-baptiste on 21/02/14.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import "VSSecondViewCell.h"

@implementation VSSecondViewCell

@synthesize imageView;
@synthesize  title,year,catNo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
