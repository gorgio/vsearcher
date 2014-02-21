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

@property (nonatomic, retain) NSMutableArray *scopeButton; // tableau qui contient les scopes de la barre de recherche

@end

@implementation VSCollectionViewController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.scopeButton = [NSMutableArray arrayWithObjects:@"Flags", @"Listeners", @"Stations", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [VSObjectSearchList searchObjectDelegate:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource



- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    if(section == 0) { // section 0 : barre de recherche
        return 1;
    }
    else if (section == 1) {
        return [VSObjectSearchList releaseCount];
    }
    return 1;
}



- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 2; // deux section : une pour la recherche, une pour le résultat
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *SearchCellIdentifier = @"SearchCellIdentifier";
    static NSString *ResultCellIdentifier = @"ResultCellIdentifier";
    
    if (indexPath.section == 0) // si on est dans la section recherche
    {
       VSSearchCollectionViewCell *searchCell = (VSSearchCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:SearchCellIdentifier forIndexPath:indexPath];
        searchCell.searchBar.placeholder = @"Recherche d'album par titre, n° catalogue...";
        searchCell.searchBar.scopeButtonTitles = [NSMutableArray arrayWithObjects:@"Flags", @"Listeners", @"Stations", nil];
        searchCell.searchBar.showsScopeBar = YES;
        
        return searchCell;
    }
    else{
        VSResultCollectionViewCell *resultCell = (VSResultCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:ResultCellIdentifier forIndexPath:indexPath];
        VSReleaseObject *release = [VSObjectSearchList releaseObjectAtIndex:indexPath];
        resultCell.thumb.image = [UIImage imageNamed:@"photo1"];
        return resultCell;
    }

}

#pragma mark UISearchBar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [VSObjectSearchList searchInDiscogsDBWithString:searchBar.text];
    
}


#pragma mark UISearchDisplay delegate

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
}

#pragma mark VSSearchList Delegate

-(void)searchObjectStartSearch:(BOOL)nextPage{
    if(nextPage){
        NSLog(@"new page");
    }
    else{
        NSLog(@"first page");
    }
}

-(void)searchObjectFailSearch:(BOOL)nextPage withError:(NSString *)error{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"DISCOGS" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(void)searchObjectEndSearch:(BOOL)nextPage{
    [self.collectionView reloadData];
}

@end

