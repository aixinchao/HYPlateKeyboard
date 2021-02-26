//
//  ViewController.m
//  HYPlateKeyboard
//
//  Created by axc on 2021/2/25.
//  Copyright © 2021 axc. All rights reserved.
//

#import "ViewController.h"
#import "HYInputPlateView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"输入车牌";
    self.view.backgroundColor = [UIColor colorWithRed:245.0 / 255.0 green:245.0 / 255.0 blue:245.0 / 255.0 alpha:1];
    
    [self createInputPlateView];
}

- (void)createInputPlateView {
    HYInputPlateView *inputPlateView = [[HYInputPlateView alloc] initWithFrame:CGRectMake(12, 88, self.view.frame.size.width - 24, 120)];
    inputPlateView.layer.cornerRadius = 8;
    [self.view addSubview:inputPlateView];
}

@end
