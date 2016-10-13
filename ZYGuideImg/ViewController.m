//
//  ViewController.m
//  ZYGuideImg
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = self.view.bounds;
    label.text = @"终于，敲了一遍，学习了！！！.";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];

    
}




@end
