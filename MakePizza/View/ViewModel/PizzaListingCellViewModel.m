//
//  SelectionCellViewModel.m
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import "PizzaListingCellViewModel.h"

@interface PizzaListingCellViewModel()

@property (readwrite) Group *displayedGroup;
@property (readwrite) NSArray *variationSelectionVMs;
@property (readwrite, nonatomic) NSString *displayedGroupTitle;
@property VariationSelectionViewModel *selectedVariationVM;

@end

@implementation PizzaListingCellViewModel

- (instancetype)initWithGroup:(Group *)group {
    self = [super init];
    if (self) {
        self.displayedGroup = group;
        self.displayedGroupTitle = group.name.capitalizedString;
        self.variationSelectionVMs = [self configureVariationsForGroup:group];
    }

    return self;
}

- (NSArray *)configureVariationsForGroup:(Group *)group {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"variationID" ascending:YES];
    NSArray *variations = [group.variations sortedArrayUsingDescriptors:@[sortDescriptor]];
    NSMutableArray *variationVMs = [NSMutableArray array];
    for (Variation *variation in variations) {
        VariationSelectionViewModel *variationVM = [[VariationSelectionViewModel alloc] initWithVariation:variation isSelected:variation.isDefault];
        if(variation.isDefault == YES) {
            self.selectedVariationVM = variationVM;
        }
        [variationVMs addObject:variationVM];
    }
    return variationVMs;
}

- (VariationSelectionViewModel *)variationSelectionVMAtIndex:(NSInteger)index {
    return [self.variationSelectionVMs objectAtIndex:index];
}

- (void)updateVariationSelectionAtIndex:(NSInteger)index {
    VariationSelectionViewModel *unselectedViewModel = self.selectedVariationVM;
    [unselectedViewModel updateVariationSelection:NO];
    self.selectedVariationVM = [self.variationSelectionVMs objectAtIndex:index];
    [self.selectedVariationVM updateVariationSelection:YES];
}

@end
