//
//  ThirdCellButton.m
//  seek
//
//  Created by Dan on 2021/3/2.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "ThirdCellButton.h"

@implementation ThirdCellButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIImage *cellBgImg = [UIImage imageNamed:@"third_cell_bg"];
        _cellBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cellBgImg.size.height * self.frame.size.width / cellBgImg.size.width)];
        _cellBgImgView.image = cellBgImg;
        _cellBgImgView.userInteractionEnabled = YES;
        [self addSubview:_cellBgImgView];
        
        _cellImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(_cellBgImgView.frame) / 2 - 20, 40, 40)];
        [_cellBgImgView addSubview:_cellImgView];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_cellBgImgView.frame) - 20 - 10, CGRectGetHeight(_cellBgImgView.frame) / 2 - 8, 10, 16)];
        arrowImgView.image = [UIImage imageNamed:@"back_right"];
        arrowImgView.userInteractionEnabled = YES;
        [_cellBgImgView addSubview:arrowImgView];
        
        _cellLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cellImgView.frame) + 10, 0, CGRectGetWidth(_cellBgImgView.frame) - CGRectGetMaxX(_cellImgView.frame) - 10 - 38 - 10, CGRectGetHeight(_cellBgImgView.frame))];
        _cellLb.textColor = kLightBlackColor;
        _cellLb.userInteractionEnabled = YES;
        [_cellBgImgView addSubview:_cellLb];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted)
    {
        _cellBgImgView.image = [UIImage imageNamed:@"third_cell_bg_sel"];
    }
    else
    {
        _cellBgImgView.image = [UIImage imageNamed:@"third_cell_bg"];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint btnP = [self convertPoint:point toView:self];
    if ([self pointInside:btnP withEvent:event])
    {
        return self;
    }
    else
    {
        return [super hitTest:point withEvent:event];
    }
}

@end
