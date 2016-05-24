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
{
    
    CATransform3D myTransform ;
    
}

@property (nonatomic ,strong)ZQPlayerView *player;

@property (nonatomic ,assign)BOOL isLandscapeMode;

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
    
    self.player = [[ZQPlayerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16) videoURL:filePath];
    myTransform = _player.layer.transform;
    
    WEAKSELF(weakSelf)
    
    [self.player didClickedbackBtnHandle:^{//播放器返回按钮点击方法
    
        [weakSelf swtichAction];
    }];
    
    [self.player didClickedFullScreenBtnHandle:^{//有空再把播放器的矩阵变换。UI处理等方法交给播放器处理
        [weakSelf fullScreen];
        
    }];

    
    [self.view addSubview:self.player];
    
    [self.player play];
}

-(void)fullScreen{
    
    _player.frame = CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH);
    [UIView animateWithDuration:0.3 animations:^{
        CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
        //
        _player.layer.transform  =  transform;
        _player.center = self.view.center;
        
        
    } completion:^(BOOL finished) {
        _player.center = self.view.center;
        
    }];
    _isLandscapeMode = YES;
}

-(void)swtichAction{
    _player.backgroundColor = [UIColor blueColor];
    if (_isLandscapeMode) {
        [UIView animateWithDuration:0.3 animations:^{
             _player.center = CGPointMake(SCREEN_WIDTH/2, _player.frame.size.height/2);
            _player.layer.transform  =myTransform  ;
            _player.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16);

            
        } completion:^(BOOL finished) {
           
        }];
         _isLandscapeMode = NO;

    }else{
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
