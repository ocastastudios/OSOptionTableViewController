//
//  OSOptionValue.m
//  Ocasta Studios
//
//  Created by Chris Birch on 26/02/2014.
//  Copyright (c) 2014 OcastaStudios. All rights reserved.
//

#import "OSOptionValue.h"
#import "OSOption.h"

@interface OSOption (friend)

/**
 * Called by option value when it has been selected
 */
-(void)optionValueSelected:(OSOptionValue*)optionValue;

@end

@implementation OSOptionValue


-(id)initWithValue:(id)value andDisplayName:(NSString *)displayName isDefault:(BOOL)isDefault
{
    if (self = [super init])
    {
        _displayName = displayName;
        _value = value;
        self.selectedByDefault = isDefault;
    }
    
    return self;
}

-(id)initWithValue:(id)value andDisplayName:(NSString *)displayName
{
    if (self = [super init])
    {
        _displayName = displayName;
        _value = value;
    }
    
    return self;
}


-(void)setSelectedByDefault:(BOOL)selectedByDefault
{
    _selectedByDefault = selectedByDefault;
    
    self.isSelected = selectedByDefault;
}

-(BOOL)isEqual:(id)object
{
    if (!object)
    {
        return NO;
    }
    else if ([object isKindOfClass:[OSOptionValue class]])
    {
        return [super isEqual:object];
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        return [object isEqualToString:self.value];
    }
    else if ([object isKindOfClass:[NSNumber class]])
    {
        return ((NSNumber*)object).floatValue == ((NSNumber*)_value).floatValue;
    }
    else
    {
        [NSException raise:@"Unknown value type" format:@"Can't perform comparison as don't know what type of object this is!"];
    }
    
    return NO;
    
}



-(void)setIsSelected:(BOOL)isSelected
{
    //pass the message to our parent
    [_parentOption optionValueSelected:self];
    
    //Do this after to avoid getting deselected by mistake
    _isSelected = isSelected;
}

-(NSUInteger)index
{
    return [_parentOption.values indexOfObject:self];
}

-(NSString *)description
{
    return [[NSString alloc] initWithFormat:@"Value(%lu): %@ - %@",(unsigned long)self.index,_displayName,_value];
}
@end
