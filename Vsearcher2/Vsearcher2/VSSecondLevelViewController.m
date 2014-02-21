//
//  VSSecondLevelViewController.m
//  Vsearcher2
//
//  Created by Fabre Jean-baptiste on 21/02/14.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import "VSSecondLevelViewController.h"
#import "VSThirdViewController.h"
#import "VSMasterCollectionViewCell.h"
#import "VSHeaderView.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "VSSecondViewCell.h"

@interface VSSecondLevelViewController ()

@end

@implementation VSSecondLevelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"here");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [VSObjectSearchList releaseCountForMasterAtIndex:section];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [VSObjectSearchList masterCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ResultCellIdentifier = @"ResultCellIdentifier2";
    VSReleaseObject *release = [VSObjectSearchList releaseObjectAtIndex:indexPath];
    VSSecondViewCell *resultCell = (VSSecondViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:ResultCellIdentifier forIndexPath:indexPath];
    [resultCell.imageView setImageWithURL:[release pixogsURLOfRelease]];
    resultCell.catNo.text = [release releaseCatNum];
    resultCell.year.text = [release releaseDateFormat];
    resultCell.title.text = [release releaseTitle];
    return resultCell;
    
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        VSHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
        VSMasterObject *master = [VSObjectSearchList masterObjectAtIndex:indexPath.section];
        
        headerView.title.text = [master masterTitle];
        headerView.country.text = [master masterCountry];
        headerView.year.text = [master masterDateFormated];
        reusableview = headerView;
    }
    return reusableview;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    VSThirdViewController *viewController = segue.destinationViewController;
}

@end
