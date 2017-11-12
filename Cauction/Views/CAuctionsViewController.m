//
//  CAuctionsViewController.m
//  Cauction
//
//  Created by Stefan Lage on 11/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import "CAuctionsViewController.h"
#import "CConstants.h"

NSString * const CAuctionsCellIdentifier = @"AuctionCell";

@interface CAuctionsViewController ()

@property (nonatomic, strong, readonly) CAuctionsViewModel *viewModel;

@end

@implementation CAuctionsViewController

- (instancetype) initWithViewModel: (CAuctionsViewModel *) viewModel{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self){
        _viewModel = viewModel;
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
    cell.textLabel.text = [self.viewModel auctionName:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // Get data to show
    NSString *auctionTitle = [self.viewModel esimatedAmountTitleForAuction:indexPath];
    NSString *auctionEra = [self.viewModel estimatedReturnAmountForAuction:indexPath];
    // Display the era's value
    [self showAuctionEra:auctionTitle
                 withEra:auctionEra];
    // Deselect the current cell
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

#pragma mark - Auction events

/**
 * Show the era's value in an UIAlert
 *
 */
- (void) showAuctionEra:(NSString *)auctionTitle withEra:(NSString*)eraValue{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:auctionTitle
                                                                    message:eraValue
                                                             preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:Alert_Default_Button_Text
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

@end
