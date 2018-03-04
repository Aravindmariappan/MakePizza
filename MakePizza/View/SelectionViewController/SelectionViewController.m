//
//  SelectionViewController.m
//  MakePizza
//
//  Created by Aravind on 03/03/18.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import "SelectionViewController.h"
#import "SelectionViewModel.h"
#import "GroupSelectionTableViewCell.h"

@interface SelectionViewController ()<UITableViewDataSource>

@property SelectionViewModel *selectionVM;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView:self.tableView];
    [self configureSelectionView];
}

#pragma mark - Selection ViewModel

- (void)configureSelectionView {
    SelectionViewModel *selectionVM = [[SelectionViewModel alloc] initWithAvailableGroups];
    [selectionVM loadAllGroupsWithCompletion:^(NSArray *items) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
    self.selectionVM = selectionVM;
}

#pragma mark - Configure TableView

- (void)configureTableView:(UITableView *)tableView {
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"GroupSelectionTableViewCell" bundle:nil] forCellReuseIdentifier:[GroupSelectionTableViewCell cellIdentifier]];
    [tableView setTableFooterView:[[UIView alloc] init]];
    
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.selectionVM getGroupsCount];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GroupSelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[GroupSelectionTableViewCell cellIdentifier] forIndexPath:indexPath];
    SelectionCellViewModel *cellVM = [self.selectionVM cellViewModelAtIndex:indexPath.row];
    [cell configureCellWithViewModel:cellVM];
    
    return cell;
}

@end
