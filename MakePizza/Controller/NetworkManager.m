//
//  NetworkManager.m
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import "NetworkManager.h"

#define ServerURL @"https://api.myjson.com/bins/3b0u2"

@interface NetworkManager () <NSURLSessionDelegate>

@end

@implementation NetworkManager

static NetworkManager *sharedInstance = nil;

#pragma mark - Initailization

+ (NetworkManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Fetch All Data

- (void)fetchAllItemsWithCompletion:(void(^)(NSArray *items, NSError *error))completion {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:ServerURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray *allGroups;
        NSError *jsonError;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if ([NSJSONSerialization isValidJSONObject:dict]) {
            allGroups = [[DatabaseManager sharedInstance] storeGroupDataFromDict:dict];
        }
        else {
            error = jsonError;
        }
        completion(allGroups,error);
    }];
    
    [dataTask resume];
}















@end
