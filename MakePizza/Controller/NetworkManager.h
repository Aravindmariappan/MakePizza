//
//  NetworkManager.h
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+(NetworkManager *)sharedInstance;

- (void)fetchAllItemsWithCompletion:(void(^)(NSArray *items, NSError *error))completion;

@end
