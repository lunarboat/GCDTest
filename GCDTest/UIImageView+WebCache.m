//
//  UIImageView+WebCache.m
//  GCDTest
//
//  Created by lunarboat on 15/10/9.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "LBWebImageManager.h"

@implementation UIImageView (WebCache)

- (void)lb_setImageWithURL:(NSURL *)imageUrl{
    [self lb_setImageWithURL:imageUrl placeholderImage:nil];
}

- (void)lb_setImageWithURL:(NSURL *)imageUrl placeholderImage:(UIImage *)placeholder{
    //首先设置默认图片
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = placeholder;
    });
    
    //如果有imageURL 进行缓存查找机制
    //从内存中查找
    LBWebImageManager *manage = [LBWebImageManager shareManager];
    UIImage *image = [manage searchFromMemoryWithURl:imageUrl];
    if (image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
        return;
    }
    //从沙盒中查找
    image = [manage searchFromSandBoxWithURL:imageUrl];
    if (image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
        return;
    }
    //找不到图片 重新下载
    [manage downloadImageWithURL:imageUrl completionBlock:^(UIImage *image) {
       dispatch_async(dispatch_get_main_queue(), ^{
           [self setImage:image];
       });
    }];
}

@end
