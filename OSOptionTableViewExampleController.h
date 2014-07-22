//
//  OSOptionTableViewExampleController.h
//  Ocasta Studios
//
//  Created by Chris Birch on 10/07/2014.
//  Copyright (c) 2014 Ocasta Studios. All rights reserved.
//

/**
 * Example implementation of the OptionTableViewController
 */

#import "OSOptionTableViewController.h"

/**
 * Custom block definition to return values specific to this option tableview
 */
typedef void(^OptionsChosen)(NSString* option1Value, NSString* option2Value);

@interface OSOptionTableViewExampleController : OSOptionTableViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;


/**
 * Called when apply is pressed
 */
@property (nonatomic,copy) OptionsChosen valuesChosen;

@end
