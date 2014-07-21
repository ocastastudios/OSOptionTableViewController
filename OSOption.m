//
//  OSOption.m
//  Ocasta Studios
//
//  Created by Chris Birch on 26/02/2014.
//  Copyright (c) 2014 OcastaStudios. All rights reserved.
//

#import "OSOption.h"
#import "OSOptionValue.h"
#import "OSOptionTableViewController.h"


@interface OSOptionTableViewController (friend)

/**
 * Called by option when one of its children has been selected
 */
-(void)option:(OSOption*)option valueSelected:(OSOptionValue*)optionValue;

@end


@interface OSOption (friend)

/**
 * Called by option value when it has been selected
 */
-(void)optionValueSelected:(OSOptionValue*)optionValue;

@end


@implementation OSOption

-(id)initWithName:(NSString*)name andDisplayName:(NSString*)displayName andAllowsMultipleSelections:(BOOL)allowsMultiple andRequiresSelection:(BOOL)requiresSelection
{
    if (self = [super init])
    {
        _fieldName = name;
        _displayName = displayName;
        _allowsMultipleValues = allowsMultiple;
        _requiresSelection = requiresSelection;
        
        _values = [NSMutableArray new];
    }
    return self;
}


-(NSUInteger)index
{
    return [_parent.options indexOfObject:self];
}

-(void)addValuesFromArray:(NSArray*)values
{
    if(!_values)
    {
        _values = [NSMutableArray new];
    }
    
    [_values addObjectsFromArray:values];
    
    //set the parent
    for (OSOptionValue* v in values)
    {
        v.parentOption = self;
    }
}

-(OSOptionValue *)defaultValue
{
    for (OSOptionValue* value in _values)
    {
        if (value.selectedByDefault)
            return value;
    }
    
    return nil;
}
-(id)selectedOSOptionValues
{
    if (_allowsMultipleValues)
    {
        NSMutableArray* values = [[NSMutableArray alloc] init];
        
        for (OSOptionValue* value in _values)
        {
            if (value.isSelected)
            {
                [values addObject:value];
            }
        }
        
        //only add the option if there was a selection
        if (values.count)
        {
            return values;
        }
        else
            return nil;
    }
    else
    {
        //Only a single value may be selected
        
        for (OSOptionValue* value in _values)
        {
            if (value.isSelected)
            {
                //set the value for this option
                return value;
            }
        }
        
        return nil;
        
    }

}
-(id)selectedValues
{
    
    id selected = self.selectedOSOptionValues;
    
    if (_allowsMultipleValues)
    {
        NSArray*selectedArray = selected;
        if (selectedArray.count)
        {
            NSMutableArray* output = [NSMutableArray new];
            
            for (OSOptionValue* value in selected)
            {
                [output addObject:value.value];
            }
            
            return output;
        }
        else
            return nil;
    }
    else
    {
        return ((OSOptionValue*)selected).value;
    }
    
}


-(OSOptionValue *)optionValueWithValue:(id)value
{
    for (OSOptionValue* optionValue in _values)
    {
        if([optionValue isEqual:value])
        {
            return optionValue;
        }
    }
    
    return nil;
  
}

#pragma mark -
#pragma mark "Friend" methods


-(void)optionValueSelected:(OSOptionValue *)optionValue
{
    //pass the message up to our parent
    [_parent option:self valueSelected:optionValue];
}




#pragma mark -
#pragma mark Misc


-(NSString *)description
{
    return [[NSString alloc] initWithFormat:@"Value(%lu): %@",(unsigned long)self.index,_displayName];
}



@end
