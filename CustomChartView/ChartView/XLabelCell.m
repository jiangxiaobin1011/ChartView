//
//  XLabelCell.m
//  CustomChartView
//
//  Created by lorne on 2019/3/11.
//  Copyright © 2019 lorne. All rights reserved.
//

#import "XLabelCell.h"

@interface XLabelCell()

@end

@implementation XLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{
   
    
    _valueLabel.frame = CGRectMake(0, 0,self.frame. size.height,30);
    _valueLabel.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height/2);
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self buildView];
    }
    return self;
}

- (void)buildView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    
    _valueLabel = [[UILabel alloc] init];
    _valueLabel.textAlignment = NSTextAlignmentCenter;
    _valueLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_valueLabel];
    //    _valueLabel.backgroundColor = [UIColor redColor];
    
    //绕着中心点旋转
    _valueLabel.transform = CGAffineTransformMakeRotation( M_PI / 2);//旋转90度

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
