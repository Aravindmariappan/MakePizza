//
//  SelectionCellViewModel.m
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import "SelectionCellViewModel.h"
#import "VariationSelectionViewModel.h"

@interface SelectionCellViewModel()

@property (readwrite) Group *displayedGroup;
@property (readwrite) NSArray *variationSelectionVMs;
@property (readwrite, nonatomic) NSString *displayedGroupTitle;

@end

@implementation SelectionCellViewModel

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
    NSArray *variations = group.variations.allObjects;
    NSMutableArray *variationVMs = [NSMutableArray array];
    for (Variation *variation in variations) {
        VariationSelectionViewModel *variationVM = [[VariationSelectionViewModel alloc] initWithVariation:variation isSelected:NO];
        [variationVMs addObject:variationVM];
    }
    return variationVMs;
}

@end
