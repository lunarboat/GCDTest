//
//  LBWebImageManager.h
//  GCDTest
//
//  Created by lunarboat on 15/10/9.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LBWebImageManager : NSObject


//创建一个单例
+ (LBWebImageManager*)shareManager;
//从内存中找图片
- (UIImage *)searchFromMemoryWithURl:(NSURL *)imageUrl;
//从本地的沙盒中找
- (UIImage *)searchFromSandBoxWithURL:(NSURL *)imageUrl;
//从网络下载
- (void)downloadImageWithURL:(NSURL *)imageUrl completionBlock:(void (^) (UIImage *image))block;
@end
