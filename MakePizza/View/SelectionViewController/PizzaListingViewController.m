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

@property PizzaListingViewModel *pizzaListingVM;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIStackView *descriptionStackView;
@property (weak, nonatomic) IBOutlet UILabel *priceStackView;
@property (weak, nonatomic) IBOutlet UIView *loadingPlaceholder;

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
    [self.loadingPlaceholder setHidden:NO];
    [selectionVM loadAllGroupsWithCompletion:^(NSArray *items) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
            [self configureDescriptionLabels];
            [self.loadingPlaceholder setHidden:YES];
        }];
    }];
    self.pizzaListingVM = selectionVM;
}

#pragma mark - View Config

- (void)configureTableView:(UITableView *)tableView {
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"GroupSelectionTableViewCell" bundle:nil] forCellReuseIdentifier:[PizzaGroupSelectionTableViewCell cellIdentifier]];
    [tableView setTableFooterView:[[UIView alloc] init]];
    
}

- (void)configureDescriptionLabels {
    [self.descriptionStackView.subviews enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger index, BOOL * _Nonnull stop) {
        label.text = [self.pizzaListingVM descriptionForVariantAtIndex:index];
    }];
    self.priceStackView.text = self.pizzaListingVM.itemCost;
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pizzaListingVM getGroupsCount];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PizzaGroupSelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PizzaGroupSelectionTableViewCell cellIdentifier] forIndexPath:indexPath];
    cell.delegate = self;
    PizzaListingCellViewModel *cellVM = [self.pizzaListingVM cellViewModelAtIndex:indexPath.row];
    [cell configureCellWithViewModel:cellVM];
    
    return cell;
}

#pragma mark - GroupSelectionTableViewCellDelegate

- (void)groupSelectionCell:(PizzaGroupSelectionTableViewCell *)cell selectedWithVariationAtIndex:(NSInteger)index {
    PizzaListingCellViewModel *cellVM = cell.pizzaListingCellVM;
    [self.pizzaListingVM addedSelectedVariation:[cellVM getSelectedVariation]];
    [self.pizzaListingVM configureExclusionGroups];
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
