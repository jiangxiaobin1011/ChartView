//
//  JChartView.h
//  CustomChartView
//
//  Created by lorne on 2019/3/8.
//  Copyright © 2019 lorne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ItemSelectBlock)(NSUInteger index);


@interface JChartView : UIView


//----------绘制部分----------


/**
x.y坐标轴线的颜色
 */
@property(nonatomic ,strong) UIColor* xyLineColor;

/**
 每个柱形的宽度
 */
@property (nonatomic ,assign)CGFloat perWidth;




/**
 柱状色
 */
@property (nonatomic ,strong)UIColor* cylindColor;


/**
 预警柱状色
 */
@property (nonatomic ,strong)UIColor* warningColor;





//----------数据部分----------


/**
 最高峰值
 */
@property (nonatomic ,assign)float maxValue;


/**
 预警值
 */
@property (nonatomic ,assign)float warningValue;

/**
 x轴的标签组
 */
@property (nonatomic ,strong)NSArray* lineChartXLabelArray;

/**
 y轴的标签组
 */
@property (nonatomic ,strong)NSArray* lineChartYLabelArray;


/**
 数据源
 */
@property (nonatomic ,strong)NSArray* lineChartDataArray;


/**
 选中回调
 */
@property (nonatomic ,strong)ItemSelectBlock selectBlock;






@end

NS_ASSUME_NONNULL_END
