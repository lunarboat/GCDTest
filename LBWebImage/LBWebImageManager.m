//
//  LBWebImageManager.m
//  GCDTest
//
//  Created by lunarboat on 15/10/9.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "LBWebImageManager.h"
#import "NSString+MD5.h"

@interface LBWebImageManager ()
//{
//    NSMutableDictionary *_cacheDictionary;
//}
@property (nonatomic, copy) NSMutableDictionary *cacheDictionary;

@end

@implementation LBWebImageManager

//- (NSMutableDictionary*)cacheDictionary{
//    _cacheDictionary = [[NSMutableDictionary alloc]init];
//    return _cacheDictionary;
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cacheDictionary = [[NSMutableDictionary alloc]init];
    }
    return self;
}


static LBWebImageManager *g_shareManager = nil;
//同步锁机制
//+ (LBWebImageManager*)shareManager{
//    @synchronized(self) {
//        if (g_shareManager == nil) {
//            g_shareManager = [[LBWebImageManager alloc]init];
//        }
//        return g_shareManager;
//    }
//}

//GCD线程安全
+ (LBWebImageManager*)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_shareManager = [[LBWebImageManager alloc]init];
    });
    return g_shareManager;
}

#pragma mark - 1.内存中查找图片
- (UIImage *)searchFromMemoryWithURl:(NSURL *)imageUrl{
    return [_cacheDictionary objectForKey:imageUrl];
}

#pragma mark - 2.沙盒中查找图片
- (UIImage *)searchFromSandBoxWithURL:(NSURL *)imageUrl{
    NSString *imgPath = [self pathForURL:imageUrl];
    NSData *imgData = [NSData dataWithContentsOfFile:imgPath];
    UIImage *image = [UIImage imageWithData:imgData];
    //找到图片做内存缓存
    if (image) {
        [_cacheDictionary setObject:image forKey:imageUrl];
    }
    
    return image;
}

#pragma mark - 3.网络下载图片
- (void)downloadImageWithURL:(NSURL *)imageUrl completionBlock:(void (^) (UIImage *image))block{
    if (!imageUrl) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imgData = [NSData dataWithContentsOfURL:imageUrl];
        UIImage *img = [UIImage imageWithData:imgData];
        [_cacheDictionary setObject:img forKey:imageUrl];
        [imgData writeToFile:[self pathForURL:imageUrl] atomically:YES];
        block(img);
    });
}

- (NSString *)keyForURL:(NSURL *)url{
    NSString *urlstr = [url absoluteString];
    return [urlstr MD5];
}

#pragma mark - 获取文件保存的位置
- (NSString *)pathForURL:(NSURL *)url{
    NSString *libDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSString *cacheDir = [libDir stringByAppendingPathComponent:@"myCaches"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:cacheDir]) {
        [manager createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *pathStr = [cacheDir stringByAppendingPathComponent:[self keyForURL:url]];
    return pathStr;
}

@end
