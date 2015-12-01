//
//  HMViewController.m
//  09-TOM猫
//
//  Created by apple on 14-8-12.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tom;

@end

@implementation HMViewController

/**
 重构-抽取代码
 
 方法：
 1> 将重复代码复制到新的方法中
 2> 根据需要调整参数
 
 关于图像的实例化
 
 imageNamed：系统推荐使用的，但是图像实例化之后的释放由系统负责
 如果要自己释放图片，不能使用imageNamed方法！

 而需要使用imageWithContentsOfFile
 
 提示：如果放在Images.xcassets中的图片，不能使用imageWithContentsOfFile
 Images.xcassets中不要 存放大的，不常用的图片
 */
- (void)tomAnimationWithName:(NSString *)name count:(NSInteger)count
{
    // 如果正在动画，直接退出
    if ([self.tom isAnimating]) return;
    
    // 动画图片的数组
    NSMutableArray *arrayM = [NSMutableArray array];
    
    // 添加动画播放的图片
    for (int i = 0; i < count; i++) {
        // 图像名称
        NSString *imageName = [NSString stringWithFormat:@"%@_%02d.jpg", name, i];
//        UIImage *image = [UIImage imageNamed:imageName];
        // ContentsOfFile需要全路径
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        [arrayM addObject:image];
    }
    
    // 设置动画数组
    self.tom.animationImages = arrayM;
    // 重复1次
    self.tom.animationRepeatCount = 1;
    // 动画时长
    self.tom.animationDuration = self.tom.animationImages.count * 0.075;
    
    // 开始动画
    [self.tom startAnimating];
    
    // 动画"结束"之后，清理动画数组
//    self.tom.animationImages = nil;
    // performSelector定义在NSObject分类中
//    [self performSelector:@selector(cleanup) withObject:nil afterDelay:self.tom.animationDuration];
    [self.tom performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.tom.animationDuration];
}

- (IBAction)tomAction:(UIButton *)sender
{
    // currentTitle 可以取出按钮当前的标题文字
    [self tomAnimationWithName:sender.currentTitle count:sender.tag];
}

//- (void)cleanup
//{
//    NSLog(@"%s", __func__);
////    self.tom.animationImages = nil;
//    [self.tom setAnimationImages:nil];
//}

- (IBAction)knockout
{
    [self tomAnimationWithName:@"knockout" count:81];
}

- (IBAction)eatBird
{
    [self tomAnimationWithName:@"eat" count:40];
}

@end
