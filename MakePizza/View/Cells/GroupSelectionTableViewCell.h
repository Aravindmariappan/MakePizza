//
//  GroupSelectionTableViewCell.h
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionCellViewModel.h"

@interface GroupSelectionTableViewCell : UITableViewCell

+ (NSString *)cellIdentifier;

- (void)configureCellWithViewModel:(SelectionCellViewModel *)viewModel;

@end
