//
//  VSObjectSearchList.h
//  Vsearcher
//
//  Created by Fabre Jean-baptiste on 19/02/14.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSMasterObject.h"
#import "VSReleaseObject.h"
#import "ASIHTTPRequest.h"

@protocol VSSearchDelegate <NSObject>

-(void)searchObjectStartSearch:(BOOL)nextPage; // informe le controlleur qui la recherche commence et indique si on chagre une nouvelle page
-(void)searchObjectEndSearch:(BOOL)nextPage;   // informe le controlleur qui la recherche est finie et indique si on chagre une nouvelle page
-(void)searchObjectFailSearch:(BOOL)nextPage withError:(NSString*)error;  // informe le controlleur qui la recherche à echouée et indique si on chagre une nouvelle page

@end


@interface VSObjectSearchList : NSObject<ASIHTTPRequestDelegate>{
    NSMutableArray *searchResult;
    NSMutableArray *searchPagesURL;
    NSInteger searchResultNumberFound;
    NSInteger searchResultPage;
    NSInteger searchResultActualPage;
    BOOL loadNextPage;
}
@property(nonatomic,assign) id<VSSearchDelegate> delegate;


///////////////////////
// ACCES METHODES    //
///////////////////////
+(void)searchInDiscogsDBWithString:(NSString*)searchString; // permet de faire une recherche dans la bdd pour le nom d'une master

+(VSMasterObject*)masterObjectAtIndex:(NSInteger)indexPath; // permet d'obtenir une master en fonction d'un indexPath (section n'est pas prise en compte)
+(VSReleaseObject*)releaseObjectAtIndex:(NSIndexPath*)indexPath;

+(NSInteger)indexForMasterWithID:(NSInteger)masterID;

+(NSInteger)masterCount; //indique le nombre de masters dans la liste (chargés)

+(NSInteger)releaseCountForMasterAtIndex:(NSInteger)section;// indique le nombre de release chargées pour un master

+(void)nextPage; // permet de lancer le chargement de la page suivante

+(void)searchObjectDelegate:(id)delegate; // important la recherche ne fonctionne pas si non

+(NSInteger)searchResultNumberFound;// indique le nombre de master total (toute le pages)

+(NSInteger)searchResultPage;// indique le nombre de page total

+(NSInteger)searchResultActualPage; // indique le numero de la page actuelle

///////////////////////
//       INIT        //
///////////////////////
-(id)init;



@end