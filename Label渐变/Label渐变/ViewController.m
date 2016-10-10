//
//  ViewController.m
//  Label渐变
//
//  Created by eparking2 on 16/8/11.
//  Copyright © 2016年 eparking2. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (nonatomic,strong)CALayer *maskLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _maskLayer = [[CALayer alloc] init];
    _maskLayer.frame = CGRectMake(0, 10, 100, 40);
//    _maskLayer.cornerRadius = 20;
    _maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.viewBg.layer.mask = _maskLayer;
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
   CGPoint point = [touch  locationInView:self.view];
    
    CGFloat centerX = point.x;
    
    _maskLayer.frame = CGRectMake(centerX-50, 10, 100, 40);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
