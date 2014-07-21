//
//  OSOptionValue.h
//  Ocasta Studios
//
//  Created by Chris Birch on 26/02/2014.
//  Copyright (c) 2014 OcastaStudios. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSOption;

@interface OSOptionValue : NSObject

/**
 * The option that this value belongs to
 */
@property (nonatomic,weak) OSOption* parentOption;

/**
 * How this value is displayed to the user
 */
@property (nonatomic,strong) NSString* displayName;
/**
 * The value of this
 */
@property (nonatomic,strong) id value;

/**
 * A value indicating whether or not this option is selected
 */
@property (nonatomic,assign) BOOL isSelected;

/**
 * The index of this value within the array of sibling values
 */
@property (nonatomic,readonly) NSUInteger index;

/**
 * Inits this instance by specifying its value and display name
 */
-(id)initWithValue:(id)value andDisplayName:(NSString*)displayName;


/**
 * Inits this instance by specifying its value and display name and whether or not it is selected by default
 */
-(id)initWithValue:(id)value andDisplayName:(NSString *)displayName isDefault:(BOOL)isDefault;

/**
 * YES if this value is selected by default
 */
@property(nonatomic,assign) BOOL selectedByDefault;



@end
