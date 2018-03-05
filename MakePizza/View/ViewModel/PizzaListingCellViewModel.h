//
//  SelectionCellViewModel.h
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Group+CoreDataClass.h"
#import "VariationSelectionViewModel.h"

@interface PizzaListingCellViewModel : NSObject

- (instancetype)initWithGroup:(Group *)group;

@property (readonly) NSString *displayedGroupTitle;
@property (readonly) NSString *price;
@property (readonly) NSString *errorText;

- (VariationSelectionViewModel *)variationSelectionVMAtIndex:(NSInteger)index;
- (BOOL)updateVariationSelectionAtIndex:(NSInteger)index;
- (Variation *)getSelectedVariation;
- (void)configureExclusionListWithExclusionGroup:(NSSet *)exclusionGroups;

@end
