//
//  SelectionViewModel.m
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import "SelectionViewModel.h"

@interface SelectionViewModel()

@property  (readwrite) NSArray *contentArray;

@end

@implementation SelectionViewModel

- (instancetype)initWithAvailableGroups {
    self = [super init];
    if (self) {
        self.contentArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)loadAllGroupsWithCompletion:(void(^)(NSArray *items))completion  {
    [[NetworkManager sharedInstance] fetchAllItemsWithCompletion:^(NSArray *items, NSError *error) {
        self.contentArray = items;
        completion(items);
    }];
}

- (NSInteger)getGroupsCount {
    return self.contentArray.count;
}

- (SelectionCellViewModel *)cellViewModelAtIndex:(NSInteger)index {
    Group *group = [self.contentArray objectAtIndex:index];
    SelectionCellViewModel *cellViewModel = [[SelectionCellViewModel alloc] initWithGroup:group];
    
    return cellViewModel;
}

@end
