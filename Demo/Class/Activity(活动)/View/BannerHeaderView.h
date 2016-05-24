//
//  BannerHeaderView.h
//  ZQPhone
//
//  Created by Mopon on 16/5/16.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerModel.h"

@interface BannerHeaderView : UICollectionReusableView

-(void)fillBannerHeaderViewWithBannerModels:(NSArray *)models selectedBlock:(void (^)(NSInteger itemIndex))SelectedBlock;

@end
