//
//  SectionHeaderView.m
//  ZQPhone
//
//  Created by Mopon on 16/5/16.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "SectionHeaderView.h"

@interface SectionHeaderView()

@property (nonatomic ,strong)UIView *lineView;

@property (nonatomic ,strong)UILabel *label;

@property (nonatomic ,strong)UIView *topLineView;

@end

@implementation SectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpviews];
    }
    return self;
}

-(void)setUpviews{

    self.topLineView = [[UIView alloc]init];
    self.topLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.topLineView];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = THEMECOLOR;
    [self addSubview:self.lineView];
    
    self.label = [[UILabel alloc]init];
    self.label.font = DEFAULT_FONT(15);
    self.label.textColor = [UIColor darkGrayColor];
    [self addSubview:self.label];
    
    [self layoutSubview];
}

-(void)layoutSubview{
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.top.and.right.mas_equalTo(self);
        make.height.mas_equalTo(@0.5);
    }];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(8, self.frame.size.height/2));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(10);
    }];

    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.lineView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.lineView.mas_centerY);
        make.height.mas_equalTo(@(self.frame.size.height/2));
        make.right.mas_equalTo(self.mas_right).offset(-10);
        
    }];
    
}

-(void)fillHeaderViewWithTitle:(NSString *)title{

    self.label.text = title;

}

@end
