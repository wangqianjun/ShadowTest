//
//  ViewController.m
//  ShadowTest
//
//  Created by 王钱钧 on 14-9-1.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *bgImage = [UIImage imageNamed:@"embedded_bg.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    UIImage *image = [UIImage imageNamed:@"dccp.jpeg"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    imgView.center = self.view.center;
    
    imgView.layer.shadowColor = [UIColor blackColor].CGColor;
    imgView.layer.shadowOpacity = 0.7;
    imgView.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
    imgView.layer.shadowRadius = 2.0f;
    imgView.layer.masksToBounds = NO;
    
//    imgView.layer.shadowPath = [self renderRect:imgView];
    imgView.layer.shadowPath = [self renderTrapezoid:imgView];
    
    [self.view addSubview:imgView];
    
	// Do any additional setup after loading the view, typically from a nib.
}

// 沿着imageView bounds产生阴影
- (CGPathRef)renderRect:(UIImageView *)imageView
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:imageView.bounds];
    return path.CGPath;
}

// 不规则四边形
- (CGPathRef)renderTrapezoid:(UIImageView *)imageView
{
    CGSize size = imageView.bounds.size;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(size.width * 0.33f, size.height * 0.66f)];
    [path addLineToPoint:CGPointMake(size.width * 0.66f, size.height *0.66f)];
    [path addLineToPoint:CGPointMake(size.width * 1.15f, size.height * 1.15f)];
	[path addLineToPoint:CGPointMake(size.width * -0.15f, size.height * 1.15f)];
    return path.CGPath;
}

// 椭圆
- (CGPathRef)renderEllipse:(UIView*)imgView {
	CGSize size = imgView.bounds.size;
	
	CGRect ovalRect = CGRectMake(0.0f, size.height + 5, size.width - 10, 15);
	UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
	
	return path.CGPath;
}

// 翻页效果
- (CGPathRef)renderPaperCurl:(UIView*)imgView {
	CGSize size = imgView.bounds.size;
	CGFloat curlFactor = 15.0f;
	CGFloat shadowDepth = 5.0f;
    
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(0.0f, 0.0f)];
	[path addLineToPoint:CGPointMake(size.width, 0.0f)];
	[path addLineToPoint:CGPointMake(size.width, size.height + shadowDepth)];
	[path addCurveToPoint:CGPointMake(0.0f, size.height + shadowDepth)
			controlPoint1:CGPointMake(size.width - curlFactor, size.height + shadowDepth - curlFactor)
			controlPoint2:CGPointMake(curlFactor, size.height + shadowDepth - curlFactor)];
    
	return path.CGPath;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
