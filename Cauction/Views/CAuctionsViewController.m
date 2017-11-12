//
//  CAuctionsViewController.m
//  Cauction
//
//  Created by Stefan Lage on 11/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import "CAuctionsViewController.h"

NSString * const CAuctionsCellIdentifier = @"AuctionCell";

@interface CAuctionsViewController ()

@property (nonatomic, strong, readonly) CAuctionsViewModel *viewModel;

@end

@implementation CAuctionsViewController

- (instancetype) initWithViewModel: (CAuctionsViewModel *) viewModel{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self){
        _viewModel = viewModel;
//        [_viewModel loadData];
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerClass:UITableViewCell.class
           forCellReuseIdentifier:CAuctionsCellIdentifier];
    
    [self bindViewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Bindings

/**
 * Bind all controllers / propertes we'd like to observe with the VM
 */
- (void)bindViewModel {
    self.title = [self.viewModel title];
    // Prevents retain cycle combine with @strongify use
    @weakify(self);
    
    [[self.viewModel.auctionsObserver deliverOnMainThread]
     subscribeNext:^(id _) {
         @strongify(self);
         NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
         [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel auctionsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CAuctionsCellIdentifier
                                                            forIndexPath:indexPath];
    //
    cell.textLabel.text = [self.viewModel auctionName:indexPath];
    
    return cell;
}

@end
