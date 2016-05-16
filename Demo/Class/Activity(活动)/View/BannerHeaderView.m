//
//  BannerHeaderView.m
//  ZQPhone
//
//  Created by Mopon on 16/5/16.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "BannerHeaderView.h"
#import "TTLoopView.h"

@implementation BannerHeaderView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)fillBannerHeaderViewWithImages:(NSArray *)images titles:(NSArray *)titles selectedBlock:(void (^)(NSInteger itemIndex))SelectedBlock{
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
