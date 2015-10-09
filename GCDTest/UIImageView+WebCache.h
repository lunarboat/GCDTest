//
//  UIImageView+WebCache.h
//  GCDTest
//
//  Created by lunarboat on 15/10/9.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCache)

/**
 *  设置imageView的图片，用我们自己的缓存机制
 *
 *  @param imageUrl 图片的URL
 */
- (void)lb_setImageWithURL:(NSURL *)imageUrl;

/**
 *  设置imageView的图片，没有的话用默认placeholder图片
 *
 *  @param imageUrl    imageUrl 图片的URL
 *  @param placeholder 默认的图片
 */
- (void)lb_setImageWithURL:(NSURL *)imageUrl placeholderImage:(UIImage *)placeholder;
@end
