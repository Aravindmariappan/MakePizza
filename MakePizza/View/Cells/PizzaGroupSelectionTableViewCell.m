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
#define VariationNonVegTag 222

@interface PizzaGroupSelectionTableViewCell()

@property (readwrite) PizzaListingCellViewModel *pizzaListingCellVM;

@property (weak, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *optionViews;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation PizzaGroupSelectionTableViewCell

+ (NSString *)cellIdentifier {
    return @"GroupSelectionTableViewCellIdntifier";
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configureCellWithViewModel:(PizzaListingCellViewModel *)viewModel {
    self.pizzaListingCellVM = viewModel;
    self.groupNameLabel.text = viewModel.displayedGroupTitle;
    self.priceLabel.text = viewModel.price;
    [self updateVariation];
}

- (void)updateVariation {
    for (int index = 0; index < self.optionViews.count; index++) {
        VariationSelectionViewModel *variationVM = [self.pizzaListingCellVM variationSelectionVMAtIndex:index];
        [self configureVariationOptions:variationVM atIndex:index];
        UIImageView *nonVegImageView = [self.optionViews[index] viewWithTag:VariationNonVegTag];
        [nonVegImageView setHidden:variationVM.isVeg];
    }
}

- (void)configureVariationOptions:(VariationSelectionViewModel *)variationVM atIndex:(NSInteger)index{
    UIView *optionView = self.optionViews[index];
    UILabel *description = [optionView viewWithTag:VariationDescriptionTag];
    description.text = variationVM.variationName;
    [self updateView:optionView forSelection:variationVM.isSelected];
    if (variationVM.isSelected == NO) {
        [self updateView:optionView forExclusion:variationVM.isExclusion];
    }
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
    description.alpha = 1.0;
    optionView.layer.borderColor = [UIColor colorNamed:@"AppTheme"].CGColor;
    optionView.layer.borderWidth = 1.0f;
}

- (void)updateView:(UIView *)optionView forExclusion:(BOOL)isExclusion {
    UILabel *description = [optionView viewWithTag:VariationDescriptionTag];
    if (isExclusion == YES) {
        description.alpha = 0.5;
    }
    else {
        description.alpha = 1.0;
    }
}

- (IBAction)selectionOptionTapped:(id)sender {
    UIView *optionView = [(UIView *)sender superview];
    NSInteger index = [self.optionViews indexOfObject:optionView];
    if([self.pizzaListingCellVM updateVariationSelectionAtIndex:index] == YES) {
        [self updateVariation];
        self.priceLabel.text = self.pizzaListingCellVM.price;
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(groupSelectionCell:selectedWithVariationAtIndex:)]) {
            [self.delegate groupSelectionCell:self selectedWithVariationAtIndex:index];
        }
    }
    else {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(groupSelectionCell:withError:)]) {
            NSString *error = self.pizzaListingCellVM.errorText;
            [self.delegate groupSelectionCell:self withError:error];
        }
    }
}

@end
