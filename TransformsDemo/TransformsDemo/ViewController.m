//
//  ViewController.m
//  TransformsDemo
//
//  Created by 向洪 on 2017/7/19.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     
     CG_EXTERN void CGContextScaleCTM(CGContextRef cg_nullable c,
     CGFloat sx, CGFloat sy) 缩放
     
     CG_EXTERN void CGContextRotateCTM(CGContextRef cg_nullable c, CGFloat angle) 旋转
     
     CG_EXTERN void CGContextConcatCTM(CGContextRef cg_nullable c, CGAffineTransform transform) CGAffineTransform 链接
     
     CG_EXTERN CGAffineTransform CGContextGetCTM(CGContextRef cg_nullable c) 得到一个CGAffineTransform
     
     
     // 从抽象坐标到像素的转换
     CG_EXTERN CGAffineTransform CGContextGetUserSpaceToDeviceSpaceTransform(CGContextRef cg_nullable c) // 获取CGAffineTransform
     
     CG_EXTERN CGPoint CGContextConvertPointToDeviceSpace(CGContextRef cg_nullable c, CGPoint point) // 一个抽象坐标点转换到设备像素空间
     CG_EXTERN CGPoint CGContextConvertPointToUserSpace(CGContextRef cg_nullable c, CGPoint point) // 一个设备像素空间转换到一个抽象坐标点
     
     CG_EXTERN CGSize CGContextConvertSizeToDeviceSpace(CGContextRef cg_nullable c, CGSize size) // 一个抽象坐标size转换到设备像素空间
     CG_EXTERN CGSize CGContextConvertSizeToUserSpace(CGContextRef cg_nullable c, CGSize size) // 一个设备像素空间size转换到一个抽象坐标
     
     CG_EXTERN CGRect CGContextConvertRectToDeviceSpace(CGContextRef cg_nullable c, CGRect rect) / 一个抽象坐标rect转换到设备像素空间
     CG_EXTERN CGRect CGContextConvertRectToUserSpace(CGContextRef cg_nullable c, CGRect rect) // 一个设备像素空间rect转换到一个抽象坐标
     
     
     */
    
    /*
     
     // 基本api
     
     // 平移
     CG_EXTERN CGAffineTransform CGAffineTransformMakeTranslation(CGFloat tx,
     CGFloat ty)
     CG_EXTERN CGAffineTransform CGAffineTransformTranslate(CGAffineTransform t,
     CGFloat tx, CGFloat ty)
     
     // 旋转
     CG_EXTERN CGAffineTransform CGAffineTransformMakeRotation(CGFloat angle)
     CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);
     CG_EXTERN CGAffineTransform CGAffineTransformRotate(CGAffineTransform t,
     CGFloat angle)
     
     // 缩放
     CG_EXTERN CGAffineTransform CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
     CG_EXTERN CGAffineTransform CGAffineTransformScale(CGAffineTransform t,
     CGFloat sx, CGFloat sy)
     
     // 其他api
     // 反转，通常用于恢复变换的图形。但是一般不用，可以通过保存和恢复图形状态来逆转转换CTM的效果
     CG_EXTERN CGAffineTransform CGAffineTransformInvert(CGAffineTransform t)
     
     // 转换一个点
     CG_EXTERN CGPoint CGPointApplyAffineTransform(CGPoint point, CGAffineTransform t)
     // 转换一个大小 
     CG_EXTERN CGSize CGSizeApplyAffineTransform(CGSize size, CGAffineTransform t)
     // 转换一个区域. 这个函数返回一个最小的矩形，它包含矩形的转换角点
     CG_EXTERN CGRect CGRectApplyAffineTransform(CGRect rect, CGAffineTransform t)
     
     // 判断2个仿射是否一致
     CG_EXTERN bool CGAffineTransformEqualToTransform(CGAffineTransform t1,
     CGAffineTransform t2)
     
     // 判断仿射函数是否进行转换。
     CG_EXTERN bool CGAffineTransformIsIdentity(CGAffineTransform t)
     
     // 链接2个仿射函数。相乘
     CG_EXTERN CGAffineTransform CGAffineTransformConcat(CGAffineTransform t1,
     CGAffineTransform t2)
     
     // 创建一个仿射变换
     CG_EXTERN CGAffineTransform CGAffineTransformMake(CGFloat a, CGFloat b,
     CGFloat c, CGFloat d, CGFloat tx, CGFloat ty)
     
     
     */
    
    /*
     
     仿射变换矩阵构成
     
     a  b  0
     c  d  0
     tx ty 1
     
     变换公式：  x' = ax + cy + tx;
               y' = bx + dy + ty;
     
     */

    // 举例说明：
    // 创建2个视图，view 和 imageView，他们的视图大小位置保持一致，用来作对比
    self.view.backgroundColor = [UIColor blackColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    view.backgroundColor = [UIColor whiteColor];
    view.center = self.view.center;
    [self.view addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    imageView.image = [UIImage imageNamed:@"123.jpg"];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
 
    [self affineTransform_changeWith:imageView];
}

- (void)affineTransform_sameWith:(UIImageView *)imageView {

    // 1.保持不变，相当于 x' = x * 1 + y * 0 + 0，y' = 0 * x + 1 * y + 0，所有最终结果保持不变。
    CGAffineTransform affineTransform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    imageView.transform = affineTransform;
    
}


- (void)affineTransform_displacementWith:(UIImageView *)imageView {

    // 2.位移，只是在点的基础上加减值，所以只需要改变tx和ty的值。 例如： x' = x * 1 + y * 0 + 50，y' = 0 * x + 1 * y + 80，
    CGAffineTransform affineTransform = CGAffineTransformMake(1, 0, 0, 1, 50, 80);
    imageView.transform = affineTransform;
    
}

- (void)affineTransform_zoomWith:(UIImageView *)imageView {
    
    // 3.缩放，x'值只有x的系数单独决定，y'值只有y的系数单独决定。 例如： x' = x * 0.5 + y * 0，y' = 0 * x + 0.5 * y，所以导致了缩放
    CGAffineTransform affineTransform = CGAffineTransformMake(0.5, 0, 0, 0.5, 0, 0);
    imageView.transform = affineTransform;
    
}

- (void)affineTransform_rotateWith:(UIImageView *)imageView {

    /*
     
     4.旋转 要实现旋转，就需要x和y共同的变换来实现。但是旋转x的值是决定y的值，
     假如有一个圆，圆心为坐标原点，因为在ios的坐标系中，往下是增加的，所以x轴往右是正数，y轴往下是正数。
     圆上有一个点（2，0）,现在我们把圆顺时针旋转90度，那么坐标就变成了（0, 2），计算公示y' = 0 + 2 * cos90°。
     圆上有一个点（0，-2）,现在我们把圆顺时针旋转90度，那么坐标就变成了（2, 0），计算公示x' = 0 - 2 * sin90° + 0。
     
     同理如果有一个点（2， 3），现在我们把圆顺时针旋转90度，那么坐标就变成了（-3, 2）。计算公示x' = 2 * cos90° - 3 * sin90° + 0, y' = 2 * sin90 + 3 * cos90°。
     
     可以得出：x' = x * cosa - y * sina，y' = x * sina + y * cosa。
     
     所有仿射变换矩阵构成
     
     cosa  sina  0
     
     -sina cosa  0
     
     0     0     1
     
     */
    
    // 翻转90度，等价于CGAffineTransformMakeRotation(M_PI)
    CGFloat value = M_PI;

    CGFloat a = cos(value);
    CGFloat b = sin(value);
    CGFloat c = -b;
    CGFloat d = a;
    CGAffineTransform affineTransform = CGAffineTransformMake(a, b, c, d, 0, 0);
    imageView.transform = affineTransform;
    
}

- (void)affineTransform_changeWith:(UIImageView *)imageView {

    // 5.通过给CTM设定一定的值和一些方法配和使用，可以实现不的效果
    
    // 设置一个变化
    CGAffineTransform affineTransform = CGAffineTransformMake(0.5, 1, 1, 0.5, 0, 0);
    // 然后缩小一倍
//    affineTransform = CGAffineTransformScale(affineTransform, 0.5, 0.5);
    imageView.transform = affineTransform;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
