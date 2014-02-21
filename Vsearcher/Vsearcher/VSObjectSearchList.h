//
//  VSObjectSearchList.h
//  Vsearcher
//
//  Created by Fabre Jean-baptiste on 19/02/14.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import <Foundation/Foundation.h>
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
}
@property(nonatomic,assign) id<VSSearchDelegate> delegate;


///////////////////////
// ACCES METHODES    //
///////////////////////
+(void)searchInDiscogsDBWithString:(NSString*)searchString; // permet de faire une recherche dans la bdd pour le nom d'une release

+(VSReleaseObject*)releaseObjectAtIndex:(NSIndexPath*)indexPath; // permet d'obtenir une release en fonction d'un indexPath (section n'est pas prise en compte)

+(NSInteger)releaseCount; //indique le nombre de releases dans la liste (chargés)

+(void)nextPage; // permet de lancer le chargement de la page suivante

+(void)searchObjectDelegate:(id)delegate; // important la recherche ne fonctionne pas si non

+(NSInteger)searchResultNumberFound;// indique le nombre de release total (toute le pages)

+(NSInteger)searchResultPage;// indique le nombre de page total

+(NSInteger)searchResultActualPage; // indique le numero de la page actuelle

///////////////////////
//       INIT        //
///////////////////////
-(id)init;



@end