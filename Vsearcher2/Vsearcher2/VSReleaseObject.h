//
//  VSReleaseObject.h
//  Vsearcher
//
//  Created by Fabre Jean-baptiste on 19/02/14.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSReleaseObject : NSObject{
    NSInteger releaseID; //id de la release
    NSInteger releaseMasterID; // id du master
    NSInteger releaseHave; // nombre de personnes qui possèdent la release
    NSInteger releaseWant; // nombre de personnes qui veulent la release
    NSInteger releaseRatingCount; // nombre de personnes qui ont notés la  release
    NSInteger releaseRate; // note de la release
    
    NSString *releaseTitle; //titre de la release
    NSString *releaseCountryName; //pays de sortie de la release
    NSDate   *releaseDate; // date de sortie de la release
    NSString *releaseYear; // année de sortie de la release
    NSString *releaseNote; // note en rapport avec la release
    NSString *releaseCatNum; //cat number de la release
    
    NSMutableArray *artistes; // artistes de la release
    NSMutableArray *releaseStyles; //styles de la release
    NSMutableArray *releaseGenres; //genres de la release
    NSMutableArray *releaseFormat; //formats de la release
    
    NSString *releaseDataURL; //url des resources de la release
    NSString *releaseWebURL; //url de la release sur le site web discogs
    NSString *releaseThumbURL; // url de l'image thumb de la release
    NSString *releaseImage1URL; //url de l'image 1 de la release
    NSString *releaseImage2URL; // url de l'image 2 de la release
    
    NSString *releaseMasterDataURl; //url des resources de la master
    
    NSString *releaseStatus; //state de la release
    NSString *releaseQuality; //qualité de la release
    
    NSMutableArray *releaseLabelNames;

    
    NSString *companiesCat;
    NSString *companiesName;
    NSString *companiesType;
    NSString *companiesDataUrl;
}

-(id)initReleaseObjectWithDictionary:(NSDictionary*)releaseDictionary;

-(NSURL*)pixogsURLOfRelease;

-(NSString*)releaseCatNum;

-(NSString*)releaseDateFormat;

-(NSString*)releaseTitle;
@end
