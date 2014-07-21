//
//  OSOption.h
//  Ocasta Studios
//
//  Created by Chris Birch on 26/02/2014.
//  Copyright (c) 2014 OcastaStudios. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OSOptionTableViewController;

@class OSOptionValue;

@interface OSOption : NSObject

/**
 * Inits a new instance
 */
-(id)initWithName:(NSString*)name andDisplayName:(NSString*)displayName andAllowsMultipleSelections:(BOOL)allowsMultiple andRequiresSelection:(BOOL)requiresSelection;

/**
 * Returns the default value for this option
 */
@property(nonatomic,readonly)OSOptionValue* defaultValue;
/**
 * The parent that this option belongs to
 */
@property (nonatomic,weak) OSOptionTableViewController* parent;
/**
 * How this option is displayed to the user
 */
@property (nonatomic,strong) NSString* displayName;
/**
 * The name of this option as it is used in code
 */
@property (nonatomic,strong) NSString* fieldName;

/**
 * List of values that can be associated with this option
 */
@property (nonatomic,strong) NSMutableArray* values;

/**
 * Set to YES if multiple values can be selected for this option
 */
@property (nonatomic,assign) BOOL allowsMultipleValues;

/**
 * The index of this option within the array of sibling options
 */
@property (nonatomic,readonly) NSUInteger index;
/**
 * Adds the  OSOptionValues contained within the specified array
 */
-(void)addValuesFromArray:(NSArray*)values;

/**
 * Returns the option value instance that has the specified value or nil if doesnt exist.
 */
-(OSOptionValue*)optionValueWithValue:(id)value;

/**
 * YES if at least one value MUST be selected
 */
@property (nonatomic,assign) BOOL requiresSelection;

/**
 * Returns either an NSArray of values or a single ID value depending on the state of allowsMultipleValues
 */
@property (nonatomic,readonly) id selectedValues;

/**
 * Returns either an NSArray of OSOptionValues or a single OSOptionValue depending on the state of allowsMultipleValues
 */
@property (nonatomic,readonly) id selectedOSOptionValues;
/**
 * Returns YES if one or more values are selected
 */
@property (nonatomic,readonly) BOOL hasSelection;

@end
