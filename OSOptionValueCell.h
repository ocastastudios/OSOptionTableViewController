//
//  OSOptionValueCell.h
//  Ocasta Studios
//
//  Created by Chris Birch on 26/02/2014.
//  Copyright (c) 2014 OcastaStudios. All rights reserved.
//

#import <UIKit/UIKit.h>

#define REUSE_OS_OPTION_VALUE_CELL @"OSOptionValueCell"
@class OSOptionTableViewController;

@class OSOptionValue;

@interface OSOptionValueCell : UITableViewCell<UIGestureRecognizerDelegate>

@property (nonatomic,weak) OSOptionTableViewController* parent;

@property (nonatomic,strong) NSIndexPath* indexPath;

/**
 * The option value that this cell represents
 */
@property (nonatomic,strong) OSOptionValue* optionValue;

/**
 * This needs to be called everywhere that cells get selected in order to be able to customise the selection colour
 */
-(void)setHighlightedBackgroundWithColour:(UIColor*)colour;

@end
