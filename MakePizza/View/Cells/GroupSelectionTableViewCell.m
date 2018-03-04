//
//  GroupSelectionTableViewCell.m
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import "GroupSelectionTableViewCell.h"
#import "VariationSelectionViewModel.h"

#define VariationDescriptionTag 111

@interface GroupSelectionTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *optionViews;

@end

@implementation GroupSelectionTableViewCell

+ (NSString *)cellIdentifier {
    return @"GroupSelectionTableViewCellIdntifier";
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configureCellWithViewModel:(SelectionCellViewModel *)viewModel {
    self.groupNameLabel.text = viewModel.displayedGroupTitle;
    [self configureVariationOptions:viewModel.variationSelectionVMs];
}

- (void)configureVariationOptions:(NSArray *)variatonOptions {
    for (int incrementer = 0; incrementer < variatonOptions.count; incrementer++) {
        VariationSelectionViewModel *variationVM = variatonOptions[incrementer];
        UIView *optionView = self.optionViews[incrementer];
        UILabel *description = [optionView viewWithTag:VariationDescriptionTag];
        description.text = variationVM.variationName;
    }
}
@end
