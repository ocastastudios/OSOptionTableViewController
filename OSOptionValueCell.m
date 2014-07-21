//
//  OSOptionValueCell.m
//  Ocasta Studios
//
//  Created by Chris Birch on 26/02/2014.
//  Copyright (c) 2014 OcastaStudios. All rights reserved.
//

#import "OSOptionValueCell.h"
#import "OSOptionValue.h"
#import "OSOptionTableViewController.h"

@interface OSOptionValueCell ()
{
    
}

@property (weak, nonatomic) IBOutlet UIView *viewSeperator;

@property (weak, nonatomic) IBOutlet UILabel *lbText;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;

@end
@implementation OSOptionValueCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    //add gesture recogniser for when the cell is already selected and hence
    
    UITapGestureRecognizer* recog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    recog.delegate = self;
    [self addGestureRecognizer:recog];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.isSelected;
}

-(void)tapped:(UITapGestureRecognizer*)gestureRecog
{
    //call selected as the tableview doesnt send selected event once it has already been selected

    [_parent tableView:_parent.tableView didSelectRowAtIndexPath:_indexPath];

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setHighlightedBackgroundWithColour:(UIColor*)colour
{
    CGRect rect = self.bounds;
    UIView *bgColorView = [[UIView alloc] initWithFrame:rect];
    bgColorView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.02];// colour;
    
    bgColorView.layer.masksToBounds = YES;
   [self setSelectedBackgroundView:bgColorView];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
        
        _selectedImage.alpha = 0;
        _selectedImage.hidden = NO;
        
        [UIView animateWithDuration:0.5 animations:^{
            _selectedImage.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }

    if (!selected)
    {
        if (!animated)
        {
            _selectedImage.hidden = YES;
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                _selectedImage.alpha = 0;
            } completion:^(BOOL finished) {
                 _selectedImage.hidden = YES;
            }];
        }
    }
    
}


-(void)layoutSubviews
{
    _lbText.text = _optionValue.displayName;
    


    CGRect rect = _viewSeperator.frame;
    rect.origin.y = self.bounds.size.height - 0.5f;
    rect.size.height = 0.5f;
    _viewSeperator.frame = rect;
    
  //  self.selectionStyle = UITableViewCellSelectionStyleNone;
//    if (_optionValue.isSelected)
//    {
//        [self hightlightCell];
//    }
//    else
//    {
//        [self deselectCell];
//    }
}

@end
