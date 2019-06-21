//
//  ViewController.m
//  CustomChartView
//
//  Created by lorne on 2019/3/8.
//  Copyright © 2019 lorne. All rights reserved.
//

#import "ViewController.h"
#import "JChartView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor  = [UIColor whiteColor];
    
    
    JChartView* chartView = [[JChartView alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 250)];
    chartView.backgroundColor = [UIColor whiteColor];
    //配置参数
    chartView.warningColor = [UIColor redColor];
    chartView.warningValue = 50;
    chartView.xyLineColor = [UIColor redColor];
    chartView.lineChartYLabelArray = @[@"0",@"25",@"50",@"75",@"100"];
    chartView.perWidth = 45;
    chartView.cylindColor = [UIColor blueColor];
    chartView.lineChartXLabelArray = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月",];
    
    chartView.maxValue = 100;
    chartView.lineChartDataArray = @[@"30",@"70",@"20",@"50",@"80",@"22",@"33",@"66",@"11",@"33",@"44",@"77",];
    [self.view addSubview:chartView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


@end
