//
//  ViewController.m
//  Label渐变
//
//  Created by eparking2 on 16/8/11.
//  Copyright © 2016年 eparking2. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width     //屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //屏幕高度

#define kLayerWidth (SCREEN_WIDTH/4)

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (nonatomic,strong)CALayer *maskLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _maskLayer = [[CALayer alloc] init];
    _maskLayer.frame = CGRectMake(0, 10, kLayerWidth, 40);
    //    _maskLayer.cornerRadius = 20;
    _maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.viewBg.layer.mask = _maskLayer;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self.view];
    
    CGFloat centerX = point.x;
    
    _maskLayer.frame = CGRectMake(centerX-kLayerWidth/2, 10, kLayerWidth, 40);
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_maskLayer.frame.origin.x<0) {
        _maskLayer.frame = CGRectMake(0, 10, kLayerWidth, 40);
    }else if (_maskLayer.frame.origin.x + _maskLayer.frame.size.width > SCREEN_WIDTH)
    {
        _maskLayer.frame = CGRectMake(SCREEN_WIDTH - kLayerWidth, 10, kLayerWidth, 40);
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch  locationInView:self.view];
    
    CGFloat centerX = point.x;
    
    _maskLayer.frame = CGRectMake(centerX-kLayerWidth/2, 10, kLayerWidth, 40);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
