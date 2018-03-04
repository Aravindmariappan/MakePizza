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
@property (readwrite) Cart *cart;

@end

@implementation PizzaListingViewModel

- (instancetype)initWithAvailableGroups {
    self = [super init];
    if (self) {
        self.contentArray = [NSMutableArray array];
        self.itemDescription = @"No Selection";
        self.itemCost = [NSString stringWithFormat:@"₹ %.2f",self.cart.totalPrice];
        self.cart = [[DatabaseManager sharedInstance] defaultCart];
    }
    
    return self;
}

- (void)loadAllGroupsWithCompletion:(void(^)(NSArray *items))completion  {
    [[NetworkManager sharedInstance] fetchAllItemsWithCompletion:^(NSArray *items, NSError *error) {
        for (int index = 0; index < items.count; index++) {
            PizzaListingCellViewModel *cellViewModel = [[PizzaListingCellViewModel alloc] initWithGroup:items[index]];
            [self.contentArray addObject:cellViewModel];
            Variation *selectedVariation = [cellViewModel getSelectedVariation];
            [self addedSelectedVariation:selectedVariation];
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

- (NSString *)descriptionForVariantAtIndex:(NSInteger)index {
    if (self.contentArray.count <= index) {
        return @"";
    }
    PizzaListingCellViewModel *cellVM = [self.contentArray objectAtIndex:index];
    NSString *groupName = cellVM.displayedGroupTitle;
    NSString *variationName;
    if ([cellVM getSelectedVariation] != nil) {
        variationName = [[cellVM getSelectedVariation].name capitalizedString];
    }
    else {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@ : %@",groupName,variationName];
}


- (void)addedSelectedVariation:(Variation *)variation {
    if (variation != nil) {
        [[DatabaseManager sharedInstance] insertVariation:variation intoCart:self.cart];
    }
    self.itemCost = [NSString stringWithFormat:@"₹ %.2f",self.cart.totalPrice];
}

@end
