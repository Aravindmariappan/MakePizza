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

@end

@implementation VariationSelectionViewModel

- (instancetype)initWithVariation:(Variation *)variation isSelected:(BOOL)isSelected {
    self = [super init];
    if (self) {
        self.variationName = variation.name.capitalizedString;
        self.isVeg = variation.isVeg;
        self.isSelected = isSelected;
    }
    
    return self;
}

@end
