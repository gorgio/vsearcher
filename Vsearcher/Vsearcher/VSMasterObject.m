//
//  VSMasterObject.m
//  Vsearcher
//
//  Created by Fabre Jean-baptiste on 20/02/14.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import "VSMasterObject.h"

@implementation VSMasterObject

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
        masterReleases = [[NSMutableArray alloc]init];
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

///////////////////////
// ASI HTTP DELEGATE //
///////////////////////

-(void)requestStarted:(ASIHTTPRequest *)request{
    if(request.tag == 0){
        
    }
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    if(request.tag == 0){
        
    }
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    if(request.tag == 0){
        NSLog(@"%@",[request responseString]);
    }
}

@end
