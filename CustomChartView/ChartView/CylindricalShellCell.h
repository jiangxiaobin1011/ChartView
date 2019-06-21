//
//  CylindricalShellCell.h
//  CustomChartView
//
//  Created by lorne on 2019/3/8.
//  Copyright © 2019 lorne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CylindricalShellCell : UITableViewCell
@property (nonatomic ,assign) float progress;//百分比
@property (nonatomic ,strong) UIColor* inColor;//百分比
@property (nonatomic ,strong) UILabel* valueLabel;//值label



@end

NS_ASSUME_NONNULL_END
