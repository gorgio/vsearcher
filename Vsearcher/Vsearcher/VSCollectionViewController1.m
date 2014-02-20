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

@property(nonatomic,retain) NSMutableArray *data; // tableau qui contient toutes les données de résultat
@property (nonatomic, retain) NSMutableArray *scopeButton; // tableau qui contient les scopes de la barre de recherche

@end

@implementation VSCollectionViewController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.scopeButton = [NSMutableArray arrayWithObjects:@"Flags", @"Listeners", @"Stations", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [VSObjectSearchList searchObjectDelegate:self];


	// Do any additional setup after loading the view.
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
        //[VSObjectSearchList releaseCount];
        return [self.data count]; // section 1 : résultats
    }
    return 1;
}



- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 2; // deux section : une pour la recherche, une pour le résultat
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    VSSearchCollectionViewCell *searchCell;

    
    static NSString *SearchCellIdentifier = @"SearchCellIdentifier";
    static NSString *ResultCellIdentifier = @"ResultCellIdentifier";
    
    
    UICollectionViewCell *cell;
    
    
    if (indexPath.section == 0) // si on est dans la section recherche
    {
        searchCell = [collectionView dequeueReusableCellWithReuseIdentifier:SearchCellIdentifier forIndexPath:indexPath];
        searchCell.searchBar.placeholder = @"Recherche d'album par titre, n° catalogue...";
        searchCell.searchBar.scopeButtonTitles = [NSMutableArray arrayWithObjects:@"Flags", @"Listeners", @"Stations", nil];
        searchCell.searchBar.showsScopeBar = YES;
        
        cell = searchCell;
    }
    else // si on est dans la section résultat
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:ResultCellIdentifier forIndexPath:indexPath];

    
    return cell;
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
    if(!nextPage){
        [VSObjectSearchList nextPage];
    }
}

@end

