//
//  GroupSelectionTableViewCell.m
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import "PizzaGroupSelectionTableViewCell.h"
#import "VariationSelectionViewModel.h"

#define VariationDescriptionTag 111

@interface PizzaGroupSelectionTableViewCell()

@property (readwrite) PizzaListingCellViewModel *selectionCellVM;

@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *optionViews;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation PizzaGroupSelectionTableViewCell

+ (NSString *)cellIdentifier {
    return @"GroupSelectionTableViewCellIdntifier";
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configureCellWithViewModel:(PizzaListingCellViewModel *)viewModel {
    self.selectionCellVM = viewModel;
    self.groupNameLabel.text = viewModel.displayedGroupTitle;
    [self updateVariation];
}

- (void)updateVariation {
    for (int index = 0; index < self.optionViews.count; index++) {
        VariationSelectionViewModel *variationVM = [self.selectionCellVM variationSelectionVMAtIndex:index];
        [self configureVariationOptions:variationVM atIndex:index];
    }
}
- (void)configureVariationOptions:(VariationSelectionViewModel *)variationVM atIndex:(NSInteger)index{
    UIView *optionView = self.optionViews[index];
    UILabel *description = [optionView viewWithTag:VariationDescriptionTag];
    description.text = variationVM.variationName;
    [self updateView:optionView forSelection:variationVM.isSelected];
}

- (void)updateView:(UIView *)optionView forSelection:(BOOL)optionIsSelected {
    UILabel *description = [optionView viewWithTag:VariationDescriptionTag];
    if (optionIsSelected == YES) {
        optionView.backgroundColor = [UIColor colorNamed:@"AppTheme"];
        description.textColor = [UIColor whiteColor];
    }
    else {
        optionView.backgroundColor = [UIColor clearColor];
        description.textColor = [UIColor blackColor];
    }
    optionView.layer.borderColor = [UIColor colorNamed:@"AppTheme"].CGColor;
    optionView.layer.borderWidth = 1.0f;
}

- (IBAction)selectionOptionTapped:(id)sender {
    UIView *optionView = [(UIView *)sender superview];
    NSInteger index = [self.optionViews indexOfObject:optionView];
    [self.selectionCellVM updateVariationSelectionAtIndex:index];
    [self updateVariation];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(groupSelectionCell:selectedWithVariationAtIndex:)]) {
        [self.delegate groupSelectionCell:self selectedWithVariationAtIndex:index];
    }
}

@end
