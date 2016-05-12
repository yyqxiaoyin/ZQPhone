//
//  ZQLiveRoomController.m
//  Demo
//
//  Created by Mopon on 16/5/11.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "ZQLiveRoomController.h"
#import "WMPlayer.h"
#import "ZQPlayerView.h"

@interface ZQLiveRoomController ()

@property (nonatomic ,strong) WMPlayer *wmPlayer;

@property (nonatomic ,strong)AVPlayer *myAVPlayer;

@end

@implementation ZQLiveRoomController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpPlayer];
    
}

#pragma mark - 初始化播放器
-(void)setUpPlayer{

    self.view.backgroundColor = [UIColor whiteColor];
    NSString * filePath = [[NSMutableString alloc]initWithString:  [NSString stringWithFormat:@"%@%@.m3u8",LIVE_URL,_vid] ];
    
    ZQPlayerView *player = [[ZQPlayerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16) videoURL:filePath];
    
    WEAKSELF(weakSelf)
    
    [player didClickedbackBtnHandle:^{//播放器返回按钮点击方法
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.view addSubview:player];
    
    [player play];
}

@end
