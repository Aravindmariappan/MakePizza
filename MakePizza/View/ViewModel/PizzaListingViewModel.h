//
//  SelectionViewModel.h
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PizzaListingCellViewModel.h"

@interface PizzaListingViewModel : NSObject

- (instancetype)initWithAvailableGroups;

@property (readonly) NSString *itemDescription;
@property (readonly) NSString *itemCost;

- (void)loadAllGroupsWithCompletion:(void(^)(NSArray *items))completion;
- (NSInteger)getGroupsCount;
- (PizzaListingCellViewModel *)cellViewModelAtIndex:(NSInteger)index;
- (NSString *)descriptionForSelectedVariation:(PizzaListingCellViewModel *)selectionCellVM;

@end
