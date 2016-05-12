//
//  YQBaseCollectionViewCell.h
//  ZQPhone
//
//  Created by Mopon on 16/5/12.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQGameDetailModel.h"

@interface YQBaseCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong)UIImageView *imageView;

@property (nonatomic ,strong)UILabel *titleLabel;

@property (nonatomic ,strong)UIImageView *sexImageView;

@property (nonatomic ,strong)UILabel *authorLabel;

@property (nonatomic ,strong)UIImageView *peopleImageView;

@property (nonatomic ,strong)UILabel *peoplesLabel;

-(void)fillCellWithZQGameDetailModel:(ZQGameDetailModel *)model;

@end
