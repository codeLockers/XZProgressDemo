//
//  XZProgressView.m
//  XZProgressDemo
//
//  Created by 徐章 on 16/8/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZProgressView.h"
#define angle2Arc(angle) (angle * M_PI /180)

@interface XZProgressView(){

    UIColor *_backLineColor;
    UIColor *_progressLineColor;
    
    CGPoint _centerPoint;
    
    CGFloat _value;
    CGFloat _angle;
    
    
}

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation XZProgressView

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        _backLineColor = [UIColor redColor];
        _progressLineColor = [UIColor greenColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{

    _centerPoint = CGPointMake(rect.size.width/2.0f, rect.size.height/2.0f);
    CGFloat radius = MIN(rect.size.width, rect.size.height)/2.0f;
    
    //画质底色圆环
    UIBezierPath *arc1 = [UIBezierPath bezierPathWithArcCenter:_centerPoint radius:radius*0.9 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [arc1 setLineWidth:radius*0.1];
    [_backLineColor setStroke];
    [arc1 stroke];
    
    //起点
    UIBezierPath *startArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerPoint.x, _centerPoint.y+radius*0.9) radius:radius*0.1 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [_progressLineColor setFill];
    [startArc fill];
    
    
    //绘制进度
    UIBezierPath *arc2 = [UIBezierPath bezierPathWithArcCenter:_centerPoint radius:radius*0.9 startAngle:M_PI_2 endAngle:angle2Arc(_angle)+M_PI_2 clockwise:YES];
    [_progressLineColor setStroke];
    [arc2 setLineWidth:radius*0.1];
    [arc2 setLineCapStyle:kCGLineCapRound];
    [arc2 stroke];
    
    [self drawText];
}


- (void)drawText{

    //
    NSMutableAttributedString* precentStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f",_value]];
    NSRange precentRange = NSMakeRange(0, precentStr.string.length);
    
    [precentStr addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:12]
                       range:precentRange];
    
    [precentStr addAttribute:NSForegroundColorAttributeName
                       value:_progressLineColor
                       range:precentRange];
    
    CGRect precentRect = [precentStr boundingRectWithSize:self.bounds.size
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                  context:nil];
    
    CGFloat precentX = _centerPoint.x - precentRect.size.width * 0.5;
    CGFloat precentY = _centerPoint.y + precentRect.size.height;
    
    [precentStr drawAtPoint:CGPointMake(precentX, precentY)];
}

-(void)animatePrecent{

    if (_value < self.percent) {
        
        if (self.percent - _value >= 1) {
            _value ++;
        }else{
        
            _value = self.percent;
        }
        
        
        _angle = _value/100.0f * 360.0f;
        [self setNeedsDisplay];
    }else{
    
        self.displayLink.paused = YES;
        _value = 0.0f;
    }

}


#pragma mark - Setter && Getter
- (void)setPercent:(CGFloat)percent{

    _percent = percent;
    self.displayLink.paused = NO;
}

- (CADisplayLink *)displayLink{

    if (!_displayLink) {
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animatePrecent)];
        _displayLink.frameInterval = 1;
        
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}


@end
