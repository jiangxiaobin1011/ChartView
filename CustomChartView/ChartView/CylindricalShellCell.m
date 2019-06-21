//
//  CylindricalShellCell.m
//  CustomChartView
//
//  Created by lorne on 2019/3/8.
//  Copyright © 2019 lorne. All rights reserved.
//

#import "CylindricalShellCell.h"

@interface CylindricalShellCell()

@property (nonatomic ,strong) UIButton* cylidricalShellView;//柱形



@end


@implementation CylindricalShellCell


- (void)layoutSubviews{
    _cylidricalShellView.frame = CGRectMake(0, 10,self.frame. size.width * _progress, self.frame.size.height - 20);
    
    _valueLabel.frame = CGRectMake(0, 0,self.frame. size.height,30);
    _valueLabel.center = CGPointMake(CGRectGetMaxX(_cylidricalShellView.frame) + _valueLabel.frame.size.height / 2, _cylidricalShellView.center.y);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self buildView];
    }
    return self;
}

- (void)buildView{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    self.contentView.backgroundColor  = [UIColor greenColor];
    _cylidricalShellView = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 0, self.contentView.frame.size.height - 20)];
    [self addSubview:_cylidricalShellView];
    
    _valueLabel = [[UILabel alloc] init];
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    _valueLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_valueLabel];
//    _valueLabel.backgroundColor = [UIColor redColor];
    
    //绕着中心点旋转
    _valueLabel.transform = CGAffineTransformMakeRotation( M_PI / 2);//旋转90度

}


- (void)setInColor:(UIColor *)inColor{
    _inColor = inColor;
    _cylidricalShellView.backgroundColor =_inColor;
    _valueLabel.textColor = _inColor;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
