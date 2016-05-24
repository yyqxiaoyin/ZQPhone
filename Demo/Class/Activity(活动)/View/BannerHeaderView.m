//
//  BannerHeaderView.m
//  ZQPhone
//
//  Created by Mopon on 16/5/16.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "BannerHeaderView.h"
#import "TTLoopView.h"

@interface BannerHeaderView ()

@property (nonatomic ,strong)NSMutableArray *models;

@end

@implementation BannerHeaderView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
    
        self.models = [NSMutableArray array];
    }
    return self;
}

-(void)fillBannerHeaderViewWithBannerModels:(NSArray *)models selectedBlock:(void (^)(NSInteger itemIndex))SelectedBlock{

    self.models = [[NSMutableArray alloc]initWithArray:models];
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *images = [NSMutableArray array];
    [models enumerateObjectsUsingBlock:^(BannerModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [titles addObject:obj.title];
        [images addObject:obj.spic];

    }];
    
    TTLoopView *lpView = [TTLoopView LoopViewWithURLs:images titles:titles didSelected:SelectedBlock];
    lpView.titleBackGroundColor = [UIColor blackColor];
    lpView.titleAlpha = 0.7;
    lpView.titleColor = [UIColor whiteColor];
    lpView.pageControlNorColor = [UIColor whiteColor];
    lpView.pageControlSelColor = THEMECOLOR;
    [self addSubview:lpView];
    [lpView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.and.top.and.bottom.mas_equalTo(self);
        
    }];
}

@end
