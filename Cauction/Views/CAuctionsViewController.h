//
//  CAuctionsViewController.h
//  Cauction
//
//  Created by Stefan Lage on 11/11/2017.
//  Copyright © 2017 Stefan Lage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAuctionsViewModel.h"

@interface CAuctionsViewController : UITableViewController

- (instancetype) initWithViewModel: (CAuctionsViewModel *) viewModel;

@end
