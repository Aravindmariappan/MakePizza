//
//  GroupSelectionTableViewCell.h
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PizzaListingCellViewModel.h"

@class PizzaGroupSelectionTableViewCell;
@protocol GroupSelectionTableViewCellDelegate <NSObject>

- (void)groupSelectionCell:(PizzaGroupSelectionTableViewCell *)cell selectedWithVariationAtIndex:(NSInteger)index;
- (void)groupSelectionCell:(PizzaGroupSelectionTableViewCell *)cell withError:(NSString *)error;

@end

@interface PizzaGroupSelectionTableViewCell : UITableViewCell

@property id<GroupSelectionTableViewCellDelegate>delegate;

@property (readonly) PizzaListingCellViewModel *pizzaListingCellVM;

+ (NSString *)cellIdentifier;
- (void)configureCellWithViewModel:(PizzaListingCellViewModel *)viewModel;

@end
