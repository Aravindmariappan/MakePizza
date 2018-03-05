//
//  SelectionViewController.m
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import "PizzaListingViewController.h"
#import "PizzaListingViewModel.h"
#import "PizzaGroupSelectionTableViewCell.h"

@interface PizzaListingViewController ()<UITableViewDataSource, GroupSelectionTableViewCellDelegate>

@property PizzaListingViewModel *selectionVM;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIStackView *descriptionStackView;
@property (weak, nonatomic) IBOutlet UILabel *priceStackView;

@end

@implementation PizzaListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView:self.tableView];
    [self configureSelectionViewModel];
    [self configureDescriptionLabels];
}

#pragma mark - Selection ViewModel

- (void)configureSelectionViewModel {
    PizzaListingViewModel *selectionVM = [[PizzaListingViewModel alloc] initWithAvailableGroups];
    [selectionVM loadAllGroupsWithCompletion:^(NSArray *items) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
            [self configureDescriptionLabels];
        }];
    }];
    self.selectionVM = selectionVM;
}

#pragma mark - View Config

- (void)configureTableView:(UITableView *)tableView {
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"GroupSelectionTableViewCell" bundle:nil] forCellReuseIdentifier:[PizzaGroupSelectionTableViewCell cellIdentifier]];
    [tableView setTableFooterView:[[UIView alloc] init]];
    
}

- (void)configureDescriptionLabels {
    [self.descriptionStackView.subviews enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger index, BOOL * _Nonnull stop) {
        label.text = [self.selectionVM descriptionForVariantAtIndex:index];
    }];
    self.priceStackView.text = self.selectionVM.itemCost;
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.selectionVM getGroupsCount];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PizzaGroupSelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PizzaGroupSelectionTableViewCell cellIdentifier] forIndexPath:indexPath];
    cell.delegate = self;
    PizzaListingCellViewModel *cellVM = [self.selectionVM cellViewModelAtIndex:indexPath.row];
    [cell configureCellWithViewModel:cellVM];
    
    return cell;
}

#pragma mark - GroupSelectionTableViewCellDelegate

- (void)groupSelectionCell:(PizzaGroupSelectionTableViewCell *)cell selectedWithVariationAtIndex:(NSInteger)index {
    PizzaListingCellViewModel *cellVM = cell.pizzaListingCellVM;
    [self.selectionVM addedSelectedVariation:[cellVM getSelectedVariation]];
    [self.selectionVM configureExclusionGroups];
    [self configureDescriptionLabels];
    [self.tableView reloadData];
}

- (void)groupSelectionCell:(PizzaGroupSelectionTableViewCell *)cell withError:(NSString *)error {
    [self showAlertWithAlertText:error];
}

#pragma mark -

- (void)showAlertWithAlertText:(NSString *)alertText {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:alertText preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okayButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okayButton];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
