//
//  JChartView.m
//  CustomChartView
//
//  Created by lorne on 2019/3/8.
//  Copyright © 2019 lorne. All rights reserved.
//

#import "JChartView.h"
#import "CylindricalShellCell.h"
#import "XLabelCell.h"

#define LeftMargin 40
#define RighttMargin 30
#define TopMargin 30
#define BottomMargin 40

#define LabelYHeight 25.f   //y标签的高度


#define CylindricalShellCellID @"CylindricalShellCellID"
#define XLabellCellID @"XLabellCellID"


@interface JChartView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView* tableView;
@property (nonatomic ,strong)UITableView* xLabelTableView;

@end

@implementation JChartView


- (void)layerWillDraw:(CALayer *)layer{
    //绕着中心点旋转
//    self.tableView.transform = CGAffineTransformMakeRotation( -M_PI / 2);//旋转90度
}


- (UIColor*)xyLineColor{
    if(_xyLineColor){
        return _xyLineColor;
    }
    return [UIColor lightGrayColor];
}

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        //布局
        [self buildView:frame];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    //x,y坐标轴描线
    [self SetX_Y_line:rect];
}


#pragma mark --------------x，y轴描线
- (void)SetX_Y_line:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取画布
    CGContextSetLineWidth(ctx, 0.3);//设置线条宽度
    NSDictionary* rgbDic = [self RGBDic:self.xyLineColor];
    CGContextSetRGBStrokeColor(ctx, [rgbDic[@"R"] floatValue], [rgbDic[@"G"] floatValue], [rgbDic[@"B"] floatValue], 1);//设置线条颜色
    //开始绘制
    CGContextMoveToPoint(ctx, LeftMargin , TopMargin);//起点
    CGContextAddLineToPoint(ctx, LeftMargin, rect.size.height - BottomMargin);//交点
    CGContextAddLineToPoint(ctx, rect.size.width - RighttMargin,rect.size.height - BottomMargin );//终点
    CGContextStrokePath(ctx);//完成绘制
}


#pragma mark --------------绘制y轴上的标签
- (void)setLineChartYLabelArray:(NSArray *)lineChartYLabelArray{
    _lineChartYLabelArray = lineChartYLabelArray;
    if(!_lineChartYLabelArray || _lineChartYLabelArray.count < 2) return;//至少要俩个
    for (int idx = 0; idx < _lineChartYLabelArray.count; idx ++) {
        
        UILabel* yLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [self getLabelY_withIndex:idx], LeftMargin, LabelYHeight)];
        yLabel.text = _lineChartYLabelArray[idx];
        yLabel.textColor = [UIColor grayColor];
        yLabel.textAlignment = NSTextAlignmentCenter;
        yLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:yLabel];
    }
    
}

- (CGFloat)getLabelY_withIndex:(NSInteger)index{//创建等份的y轴标签
    if(index == 0){
        return self.frame.size.height - BottomMargin - LabelYHeight/2;
    }else if (index == _lineChartYLabelArray.count - 1){
        return TopMargin - LabelYHeight/2;
    }else{
        int spaceNum = (int)_lineChartYLabelArray.count - 2 + 1;
        float space = (self.frame.size.height - TopMargin - BottomMargin - LabelYHeight - (_lineChartYLabelArray.count -2)*LabelYHeight) / spaceNum;
        float y = self.frame.size.height - BottomMargin - LabelYHeight/2 - index * (space + LabelYHeight);
        return y;
    }
    
    
}


#pragma mark --------------布局
- (void)buildView:(CGRect)frame{
    //旋转前的size
    CGSize originalSize = CGSizeMake(frame.size.width - LeftMargin - RighttMargin, frame.size.height - TopMargin - BottomMargin);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, originalSize.height, originalSize.width) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.center = CGPointMake(LeftMargin + originalSize.width / 2, TopMargin + originalSize.height / 2);//中心点  很重要，后面需要绕着中心点旋转
    [self addSubview:self.tableView];
    [self.tableView registerClass:[CylindricalShellCell class] forCellReuseIdentifier:CylindricalShellCellID];
    [self configWithTableView:self.tableView];//配置
    
    CGSize originalSize1 = CGSizeMake(frame.size.width - LeftMargin - RighttMargin,  BottomMargin);
    self.xLabelTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, originalSize1.height, originalSize1.width) style:UITableViewStylePlain];
    self.xLabelTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.xLabelTableView.center = CGPointMake(LeftMargin + originalSize1.width / 2, frame.size.height - BottomMargin +  + originalSize1.height / 2 + 1);//中心点  很重要，后面需要绕着中心点旋转
    [self addSubview:self.xLabelTableView];
    [self.xLabelTableView registerClass:[XLabelCell class] forCellReuseIdentifier:XLabellCellID];
    [self configWithTableView:self.xLabelTableView];//配置
    
    
    
    

    
}

- (void)configWithTableView:(UITableView*)tableView{
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setShowsVerticalScrollIndicator:NO];
    tableView.transform = CGAffineTransformMakeRotation( -M_PI / 2);//旋转90度
    
//    [tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context{
    
    if(object == self.tableView)
    
    if (object == self.tableView) {
        CGPoint point = [((NSValue *)[self.tableView valueForKey:@"contentOffset"]) CGPointValue];
        [self.xLabelTableView setContentOffset:point];
    }
}

    
#pragma mark UITableViewDataSource
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView == self.tableView){
        [self.xLabelTableView setContentOffset:scrollView.contentOffset];
    }else if (scrollView == self.xLabelTableView){
        [self.tableView setContentOffset:scrollView.contentOffset];

    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (self.lineChartXLabelArray.count > self.lineChartDataArray.count) ? self.lineChartXLabelArray.count : self.lineChartDataArray.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tableView){
        CylindricalShellCell* cell = [tableView dequeueReusableCellWithIdentifier:CylindricalShellCellID];
        int value = [self.lineChartDataArray[indexPath.row] intValue];
        if(value < self.warningValue){//警告值
            cell.inColor = (self.warningColor)?(self.warningColor) : [UIColor redColor];
            cell.valueLabel.textColor = cell.inColor;
        }else{
            cell.inColor = (self.cylindColor)?(self.cylindColor) : [UIColor lightGrayColor];
            cell.valueLabel.textColor = cell.inColor;
        }
        float progress = ([self.lineChartDataArray[indexPath.row] floatValue] / self.maxValue);
        cell.progress = progress;
        cell.valueLabel.text = self.lineChartDataArray[indexPath.row];

        return cell;

    }else{
        XLabelCell* cell = [tableView dequeueReusableCellWithIdentifier:XLabellCellID];
//        cell.valueLabel.text = @"1330";
        cell.valueLabel.text = [self.lineChartXLabelArray objectAtIndex:indexPath.row];
        return cell;
    }
    
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return self.perWidth;
}


#pragma mark 公共方法
- (NSDictionary*)RGBDic:(UIColor*)aColor{
    NSMutableDictionary*dic = [NSMutableDictionary dictionary];
    UIColor* uiColor = aColor;
    CGColorRef color = [uiColor CGColor];
    size_t numComponents = CGColorGetNumberOfComponents(color);
    if(numComponents == 4){
        const CGFloat *components = CGColorGetComponents(color);
        dic[@"R"] = [NSNumber numberWithFloat:components[0]];
        dic[@"G"] = [NSNumber numberWithFloat:components[1]];
        dic[@"B"] = [NSNumber numberWithFloat:components[2]];
    }
    return [dic copy];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
