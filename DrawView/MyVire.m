//
//  MyVire.m
//  DrawView
//
//  Created by henyep on 15/7/9.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "MyVire.h"

@implementation MyVire

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self initConfig];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)initConfig{
    _labelTextSize = 10;
     _paddingTop = 12;
     _paddingRight = 45;
     _paddingBottom = 15;
     _paddingLeft = 8;
    _partren[0] = 2;
    _partren[1] = 3;
    _mRect=CGRectMake(_paddingLeft, _paddingTop, self.frame.size.width-_paddingLeft-_paddingRight, self.frame.size.height-_paddingTop-_paddingBottom);
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();

    const CGFloat lineColor[] = {0x3E/255.0, 0x6E/255.0, 0x9A/255.0, 1.0};
    _lineColor = CGColorCreate(rgb, lineColor);
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    [self drawXAxis:context];
    [self drawYAxis:context];
//    [self drawTag:context];
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    CGFloat colors[] =
    {
        0 / 255.0,    0 / 255.0,    0 / 255.0, 0.0 / 255.0,
        0x3E / 255.0, 0x6E / 255.0, 0x9A / 255.0, 127.0 / 255.0,
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    
//    CGColorSpaceRelease(rgb);
    CGContextDrawLinearGradient(context,gradient,CGPointMake(_mRect.origin.x,_mRect.origin.y) ,CGPointMake(_mRect.origin.x,_mRect.origin.y+_mRect.size.height),kCGGradientDrawsBeforeStartLocation);
    
//    CGContextRestoreGState(context);
//     CGPoint p[4];
//    CGContextAddLines(context, p, 4);
//    CGContextSetLineDash(context, 0, _partren , 0);
//    CGContextSetStrokeColorWithColor(context, _lineColor);
//    CGContextDrawPath(context, kCGPathStroke);
}

-(void)drawXAxis:(CGContextRef)context{
    CGPoint leftPoint = CGPointMake(_mRect.origin.x, _mRect.size.height + _mRect.origin.y);
    CGPoint rightPoint = CGPointMake(_mRect.origin.x + _mRect.size.width, leftPoint.y);
    NSLog(@"%@",NSStringFromCGPoint(leftPoint));
    NSLog(@"%@",NSStringFromCGPoint(rightPoint));
    Boolean first = true;
    do {
        if (first) {
            CGContextSetLineDash(context, 0, _partren , 0);
            first = false;
        }else{
            CGContextSetLineDash(context, 0, _partren , 2);
        }
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextMoveToPoint(context, leftPoint.x, leftPoint.y);
        CGContextAddLineToPoint(context, rightPoint.x, rightPoint.y);//x轴
        CGContextDrawPath(context, kCGPathStroke);
        
        NSString *labelStr = @"bbbbb";
        //        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        //        CGSize labelSize = [labelStr sizeWithFont:_labelFont];
        CGSize labelSize =  [labelStr sizeWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:_labelTextSize], NSFontAttributeName,nil]];
        //        [labelStr drawAtPoint:CGPointMake(rightPoint.x, rightPoint.y-labelSize.height) withFont:_labelFont];
        [labelStr drawAtPoint:CGPointMake(rightPoint.x, rightPoint.y-labelSize.height) withAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:_labelTextSize], NSFontAttributeName,nil]];
        leftPoint.y -= 25.5;
        rightPoint.y = leftPoint.y;
        //        ylabel += spcp;
    } while (leftPoint.y >= _mRect.origin.y);
    
}

-(void)drawYAxis:(CGContextRef)context{
    float _halfCandleWidth=(float)_mRect.size.width/6 ;
    float rightPointX = _mRect.origin.x + _mRect.size.width;
    CGPoint topPoint = CGPointMake(rightPointX - _halfCandleWidth, _mRect.origin.y);
    CGPoint bottomPoint = CGPointMake(topPoint.x, _mRect.origin.y + _mRect.size.height);

    Boolean first = true;
    int xLabelIndex = 0;
    NSString *xLabel;
    do {
        if (first) {
            CGContextSetLineDash(context, 0, _partren , 0);
            CGContextMoveToPoint(context, rightPointX, topPoint.y);
            CGContextAddLineToPoint(context, rightPointX, bottomPoint.y);
            CGContextDrawPath(context, kCGPathStroke);
            first = false;
        }
        CGContextSetLineDash(context, 0, _partren , 2);
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextMoveToPoint(context, topPoint.x, topPoint.y);
        CGContextAddLineToPoint(context, bottomPoint.x, bottomPoint.y);
        CGContextDrawPath(context, kCGPathStroke);
        
//        Candle *candle = [_candleList objectAtIndex:xLabelIndex];
//        xLabel = [_dateFormatter stringFromDate:candle.date];
        
//        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        xLabel=@"aaaa";
//        CGSize xLabelSize = [xLabel sizeWithFont:[UIFont systemFontOfSize:_labelTextSize]];
       CGSize xLabelSize =  [xLabel sizeWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:_labelTextSize], NSFontAttributeName,nil]];
//        [xLabel drawAtPoint:CGPointMake(bottomPoint.x-xLabelSize.width/2, bottomPoint.y) withFont:[UIFont systemFontOfSize:_labelTextSize]];
        [xLabel drawAtPoint:CGPointMake(bottomPoint.x-xLabelSize.width/2, bottomPoint.y) withAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:_labelTextSize], NSFontAttributeName,nil]];
        topPoint.x -= 52.5;
        bottomPoint.x = topPoint.x;
        xLabelIndex += 10;
    } while (topPoint.x >= _mRect.origin.x);
}

-(NSString *)period2Str:(int) period{
    switch (period) {
        case CHART_PERIOD_M1:
            return @"M1";
        case CHART_PERIOD_M5:
            return @"M5";
        case CHART_PERIOD_M15:
            return @"M15";
        case CHART_PERIOD_M30:
            return @"M30";
        case CHART_PERIOD_H1:
            return @"H1";
        case CHART_PERIOD_H4:
            return @"H4";
        case CHART_PERIOD_DAY:
            return @"D1";
        default:
            return @"";
    }
}
-(void)drawTag:(CGContextRef)context{
    NSString *tagStr = [NSString stringWithFormat:@" %@",[self period2Str:CHART_PERIOD_M1]];
    CGSize tagStrSize = [tagStr sizeWithAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:_labelTextSize], NSFontAttributeName,nil]];
    CGPoint tagStrP = CGPointMake(_mRect.origin.x + 2, _mRect.origin.y+2);
    CGRect textBackRect = CGRectMake(tagStrP.x,tagStrP.y,0,0);
    textBackRect.size = tagStrSize;
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, textBackRect);
    
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
//    [tagStr drawAtPoint:tagStrP withFont:_labelFont];
    [tagStr drawAtPoint:tagStrP withAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:_labelTextSize], NSFontAttributeName,nil]];
}

@end
