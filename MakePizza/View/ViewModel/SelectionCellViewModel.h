//
//  SelectionCellViewModel.h
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Group+CoreDataClass.h"

@interface SelectionCellViewModel : NSObject

- (instancetype)initWithGroup:(Group *)group;

@property (readonly) NSString *displayedGroupTitle;
@property (readonly) NSArray *variationSelectionVMs;

@end
