//
//  FourthCellButton.m
//  seek
//
//  Created by Dan on 2021/3/4.
//  Copyright © 2021 Dan. All rights reserved.
//

#import "FourthCellButton.h"

@implementation FourthCellButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _cellBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _cellBgView.backgroundColor = [UIColor clearColor];
        [self addSubview:_cellBgView];
        
        _cellImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetHeight(_cellBgView.frame) / 2 - 10, 20, 20)];
        [_cellBgView addSubview:_cellImgView];
        
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_cellBgView.frame) - 20 - 10, CGRectGetHeight(_cellBgView.frame) / 2 - 8, 10, 16)];
        arrowImgView.image = [UIImage imageNamed:@"back_right"];
        arrowImgView.userInteractionEnabled = YES;
        [_cellBgView addSubview:arrowImgView];
        
        _cellLb = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cellImgView.frame) + 20, 0, 150, CGRectGetHeight(_cellBgView.frame))];
        _cellLb.textColor = kLightBlackColor;
        _cellLb.userInteractionEnabled = YES;
        [_cellBgView addSubview:_cellLb];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted)
    {
        _cellBgView.backgroundColor = kPlaceholderColor;
    }
    else
    {
        _cellBgView.backgroundColor = [UIColor clearColor];
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
