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
}

#pragma mark - Selection ViewModel

- (void)configureSelectionViewModel {
    PizzaListingViewModel *selectionVM = [[PizzaListingViewModel alloc] initWithAvailableGroups];
    [selectionVM loadAllGroupsWithCompletion:^(NSArray *items) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
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

- (void)configureDescriptionLabels:(PizzaListingCellViewModel *)viewModel {
//    [self.descriptionStackView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *subView 
//    }];
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

}

@end
