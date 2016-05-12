//
//  GameController.m
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "GameController.h"
#import "ZQGameModel.h"
#import "ZQGameCell.h"
#import "GameDetailController.h"

@interface GameController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)UICollectionView *collectionView;

@end

@implementation GameController

-(NSMutableArray *)dataSource{

    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViews];
    
    [self requestData];
    
}

#pragma mark - 初始化各个view
-(void)setUpViews{

    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumInteritemSpacing = 0.0;//item 之间的行的距离
    flowLayout.minimumLineSpacing = 10.0;//item 之间竖的距离
    CGFloat cellWidth = (SCREEN_WIDTH - 40)/3;
    
    flowLayout.itemSize = (CGSize){cellWidth,cellWidth+50};
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64 -44) collectionViewLayout:flowLayout];
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource= self;
    
    [self.collectionView registerClass:[ZQGameCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - 请求数据
-(void)requestData{

    [_ZQHttpTool getGameHomeDataWithSuccesed:^(ZQHttpTool *manager, id responseObject) {
        
        NSMutableArray *arr = responseObject[@"data"][@"games"];
        
        [arr enumerateObjectsUsingBlock:^(NSDictionary *  obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ZQGameModel *model = [ZQGameModel mj_objectWithKeyValues:obj];
            
            [self.dataSource addObject:model];
        }];
        
        [self.collectionView reloadData];
        
    } faild:^(ZQHttpTool *manager, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZQGameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    [cell fillCellWithZQGameModel:self.dataSource[indexPath.row]];
    cell.contentView.backgroundColor = RandomColor;
    
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    GameDetailController *detail = [[GameDetailController alloc]init];
    detail.model = self.dataSource[indexPath.row];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    
}

@end


