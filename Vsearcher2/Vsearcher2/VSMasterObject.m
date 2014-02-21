//
//  VSMasterObject.m
//  Vsearcher
//
//  Created by Fabre Jean-baptiste on 20/02/14.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import "VSMasterObject.h"

@implementation VSMasterObject
@synthesize masterReleases;
-(id)initMasterObjectWithDictionary:(NSDictionary*)masterDictionary{
    self = [super init];
    if (self) {
        masterID = [[masterDictionary objectForKey:@"id"] integerValue];
        masterCountryName = [masterDictionary objectForKey:@"country"];
        masterYear = [masterDictionary objectForKey:@"year"];
        masterStyles = [[NSMutableArray alloc]initWithArray:[masterDictionary objectForKey:@"style"]];
        masterGenres = [[NSMutableArray alloc]initWithArray:[masterDictionary objectForKey:@"genre"]];
        masterFormat = [[NSMutableArray alloc]initWithArray:[masterDictionary objectForKey:@"format"]];
        masterTitle = [masterDictionary objectForKey:@"title"];
        masterCatNum = [masterDictionary objectForKey:@"catno"];
        masterThumbURL = [masterDictionary objectForKey:@"thumb"];
        masterDataURL = [masterDictionary objectForKey:@"resource_url"];
        masterLabelNames = [masterDictionary objectForKey:@"label"];
    }
    return self;
}

-(NSString*)description{
    return [NSString stringWithFormat:@"master ID: %d Title: %@ Country: %@ Year: %@",masterID,masterTitle,masterCountryName,masterYear];
}

-(void)getReleaseOfMaster{
    ASIHTTPRequest *releaseRequest =[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.discogs.com/masters/%d/versions",masterID]]];
    [releaseRequest setDelegate:self];
    [releaseRequest setTag:0];
    [releaseRequest startAsynchronous];
}

-(NSError*)processSearchResultFound:(NSData*)data{
    NSError *error;
    NSDictionary *searchResultDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if(error){
        return error;
    }
    else{
        if([searchResultDictionary objectForKey:@"versions"]){
            NSArray *masterResult = [searchResultDictionary objectForKey:@"versions"];
            for (NSDictionary *masterDictionary in masterResult) {
                VSReleaseObject *releaseObject = [[VSReleaseObject alloc]initReleaseObjectWithDictionary:masterDictionary];
                if(!masterReleases){
                    masterReleases = [[NSMutableArray alloc]init];
                }
                [masterReleases addObject:releaseObject];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"masterReleaseFound" object:[NSNumber numberWithInt:masterID]];
    }
    return error;
}

-(NSInteger)releaseCount{
    return [masterReleases count];
}

-(NSString*)masterTitle{
    return masterTitle;
}

-(NSString*)masterCountry{
    return masterCountryName;
}
-(NSString*)masterDateFormated{
    return masterYear;
}

-(VSReleaseObject*)relaseObjectAtIndex:(NSInteger)index{
    if(index >= 0 && index < [masterReleases count]){
        return [masterReleases objectAtIndex:index];
    }
    else{
        return nil;
    }
}

///////////////////////
// ASI HTTP DELEGATE //
///////////////////////

-(void)requestStarted:(ASIHTTPRequest *)request{
    if(request.tag == 0){
        
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    if(request.tag == 0){
        NSLog(@"%@",[request responseStatusMessage]);
    }
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if(request.tag == 0){
        if([request responseStatusCode] == 200){
            [self processSearchResultFound:[request responseData]];
        }
        else{
            
        }
    }
}

@end
