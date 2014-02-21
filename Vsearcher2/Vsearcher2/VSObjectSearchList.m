//
//  VSObjectSearchList.m
//  Vsearcher
//
//  Created by Fabre Jean-baptiste on 19/02/14.
//  Copyright (c) 2014 EMSE ES. All rights reserved.
//

#import "VSObjectSearchList.h"

@implementation NSString (URLEncode)

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}


@end

@implementation VSObjectSearchList

static VSObjectSearchList *sharedSearchList;

@synthesize delegate;

///////////////////////
// ACCES METHODES    //
///////////////////////


+(void)searchInDiscogsDBWithString:(NSString*)searchString{
    if(sharedSearchList == nil) sharedSearchList = [[VSObjectSearchList alloc]init];
    [sharedSearchList searchInDiscogsDBWithString:searchString];
}

+(VSMasterObject*)masterObjectAtIndex:(NSInteger)indexPath{
    if(sharedSearchList == nil) sharedSearchList = [[VSObjectSearchList alloc]init];
    return [sharedSearchList masterObjectAtIndex:indexPath];
}

+(NSInteger)masterCount{
    if(sharedSearchList == nil) sharedSearchList = [[VSObjectSearchList alloc]init];
    return [sharedSearchList masterCount];
}

+(NSInteger)indexForMasterWithID:(NSInteger)masterID{
    if(sharedSearchList == nil) sharedSearchList = [[VSObjectSearchList alloc]init];
    return [sharedSearchList indexForMasterID:masterID];
}

+(NSInteger)releaseCountForMasterAtIndex:(NSInteger)section{
    if(sharedSearchList == nil) sharedSearchList = [[VSObjectSearchList alloc]init];
    return [[sharedSearchList masterObjectAtIndex:section] releaseCount];
}

+(void)nextPage{
    if(sharedSearchList == nil) sharedSearchList = [[VSObjectSearchList alloc]init];
    [sharedSearchList nextPage];
}

+(void)searchObjectDelegate:(id)delegate{
    if(sharedSearchList == nil) sharedSearchList = [[VSObjectSearchList alloc]init];
    sharedSearchList.delegate = delegate;
}

+(NSInteger)searchResultNumberFound{
    if(sharedSearchList == nil) sharedSearchList = [[VSObjectSearchList alloc]init];
    return [sharedSearchList searchResultNumberFound];
}

+(NSInteger)searchResultPage{
    if(sharedSearchList == nil) sharedSearchList = [[VSObjectSearchList alloc]init];
    return [sharedSearchList searchResultPage];
}

+(NSInteger)searchResultActualPage{
    if(sharedSearchList == nil) sharedSearchList = [[VSObjectSearchList alloc]init];
    return [sharedSearchList searchResultActualPage];
}

///////////////////////
//       INIT        //
///////////////////////
-(id)init{
    self = [super init];
    if(self){
        searchResult = [[NSMutableArray alloc]init];
        searchPagesURL = [[NSMutableArray alloc]init];
    }
    return self;
}


////////////////////////
// TABLEVIEW METHODES //
////////////////////////
-(NSInteger)masterCount{
    return [searchResult count];
}

-(VSMasterObject*)masterObjectAtIndex:(NSInteger)indexPath{
    if(indexPath < [searchResult count]){
        return [searchResult objectAtIndex:indexPath];
    }
    return nil;
}

+(VSReleaseObject*)releaseObjectAtIndex:(NSIndexPath*)indexPath{
    VSMasterObject *master = [self masterObjectAtIndex:indexPath.section];
    return [master relaseObjectAtIndex:indexPath.row];
}

-(void)searchInDiscogsDBWithString:(NSString*)searchString{
    if(delegate == nil){
        NSLog(@"SEARCH DELEGATE IS NOT SET");
    }
    else{
        
        NSURL *searchUrl = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://api.discogs.com/database/search?q=%@&type=master",[searchString urlEncodeUsingEncoding:kCFStringEncodingUTF8]]];
        [searchPagesURL addObject:searchUrl];
        ASIHTTPRequest *searchRequest = [[ASIHTTPRequest alloc]initWithURL:searchUrl];
        [searchRequest setDelegate:self];
        [searchRequest setTag:1];
        [searchRequest startAsynchronous];
    }
}

