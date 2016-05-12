//
//  HomePageController.m
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "HomePageController.h"
#import "YQBannerController.h"
#import "BannerModel.h"

@interface HomePageController ()

@property (nonatomic ,strong)NSMutableArray *banners;

@end

@implementation HomePageController

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBanner];
    
}

#pragma mark 初始化轮播广告
-(void)setBanner{
    NSMutableArray *titleArr = [NSMutableArray array];
    NSMutableArray *imageArr = [NSMutableArray array];
    [_ZQHttpTool getBannerDataWithSuccesed:^(ZQHttpTool *manager, id responseObject) {
        
        NSArray *data = responseObject[@"data"];
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           BannerModel*model = [BannerModel mj_objectWithKeyValues:obj];
            [self.banners addObject:model];
            
            [titleArr addObject:model.title];
            [imageArr addObject:model.spic];
        }];
        YQBannerController *banner = [[YQBannerController alloc]initWithNetWorkImages:imageArr titles:titleArr frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16)];
        [banner showInViewController:self];
        
    } faild:^(ZQHttpTool *manager, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

@end
