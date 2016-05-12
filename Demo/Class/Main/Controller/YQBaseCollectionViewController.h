//
//  YQBaseCollectionViewController.h
//  ZQPhone
//
//  Created by Mopon on 16/5/12.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQBaseCollectionViewCell.h"

@interface YQBaseCollectionViewController : YQBaseViewController

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)UICollectionView *collectionView;

-(void)requestData;

-(YQBaseCollectionViewCell *)creatCellForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end
