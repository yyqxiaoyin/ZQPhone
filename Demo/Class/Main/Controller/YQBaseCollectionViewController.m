//
//  YQBaseCollectionViewController.m
//  ZQPhone
//
//  Created by Mopon on 16/5/12.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQBaseCollectionViewController.h"
#import "ZQGameDetailModel.h"
#import "ZQLiveRoomController.h"

@interface YQBaseCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

static NSString * const reuseIdentifier = @"Cell";

@implementation YQBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
    
    [self requestData];
}
-(NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

-(void)setUpViews{
    
    
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumInteritemSpacing = 0.0;//item 之间的行的距离
    flowLayout.minimumLineSpacing = 10.0;//item 之间竖的距离
    CGFloat cellWidth = (SCREEN_WIDTH - 30)/2;
    
    flowLayout.itemSize = (CGSize){cellWidth,cellWidth/1.5 +30 +13};
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource= self;
    
    [self.collectionView registerClass:[YQBaseCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:self.collectionView];
    
}
-(void)requestData{
    

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

   YQBaseCollectionViewCell *cell =  [self creatCellForCollectionView:collectionView indexPath:indexPath];

    return cell;
}

#pragma mark - 暴露给之类调用的方法。让它自己调用需要的方法去填充cell
-(YQBaseCollectionViewCell *)creatCellForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{

    
    YQBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    return cell;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