-(void)nextPage{
    if(delegate == nil){
        NSLog(@"SEARCH DELEGATE IS NOT SET");
    }
    else{
        if(searchResultActualPage+1 > searchResultPage){
            NSLog(@"last page");
        }
        else{
            if(loadNextPage == NO){
                loadNextPage = YES;
                NSLog(@"load next page");
                ASIHTTPRequest *searchRequest = [[ASIHTTPRequest alloc]initWithURL:[searchPagesURL objectAtIndex:searchResultActualPage+1]];
                [searchRequest setDelegate:self];
                [searchRequest setTag:2];
                [searchRequest startAsynchronous];
            }
        }
    }
}

-(NSError*)processSearchResultFound:(NSData*)data{
    NSError *error;
    NSDictionary *searchResultDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if(error){
        return error;
    }
    else{
        if([searchResultDictionary objectForKey:@"pagination"]){ //parse de la recherche
            NSDictionary *pagination = [searchResultDictionary objectForKey:@"pagination"];
            searchResultActualPage = [[pagination objectForKey:@"page"] integerValue]-1;
            searchResultNumberFound = [[pagination objectForKey:@"items"] integerValue];
            searchResultPage = [[pagination objectForKey:@"pages"] integerValue];
            if([pagination objectForKey:@"urls"]){
                if([[pagination objectForKey:@"urls"] objectForKey:@"next"]){
                    NSURL *nextUrlPage = [[NSURL alloc]initWithString:[[pagination objectForKey:@"urls"] objectForKey:@"next"]];
                    [searchPagesURL addObject:nextUrlPage];
                }
            }
        }
        if([searchResultDictionary objectForKey:@"results"]){
            NSArray *masterResult = [searchResultDictionary objectForKey:@"results"];
            for (NSDictionary *masterDictionary in masterResult) {
                VSMasterObject *masterObject = [[VSMasterObject alloc]initMasterObjectWithDictionary:masterDictionary];
                if(!searchResult){
                    searchResult = [[NSMutableArray alloc]init];
                }
                [masterObject getReleaseOfMaster];
                [searchResult addObject:masterObject];
            }
        }
    }
    return error;
}

-(NSInteger)searchResultNumberFound{
    return searchResultNumberFound;
}

-(NSInteger)searchResultPage{
    return searchResultPage;
}

-(NSInteger)searchResultActualPage{
    return searchResultActualPage;
}

-(NSInteger)indexForMasterID:(NSInteger)masterID{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"masterID == %d",masterID];
    NSArray *array = [searchResult filteredArrayUsingPredicate:predicate];
    if([array count] == 0){
        return 0;
    }
    else{
        NSMutableArray *indexToReturn = [[NSMutableArray alloc]init];
        VSMasterObject *master = [array objectAtIndex:0];
        NSInteger section = [searchResult indexOfObject:[array objectAtIndex:0]];
        for (int i = 0; i< [master releaseCount]; i++) {
            NSIndexPath *index  = [NSIndexPath indexPathForItem:i inSection:section];
            [indexToReturn addObject:index];
        }
        return [searchResult indexOfObject:master];
    }
}

///////////////////////////
// ASI REQUEST DELEGATE  //
///////////////////////////
-(void)requestStarted:(ASIHTTPRequest *)request{
    if(request.tag == 1){
        [delegate searchObjectStartSearch:NO];
    }
    if(request.tag == 2){
        [delegate searchObjectStartSearch:YES];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    if(request.tag == 1){
        [delegate searchObjectFailSearch:NO withError:[[request error] description]];
    }
    if(request.tag == 2){
        loadNextPage = NO;
        [delegate searchObjectFailSearch:YES withError:[[request error] description]];
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    if(request.tag == 1){
        if([request responseStatusCode] == 200){
            NSError *error = [self processSearchResultFound:[request responseData]];
            if(!error){
                [delegate searchObjectEndSearch:NO];
            }
            else{
                [delegate searchObjectFailSearch:NO withError:[error description]];
            }
            
        }
        else{
            [delegate searchObjectFailSearch:NO withError:[request responseStatusMessage]];
        }
    }
    if(request.tag == 2){
        loadNextPage = NO;
        if([request responseStatusCode] == 200){
            NSError *error = [self processSearchResultFound:[request responseData]];
            if(!error){
                [delegate searchObjectEndSearch:YES];
            }
            else{
                [delegate searchObjectFailSearch:YES withError:[error description]];
            }
            
        }
        else{
            [delegate searchObjectFailSearch:YES withError:[request responseStatusMessage]];
        }
    }
}




@end
