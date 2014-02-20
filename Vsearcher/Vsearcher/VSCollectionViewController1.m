//
//  VSCollectionViewController1.m
//  Vsearcher
//
//  Created by Élèves on 19/02/2014.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import "VSCollectionViewController1.h"
#import "VSSearchCollectionViewCell.h"
#import "VSResultCollectionViewCell.h"

@interface VSCollectionViewController1 () <UISearchBarDelegate, UISearchDisplayDelegate>

@property(nonatomic)NSInteger firstCell;

@end

@implementation VSCollectionViewController1

@synthesize searchBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.firstCell = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SearchCellIdentifier = @"SearchCellIdentifier";
    static NSString *ResultCellIdentifier = @"ResultCellIdentifier";
    UICollectionViewCell *cell;
    if (self.firstCell == 0)
    {
        cell = [cv dequeueReusableCellWithReuseIdentifier:SearchCellIdentifier forIndexPath:indexPath];
        self.firstCell++;
    }
    else
        cell = [cv dequeueReusableCellWithReuseIdentifier:ResultCellIdentifier forIndexPath:indexPath];

    return cell;
}

#pragma mark UISearchBar delegate



#pragma mark UISearchDisplay delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}


@end

