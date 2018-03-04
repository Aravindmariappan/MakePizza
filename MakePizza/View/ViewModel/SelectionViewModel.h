//
//  SelectionViewModel.h
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectionCellViewModel.h"

@interface SelectionViewModel : NSObject

- (instancetype)initWithAvailableGroups;

- (void)loadAllGroupsWithCompletion:(void(^)(NSArray *items))completion;

- (NSInteger)getGroupsCount;
- (SelectionCellViewModel *)cellViewModelAtIndex:(NSInteger)index;

@end
