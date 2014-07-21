//
//  OSOptionTableViewController.h
//  Ocasta Studios
//
//  Created by Chris Birch on 26/02/2014.
//  Copyright (c) 2014 OcastaStudios. All rights reserved.
//

/**
 * Represents a list of options with selectable values contained within a tableview
 */

#import <UIKit/UIKit.h>
#import "OSOption.h"
#import "OSOptionValue.h"

@class OSOptionValueCell;

@interface OSOptionTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

-(id)getChoiceOrNilForKey:(NSString*)key fromDict:(NSDictionary*)dict;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 * The minimum size required to show all content
 */
@property (nonatomic,readonly) CGSize contentSize;
/**
 * The colour of selected option values
 */
@property(nonatomic,strong)UIColor* selectedColour;
/**
 * Represents a list of configurable options, each will displayed as a section of the tableview
 * and will have child rows for each selectable value
 */
@property (nonatomic,strong) NSMutableArray* options;


/**
 * A dictionary representation of the values that the user has chosen
 */
@property (nonatomic,readonly) NSDictionary* chosenValues;


/**
 * Returns YES if values have not been modified
 */
@property (nonatomic,readonly) BOOL areAllDefaultsSelected;

#pragma mark -
#pragma mark Item selection

/**
 * Given the index path of a cell in the tableview, will return the associated OSOption
 */
-(OSOption*)optionAtIndexPath:(NSIndexPath*)indexPath;

/**
 * Returns the option with the specified name
 */
-(OSOption*)optionWithName:(NSString*)optionName;

/**
 * Given the index path of a cell in the tableview, will return the associated OSOptionValue
 */
-(OSOptionValue*)optionValueAtIndexPath:(NSIndexPath*)indexPath;


/**
 * Given the index path of a cell in the tableview, will return the associated OSOptionValueCell
 */
-(OSOptionValueCell*)optionValueCellAtIndexPath:(NSIndexPath*)indexPath;

#pragma mark -
#pragma mark Item Management

/**
 * Adds an option to the controller and returns it to allow customisation
 */
-(OSOption*)addOptionWithName:(NSString*)optionName andOptionDisplayName:(NSString*)displayName andAllowsMultipleSelections:(BOOL)allowMultiple andRequiresSelection:(BOOL)requiresSelection;



@end
