//
//  SectionHeaderView.h
//  ZQPhone
//
//  Created by Mopon on 16/5/16.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionHeaderViewDelegate <NSObject>

-(void)didClickMoreBtn:(UIButton *)moreBtn;

@end

@interface SectionHeaderView : UICollectionReusableView

-(void)fillHeaderViewWithTitle:(NSString *)title;

@property (nonatomic ,weak)id <SectionHeaderViewDelegate>delegate;

@end
