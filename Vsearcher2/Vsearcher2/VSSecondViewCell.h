//
//  VSSecondViewCell.h
//  Vsearcher2
//
//  Created by Fabre Jean-baptiste on 21/02/14.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSSecondViewCell : UICollectionViewCell

@property(nonatomic,retain) IBOutlet UIImageView *imageView;
@property(nonatomic,retain) IBOutlet UILabel *title,*year,*catNo;

@end
