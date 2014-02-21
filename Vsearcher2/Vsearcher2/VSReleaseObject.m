//
//  VSReleaseObject.m
//  Vsearcher
//
//  Created by Fabre Jean-baptiste on 19/02/14.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import "VSReleaseObject.h"

@implementation VSReleaseObject
/*
 NSInteger releaseID; //id de la release
 NSInteger masterID; // id du master
 NSInteger releaseHave; // nombre de personnes qui possèdent la release
 NSInteger releaseWant; // nombre de personnes qui veulent la release
 NSInteger ratingCount; // nombre de personnes qui ont notés la  release
 NSInteger releaseRate; // note de la release
 
 NSString *title; //titre de la release
 NSString *countryName; //pays de sortie de la release
 NSDate   *releaseDate; // date de sortie de la release
 NSString *releaseNote; // note en rapport avec la release
 NSMutableArray *artistes; // artistes de la release
 NSMutableArray *releaseStyles; //styles de la release
 NSMutableArray *releaseGenres; //genres de la release
 NSMutableArray *releaseFormat; //formats de la release
 
 NSString *releaseDataURL; //url des resources de la release
 NSString *releaseWebURL; //url de la release sur le site web discogs
 NSString *releaseImage1URL; //url de l'image 1 de la release
 NSString *releaseImage2URL; // url de l'image 2 de la release
 
 NSString *masterDataURl; //url des resources de la master
 
 NSString *releaseStatus; //state de la release
 NSString *releaseQuality; //qualité de la release
 
 NSString *labelCat;
 NSString *labelName;
 NSString *labelType;
 NSString *labelDataUrl;
 
 NSString *companiesCat;
 NSString *companiesName;
 NSString *companiesType;
 NSString *companiesDataUrl;

 */
-(id)initReleaseObjectWithDictionary:(NSDictionary*)releaseDictionary{
    self = [super init];
    if (self) {
        releaseID = [[releaseDictionary objectForKey:@"id"] integerValue];
        releaseCountryName = [releaseDictionary objectForKey:@"country"];
        if([releaseDictionary objectForKey:@"released"]){
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd";
            releaseDate = [formatter dateFromString:[releaseDictionary objectForKey:@"released"]];
        }
//        releaseStyles = [[NSMutableArray alloc]initWithArray:[releaseDictionary objectForKey:@"style"]];
//        releaseGenres = [[NSMutableArray alloc]initWithArray:[releaseDictionary objectForKey:@"genre"]];
        releaseFormat = [[NSMutableArray alloc]initWithArray:[[releaseDictionary objectForKey:@"format"] componentsSeparatedByString:@","]];
        releaseTitle = [releaseDictionary objectForKey:@"title"];
        releaseCatNum = [releaseDictionary objectForKey:@"catno"];
        releaseThumbURL = [releaseDictionary objectForKey:@"thumb"];
        releaseDataURL = [releaseDictionary objectForKey:@"resource_url"];
        releaseLabelNames = [releaseDictionary objectForKey:@"label"];
    }
    return self;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"Release ID: %d Title: %@ Country: %@ Year: %@",releaseID,releaseTitle,releaseCountryName,releaseYear];
}

-(NSURL*)pixogsURLOfRelease{
    NSString *thumbID = [[releaseThumbURL componentsSeparatedByString:@"/"] lastObject];
    NSString *url = [NSString stringWithFormat:@"http://s.pixogs.com/image/%@",thumbID];
    return [NSURL URLWithString:url];
}

-(NSString*)releaseCatNum{
    return releaseCatNum;
}

-(NSString*)releaseDateFormat{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:releaseDate];
}

-(NSString*)releaseTitle{
    return releaseTitle;
}
@end
