//
//  MyVire.h
//  DrawView
//
//  Created by henyep on 15/7/9.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CHART_PERIOD_M1               0       //历史数据的周期
#define CHART_PERIOD_M5               1
#define CHART_PERIOD_M15              2
#define CHART_PERIOD_M30              3
#define CHART_PERIOD_H1               4
#define CHART_PERIOD_H4               5
#define CHART_PERIOD_DAY              6
#define CHART_PERIOD_WEEK             7
#define CHART_PERIOD_MONTH            8
#define CHART_PERIOD_TOTAL            9
@interface MyVire : UIView
{
    int _labelTextSize;
    int _paddingTop;
    int _paddingRight;
    int _paddingBottom;
    int _paddingLeft;
    CGFloat _partren[2];
    CGRect _mRect;
    CGColorRef _lineColor;
}
@end
