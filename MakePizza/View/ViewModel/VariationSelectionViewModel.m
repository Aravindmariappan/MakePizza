//
//  VariationSelectionViewModel.m
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import "VariationSelectionViewModel.h"

@interface VariationSelectionViewModel()

@property (readwrite) Variation *variation;
@property (readwrite) NSString *variationName;
@property (readwrite) BOOL isVeg;
@property (readwrite) BOOL isSelected;
@property (readwrite) NSInteger price;

@end

@implementation VariationSelectionViewModel

- (instancetype)initWithVariation:(Variation *)variation isSelected:(BOOL)isSelected {
    self = [super init];
    if (self) {
        self.variation = variation;
        self.variationName = variation.name.capitalizedString;
        self.isVeg = variation.isVeg;
        self.isSelected = isSelected;
        self.price = variation.price;
    }
    
    return self;
}

- (void)updateVariationSelection:(BOOL)isSelected {
    self.isSelected = isSelected;
}
@end
