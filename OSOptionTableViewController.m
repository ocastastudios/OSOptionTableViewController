//
//  OSOptionTableViewController.m
//  Ocasta Studios
//
//  Created by Chris Birch on 26/02/2014.
//  Copyright (c) 2014 OcastaStudios. All rights reserved.
//

#import "OSOptionTableViewController.h"
#import "OSOptionValueCell.h"

#define OS_OPTION_VALUE_CELL_SELECTION_COLOUR [UIColor colorWithRed:0.93 green:0 blue:0 alpha:1]

@interface OSOptionTableViewController (friend)

/**
 * Called by option when one of its children has been selected
 */
-(void)option:(OSOption*)option valueSelected:(OSOptionValue*)optionValue;

@end

@interface OSOptionTableViewController ()

@end

@implementation OSOptionTableViewController

-(id)getChoiceOrNilForKey:(NSString*)key fromDict:(NSDictionary*)dict
{
    if ([dict.allKeys containsObject:key])
    {
        return dict[key];
    }
    else
        return nil;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"OSOptionValueCell" bundle:nil] forCellReuseIdentifier:REUSE_OS_OPTION_VALUE_CELL];
    self.tableView.allowsMultipleSelection = YES;

}


-(CGSize)contentSize
{
    [self.tableView reloadData];
    
    return self.tableView.contentSize;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)highlightCell:(OSOptionValueCell*)cell
{
    //make sure we have a selected colour
    if (!_selectedColour)
    {
        _selectedColour = OS_OPTION_VALUE_CELL_SELECTION_COLOUR;
    }
    
    [cell setHighlightedBackgroundWithColour:_selectedColour];
}

#pragma mark -
#pragma mark "Friend" methods

-(void)option:(OSOption *)option valueSelected:(OSOptionValue *)optionValue
{
    //This occurs when an options value has been selected
    //Depending on whether the option in question allows multiples values
    //we may need to deselect the other options
    
    if (!option.allowsMultipleValues)
    {
        for (OSOptionValue* value in option.values)
        {
            if (optionValue != value)
            {
                //Deselect this option value
                if (value.isSelected)
                {
                    value.isSelected = NO;
                    
                    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:value.index inSection:option.index];
                    
                    //remove highlight from cell
                    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
                }
                
            }
        }
    }
}

#pragma mark -
#pragma mark Results

-(NSDictionary *)chosenValues
{
    NSMutableDictionary* optionDict = [[NSMutableDictionary alloc] init];
    
    for (OSOption* option in _options)
    {
        id selectedValues = option.selectedValues;
        
        if (selectedValues)
        {
            //Add value(s) to dictionary under the options name
            [optionDict setObject:selectedValues forKey:option.fieldName];
        }
    }
    
    return optionDict;
}

#pragma mark -
#pragma mark Item Selection

-(OSOption *)optionWithName:(NSString *)optionName
{
    for(OSOption* option in _options)
    {
        if ([option.fieldName isEqualToString:optionName])
            return option;
    }
    
    return nil;
}
-(OSOption *)optionAtIndexPath:(NSIndexPath *)indexPath
{
    return _options[indexPath.section];
}

-(OSOptionValue *)optionValueAtIndexPath:(NSIndexPath *)indexPath
{
    OSOption* option = [self optionAtIndexPath:indexPath];
    
    return option.values[indexPath.row];
}

-(OSOptionValueCell*)optionValueCellAtIndexPath:(NSIndexPath*)indexPath
{
    OSOptionValueCell* cell = (OSOptionValueCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    return cell;
    
}


#pragma mark -
#pragma mark Item management


-(OSOption*)addOptionWithName:(NSString*)optionName andOptionDisplayName:(NSString*)displayName andAllowsMultipleSelections:(BOOL)allowMultiple andRequiresSelection:(BOOL)requiresSelection
{
    if (!_options)
    {
        _options = [NSMutableArray new];
    }
    
    OSOption* option = [[OSOption alloc] initWithName:optionName andDisplayName:displayName andAllowsMultipleSelections:allowMultiple andRequiresSelection:requiresSelection];
    
    option.parent = self;
    

    //add to options array
    [_options addObject:option];
    
    return option;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return _options.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OSOption* option = _options[section];
    
    return option.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSOptionValue* optionValue = [self optionValueAtIndexPath:indexPath];

    OSOptionValueCell *cell = (OSOptionValueCell*)[tableView dequeueReusableCellWithIdentifier:REUSE_OS_OPTION_VALUE_CELL];
    
    cell.optionValue = optionValue;
    cell.indexPath = indexPath;
    cell.parent = self;
    
    //This allows us to say which cells are selected to begin with, has no effect otherwise
    if (optionValue.isSelected)
    {
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self highlightCell:cell];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get and store the heights of the static sized cells
    static NSNumber *heightOptionValue=nil;
    if (!heightOptionValue)
    {
        UITableViewCell *heightCell = [self.tableView dequeueReusableCellWithIdentifier:REUSE_OS_OPTION_VALUE_CELL];
        heightOptionValue = @(heightCell.bounds.size.height);
    }
    
    return heightOptionValue.floatValue;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    OSOption* option = _options[section];
    
    return option.displayName;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSOptionValue* optionValue = [self optionValueAtIndexPath:indexPath];
    optionValue.isSelected = YES;
    
    OSOptionValueCell* cell = [self optionValueCellAtIndexPath:indexPath];
    [self highlightCell:cell];
    
    NSLog(@"%@",self.chosenValues);
}

-(NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSOption* option = [self optionAtIndexPath:indexPath];
    OSOptionValue* optionValue = [self optionValueAtIndexPath:indexPath];
    
    if (option.requiresSelection)
    {
        if ([option.selectedValues isKindOfClass:[NSArray class]] || [option.selectedValues isKindOfClass:[NSMutableArray class]])
        {
             NSArray* selected = option.selectedValues;
             
             //cant deselect if a selection is required and only 1 is selected
             if (selected.count == 1)
                 return nil;
        }
        else
        {
            //cant deselect if selection is required and we are trying to deselect the current selection
            if (option.selectedValues == optionValue.value)
            {
                return nil;
            }
        }
            
    }
    
    

    optionValue.isSelected = NO;
    
    //allow deselection
    return indexPath;
}


-(BOOL)areAllDefaultsSelected
{
    for (OSOption* option in self.options)
    {
#warning need to check this later on if we need to use multiple values, at the moment there can only be one default value and we assume that the selectedValues doesnt refer to multiple, only a single value
        if (option.defaultValue != option.selectedOSOptionValues)
            return NO;
    }
    
    return YES;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
