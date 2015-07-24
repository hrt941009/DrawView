//
//  ViewController.m
//  DrawView
//
//  Created by henyep on 15/7/9.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "ViewController.h"
#import "MyVire.h"
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    MyVire *view=[[MyVire alloc]initWithFrame:CGRectMake(0, 80, KScreenWidth, KScreenHeight*0.8)];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
