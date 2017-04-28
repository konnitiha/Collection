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

@interface ViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (nonatomic,strong)CALayer *maskLayer;


@property (nonatomic,strong)CAShapeLayer *layerPath;
@property (nonatomic,strong)CALayer *layerPlane;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _maskLayer = [[CALayer alloc] init];
    _maskLayer.frame = CGRectMake(0, 10, kLayerWidth, 40);
    //    _maskLayer.cornerRadius = 20;
    _maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.viewBg.layer.mask = _maskLayer;
    
    
    [self prepareToAnimation];
}

- (void)prepareToAnimation{
    _layerPath = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(400, 520)];
    [path addCurveToPoint:CGPointMake(320, 370) controlPoint1:CGPointMake(400, 520) controlPoint2:CGPointMake(420, 450)];
    [path addCurveToPoint:CGPointMake(310, 70) controlPoint1:CGPointMake(220, 290) controlPoint2:CGPointMake(-40, 70)];
    [path addCurveToPoint:CGPointMake(70, 310) controlPoint1:CGPointMake(600, 70) controlPoint2:CGPointMake(400, 310)];
    
    _layerPath.path = path.CGPath;
    _layerPath.lineWidth = 3;
    _layerPath.strokeColor = [UIColor orangeColor].CGColor;
    _layerPath.fillColor = [UIColor clearColor].CGColor;
  
    
    _layerPlane = [CALayer layer];
    
    UILabel *labelPlane = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    labelPlane.text = @"✈️";
    UIGraphicsBeginImageContext(labelPlane.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [labelPlane.layer renderInContext:ctx];
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _layerPlane.affineTransform = CGAffineTransformRotate(labelPlane.transform, M_PI_4*3/4);
    _layerPlane.contents = (id)tImage.CGImage;
    _layerPlane.bounds = CGRectMake(0, 0, 30, 30);
 
}
- (IBAction)startPlaneAnimation:(UIButton *)sender {
    
    
     [self.view.layer addSublayer:_layerPath];
     [self.view.layer addSublayer:_layerPlane];
    //✈️动画
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim1.fromValue = @0;
    anim1.toValue = @1;
    anim1.duration = 4.7;
    anim1.delegate = self;
    [anim1 setValueFunction:[CAValueFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_layerPath addAnimation:anim1 forKey:@"path"];

    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim2.path = _layerPath.path;
    anim2.duration = 5;
    anim2.calculationMode = kCAAnimationCubicPaced;
    anim2.rotationMode = kCAAnimationRotateAuto;
    [_layerPlane addAnimation:anim2 forKey:@"plane"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_layerPath removeFromSuperlayer];
    [_layerPlane removeFromSuperlayer];
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
