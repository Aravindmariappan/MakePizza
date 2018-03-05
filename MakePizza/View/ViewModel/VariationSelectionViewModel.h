//
//  VariationSelectionViewModel.h
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VariationSelectionViewModel : NSObject

- (instancetype)initWithVariation:(Variation *)variation isSelected:(BOOL)isSelected;

@property (readonly) Variation *variation;
@property (readonly) NSString *variationName;
@property (readonly) BOOL isVeg;
@property (readonly) BOOL isSelected;
@property (readonly) BOOL isExclusion;
@property (readonly) NSInteger price;

- (void)configureWithExclusion:(NSArray *)exclusions;
- (void)updateVariationSelection:(BOOL)isSelected;
- (NSString *)exclusionErrorString;

@end
