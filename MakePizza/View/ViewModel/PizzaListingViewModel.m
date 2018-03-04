//
//  SelectionViewModel.m
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import "PizzaListingViewModel.h"

@interface PizzaListingViewModel()

@property (readwrite) NSMutableArray *contentArray;
@property (readwrite) NSString *itemDescription;
@property (readwrite) NSString *itemCost;

@end

@implementation PizzaListingViewModel

- (instancetype)initWithAvailableGroups {
    self = [super init];
    if (self) {
        self.contentArray = [NSMutableArray array];
        self.itemDescription = @"No Selection";
        self.itemCost = @"₹ 0";
    }
    
    return self;
}

- (void)loadAllGroupsWithCompletion:(void(^)(NSArray *items))completion  {
    [[NetworkManager sharedInstance] fetchAllItemsWithCompletion:^(NSArray *items, NSError *error) {
        for (int index = 0; index < items.count; index++) {
            PizzaListingCellViewModel *cellViewModel = [[PizzaListingCellViewModel alloc] initWithGroup:items[index]];
            [self.contentArray addObject:cellViewModel];
        }

        completion(self.contentArray);
    }];
}

- (NSInteger)getGroupsCount {
    return self.contentArray.count;
}

- (PizzaListingCellViewModel *)cellViewModelAtIndex:(NSInteger)index {
    PizzaListingCellViewModel *cellViewModel = [self.contentArray objectAtIndex:index];
    
    return cellViewModel;
}

- (NSString *)descriptionForSelectedVariation:(PizzaListingCellViewModel *)selectionCellVM {
    NSString *variationGroup = selectionCellVM.displayedGroupTitle;
    NSString *variationType = selectionCellVM.selectedVariationVM.variationName;
    return [NSString stringWithFormat:@"%@ : %@", variationGroup, variationType];
}

@end
