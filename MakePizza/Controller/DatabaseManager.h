//
//  DataManager.h
//  MakePizza
//
//  Created by Shankar on 02/03/2018.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Group+CoreDataClass.h"
#import "Variation+CoreDataClass.h"
#import "Cart+CoreDataClass.h"

@interface DatabaseManager : NSObject

+(DatabaseManager *)sharedInstance;

@property (readonly) Cart *defaultCart;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong) NSManagedObjectContext *mainContext;

- (void)saveContext;

- (NSArray *)storeGroupDataFromDict:(NSDictionary *)dict;

- (void)insertVariation:(Variation *)variation intoCart:(Cart *)cart;

@end
