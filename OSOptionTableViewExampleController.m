//
//  OSOptionTableViewExampleController.m
//  Ocasta Studios
//
//  Created by Chris Birch on 10/07/2014.
//  Copyright (c) 2014 Ocasta Studios. All rights reserved.
//

#import "OSOptionTableViewExampleController.h"
#import "OSOption.h"

@interface OSOptionTableViewExampleController ()

@end

@implementation OSOptionTableViewExampleController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)apply
{
    NSString* option1Value=nil,*option2Value=nil;
    
    
    OSOption* option = [self optionWithName:@"Option1"];
    
    id selected = option.selectedValues;
    
    if (selected)
    {
        option1Value = selected;
    }

    option = [self optionWithName:@"Option2"];
    
    selected = option.selectedValues;
    
    if (selected)
    {
        option2Value = selected;
    }
    
    
    //Fire Block if we've been given one
    if (self.valuesChosen)
        self.valuesChosen(option1Value,option2Value);
    
    
}

/**
 * Configures the controller with options and values
 */
-(void)setup
{
    //set up options
    OSOption* option = [self addOptionWithName:@"Option1" andOptionDisplayName:@"Test Option 1" andAllowsMultipleSelections:NO andRequiresSelection:YES];
    
    
    [option addValuesFromArray:@[
                                        [[OSOptionValue alloc] initWithValue:@"A" andDisplayName:@"A" isDefault:YES],
                                        [[OSOptionValue alloc] initWithValue:@"B" andDisplayName:@"B"],
                                        [[OSOptionValue alloc] initWithValue:@"C" andDisplayName:@"C"]
                                        ]];
    
    
    option = [self addOptionWithName:@"Option2" andOptionDisplayName:@"Test Option 2" andAllowsMultipleSelections:NO andRequiresSelection:YES];
    
    
    [option addValuesFromArray:@[
                                 [[OSOptionValue alloc] initWithValue:@"Aardvark" andDisplayName:@"Aardvark" isDefault:YES],
                                 [[OSOptionValue alloc] initWithValue:@"Cat" andDisplayName:@"Cat"],
                                 [[OSOptionValue alloc] initWithValue:@"Zebra" andDisplayName:@"Zebra"]
                                 ]];
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    
    [self apply];
    
    
}

@end
