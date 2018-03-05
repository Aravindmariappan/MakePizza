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
@property (readwrite) BOOL isExclusion;
@property (readwrite) NSInteger price;
@property NSArray *exclusions;

@end

@implementation VariationSelectionViewModel

- (instancetype)initWithVariation:(Variation *)variation isSelected:(BOOL)isSelected {
    self = [super init];
    if (self) {
        [self commonInitWithVariation:variation];
        self.isSelected = isSelected;
    }
    
    return self;
}

- (void)commonInitWithVariation:(Variation *)variation {
    self.variation = variation;
    self.variationName = variation.name.capitalizedString;
    self.isVeg = variation.isVeg;
    self.price = variation.price;
}

- (void)configureWithExclusion:(NSArray *)exclusions {
    if ([exclusions count]) {
        self.exclusions = exclusions;
        self.isExclusion = YES;
    }
    else {
        self.exclusions = nil;
        self.isExclusion = NO;
    }
}

- (void)updateVariationSelection:(BOOL)isSelected {
    self.isSelected = isSelected;
}

- (NSString *)exclusionErrorString {
    NSString *error = @"You cannot select this as you have selected : ";
    if ([self.exclusions count] == 0) {
        return @"";
    }
    for (int index = 0; index < self.exclusions.count; index++) {
        Variation *variation = self.exclusions[index];
        if(index == 0) {
            error = [error stringByAppendingString:variation.name];
        }
        else {
            error = [NSString stringWithFormat:@"%@,%@",error,variation.name];
        }
    }
    return error;
}
@end
