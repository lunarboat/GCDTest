//
//  ViewController.m
//  GCDTest
//
//  Created by lunarboat on 15/10/9.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [imageView lb_setImageWithURL:[NSURL URLWithString:@"http://picm.photophoto.cn/012/077/018/0770180177.jpg"] placeholderImage:[UIImage imageNamed:@"1"]];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
