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
@property (readwrite, nonatomic) NSString *price;
@property (readwrite) NSString *errorText;
@property VariationSelectionViewModel *selectedVariationVM;

@end

@implementation PizzaListingCellViewModel

- (instancetype)initWithGroup:(Group *)group {
    self = [super init];
    if (self) {
        self.displayedGroup = group;
        self.displayedGroupTitle = group.name.capitalizedString;
        self.price = @"";
        self.variationSelectionVMs = [self configureVariationsForGroup:group];
    }

    return self;
}

- (NSArray *)configureVariationsForGroup:(Group *)group {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"variationID" ascending:YES];
    NSArray *variations = [group.variations sortedArrayUsingDescriptors:@[sortDescriptor]];
    NSMutableArray *variationVMs = [NSMutableArray array];
    for (Variation *variation in variations) {
        VariationSelectionViewModel *variationVM;
            variationVM = [[VariationSelectionViewModel alloc] initWithVariation:variation isSelected:NO];
//            if(variation.isDefault == YES) {
//                self.selectedVariationVM = variationVM;
//                self.price = [self getPriceString:variation.price];
//            }
        [variationVMs addObject:variationVM];
    }
    return variationVMs;
}

- (VariationSelectionViewModel *)variationSelectionVMAtIndex:(NSInteger)index {
    return [self.variationSelectionVMs objectAtIndex:index];
}

- (BOOL)updateVariationSelectionAtIndex:(NSInteger)index {
    VariationSelectionViewModel *unselectedViewModel = self.selectedVariationVM;
    VariationSelectionViewModel *currentlySelectedVM = [self.variationSelectionVMs objectAtIndex:index];
    if (currentlySelectedVM.isExclusion == YES) {
        self.errorText = [currentlySelectedVM exclusionErrorString];
        return NO;
    }
    else {
        [unselectedViewModel updateVariationSelection:NO];
        self.selectedVariationVM = currentlySelectedVM;
        [self.selectedVariationVM updateVariationSelection:YES];
        self.price = [self getPriceString:self.selectedVariationVM.price];
        return YES;
    }
}

- (Variation *)getSelectedVariation {
    return self.selectedVariationVM.variation;
}

- (void)configureExclusionListWithExclusionGroup:(NSSet *)exclusionGroups {
    for (VariationSelectionViewModel *variationVM in self.variationSelectionVMs) {
        Variation *variation = variationVM.variation;
        NSMutableArray *exclusionList = [NSMutableArray array];
        for (NSSet *exclusionGroup in exclusionGroups) {
            if ([exclusionGroup containsObject:variation]) {
                NSMutableArray *exclusionArray = [exclusionGroup.allObjects mutableCopy];
                [exclusionArray removeObject:variation];
                [exclusionList addObject:[exclusionArray firstObject]];
            }
        }
        [variationVM configureWithExclusion:exclusionList];
    }
}

#pragma mark -

- (NSString *)getPriceString:(double)price {
    return [NSString stringWithFormat:@"₹ %.2f",price];
}

@end
