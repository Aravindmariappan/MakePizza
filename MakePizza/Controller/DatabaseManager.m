//
//  DataManager.m
//  MakePizza
//
//  Created by Shankar on 02/03/2018.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

static DatabaseManager *sharedInstance = nil;

#pragma mark - Initailization

+ (DatabaseManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"MakePizza"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

- (NSManagedObjectContext *)mainContext {
    return self.persistentContainer.viewContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

#pragma mark -

- (NSArray *)storeGroupDataFromDict:(NSDictionary *)dict {
    NSMutableArray *groups = [NSMutableArray array];
    if([dict valueForKey:kAllVariants]) {
        NSDictionary *allVariants = [dict valueForKey:kAllVariants];
        NSArray *groupsDict = [allVariants valueForKey:kVariantGroups];
        for (NSDictionary *dict in groupsDict) {
            Group *groupItem = [self storeGroupWithDict:dict];
            [groups addObject:groupItem];
        }
        [self saveContext];
    }
    
    return groups;
}

#pragma mark - Group

- (Group *)storeGroupWithDict:(NSDictionary *)groupDict {
    Group *group;
    if (groupDict != nil) {
        NSString *groupID = [groupDict valueForKey:kGroupID];
        group = [self fetchGroupWithGroupID:groupID.integerValue];
        if (group == nil) {
            group = [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:self.mainContext];
            group.groupID = groupID.integerValue;
        }
        group.name = [groupDict valueForKey:kGroupName];
        NSArray *variationsDict = [groupDict valueForKey:kVariations];
        NSMutableArray *variations = [NSMutableArray array];
        for (NSDictionary *variationDict in variationsDict) {
            Variation *variation = [self storeVariationWithDict:variationDict];
            variation.group = group;
            [variations addObject:variation];
        }
    }
    
    return group;
}

- (Group *)fetchGroupWithGroupID:(NSInteger)groupID {
    NSPredicate *idPredicate = [NSPredicate predicateWithFormat:@"groupID = %d",groupID];
    NSFetchRequest *fetchRequest = [Group fetchRequest];
    [fetchRequest setPredicate:idPredicate];
    NSArray *groupsPresent = [self.mainContext executeFetchRequest:fetchRequest error:nil];
    Group *group = [groupsPresent firstObject];
    
    return group;
}

#pragma mark - Variation

- (Variation *)storeVariationWithDict:(NSDictionary *)variationDict {
    Variation *variation;
    if (variationDict != nil) {
        NSString *variationID = [variationDict valueForKey:kVariationID];
        variation = [self fetchVariationWithVariationID:variationID.integerValue];
        if (variation == nil) {
            variation = [NSEntityDescription insertNewObjectForEntityForName:@"Variation" inManagedObjectContext:self.mainContext];
            variation.variationID = variationID.integerValue;
        }
        variation.name = [variationDict valueForKey:kVariationName];
        variation.price = (int)[variationDict valueForKey:kVariationPrice];
        variation.isDefault = (BOOL)[variationDict valueForKey:kVariationDefault];
        variation.inStock = (BOOL)[variationDict valueForKey:kVariationInStock];
        variation.isVeg = (BOOL)[variationDict valueForKey:kVariationIsVeg];
    }

    return variation;
}

- (Variation *)fetchVariationWithVariationID:(NSInteger)variationID {
    NSPredicate *idPredicate = [NSPredicate predicateWithFormat:@"variationID = %d",variationID];
    NSFetchRequest *fetchRequest = [Variation fetchRequest];
    [fetchRequest setPredicate:idPredicate];
    NSArray *variationsPresent = [self.mainContext executeFetchRequest:fetchRequest error:nil];
    Variation *variation = [variationsPresent firstObject];
    
    return variation;
}
@end
