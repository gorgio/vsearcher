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
}

/*


 "community": {
 "have": 272, ok
 "want": 177, ok
 "rating": {
 "count": 81, OK
 "average": 4.48 OK
 },
 "labels": [
 {
 "entity_type": "1",
 "catno": "SK032",
 "id": 5,
 "entity_type_name": "Label",
 "name": "Svek"
 "resource_url": "http://api.discogs.com/labels/5"
 }
 ],
 "companies": [
 {
 "entity_type": "23",
 "catno": "",
 "id": 271046,
 "entity_type_name": "Recorded At",
 "name": "The Globe Studios",
 "resource_url": "http://api.discogs.com/labels/271046"
 }
 ]
 "artists": [
 {
 "id": 1,
 "tracks": "",
 "role": "",
 "anv": "",
 "join": "",
 "name": "Persuader, The",
 "resource_url": "http://api.discogs.com/artists/1"
 }
 ],

 
 
 }
 */

@end
