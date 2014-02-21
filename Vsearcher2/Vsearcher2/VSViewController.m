//
//  VSViewController.m
//  Vsearcher2
//
//  Created by Fabre Jean-baptiste on 20/02/14.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import "VSViewController.h"
#import "VSMasterCollectionViewCell.h"
#import "VSHeaderView.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "VSSecondLevelViewController.h"

@interface VSViewController () <UISearchBarDelegate, UISearchDisplayDelegate>

@end

@implementation VSViewController

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
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(newReleaseOfObject:) name:@"masterReleaseFound"
                                               object:Nil];
    
    [VSObjectSearchList searchObjectDelegate:self];
    [VSObjectSearchList searchInDiscogsDBWithString:@"c2c"];
}

- (void)newReleaseOfObject:(NSNotification *)n {
    NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc] init];
    [mutableIndexSet addIndex:[VSObjectSearchList indexForMasterWithID:[n.object integerValue]]];
    [self.collectionView reloadSections:mutableIndexSet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchObjectEndSearch:(BOOL)nextPage{
    NSLog(@"%d master found",[VSObjectSearchList masterCount]);
    [self.collectionView reloadData];
}
-(void)searchObjectFailSearch:(BOOL)nextPage withError:(NSString *)error{
    NSLog(@"%@",error);
}
-(void)searchObjectStartSearch:(BOOL)nextPage{
    
}


#pragma mark collection view

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [VSObjectSearchList releaseCountForMasterAtIndex:section];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [VSObjectSearchList masterCount];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ResultCellIdentifier = @"ResultCellIdentifier";
    VSReleaseObject *release = [VSObjectSearchList releaseObjectAtIndex:indexPath];
    VSMasterCollectionViewCell *resultCell = (VSMasterCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:ResultCellIdentifier forIndexPath:indexPath];
    [resultCell.image setImageWithURL:[release pixogsURLOfRelease]];
    return resultCell;
    
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
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

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)){
        [VSObjectSearchList nextPage];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}

@end
