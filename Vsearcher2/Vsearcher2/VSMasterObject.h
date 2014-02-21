//
//  VSMasterObject.h
//  Vsearcher
//
//  Created by Fabre Jean-baptiste on 20/02/14.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "VSReleaseObject.h"

@interface VSMasterObject : NSObject<ASIHTTPRequestDelegate>{
    NSInteger masterID; //id de la master
    
    NSString *masterTitle; //titre de la master
    NSString *masterCountryName; //pays de sortie de la master
    NSString *masterYear; // année de sortie de la master
    NSString *masterCatNum; //cat number de la master
    
    NSMutableArray *masterStyles; //styles de la master
    NSMutableArray *masterGenres; //genres de la master
    NSMutableArray *masterFormat; //formats de la master
    
    
    NSString *masterDataURL; //url des resources de la master
    NSString *masterWebURL; //url de la master sur le site web discogs
    NSString *masterThumbURL; // url de l'image thumb de la master
    
    NSString *masterMasterDataURl; //url des resources de la master
    
    NSMutableArray *masterLabelNames;
}

@property(nonatomic,retain) NSMutableArray *masterReleases;

-(id)initMasterObjectWithDictionary:(NSDictionary*)masterDictionary;

-(void)getReleaseOfMaster;

-(NSInteger)releaseCount;

-(NSString*)masterTitle;

-(NSString*)masterCountry;

-(NSString*)masterDateFormated;

-(VSReleaseObject*)relaseObjectAtIndex:(NSInteger)index;
@end
