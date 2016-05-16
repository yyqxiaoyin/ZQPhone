//
//  HomePageController.m
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "HomePageController.h"
#import "BannerModel.h"
#import "ZQHomeListModel.h"
#import "SectionHeaderView.h"
#import "BannerHeaderView.h"


#define IDENTIFIER_HEADERSECTION @"homeMenuHeaderSection"
#define IDENTIFIER_BANNERSECTION @"bannerHeaderSection"

@interface HomePageController ()

@property (nonatomic ,strong)NSMutableArray *banners;

@property (nonatomic ,strong)NSMutableArray *headerViewTitles;

@property (nonatomic ,strong)NSMutableArray *bannerTitles;

@property (nonatomic ,strong)NSMutableArray *bannerImages;

@end

@implementation HomePageController

-(NSMutableArray *)headerViewTitles{

    if (!_headerViewTitles) {
        _headerViewTitles = [NSMutableArray array];
    }
    
    return _headerViewTitles;
}

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44-64);
    [self.collectionView registerClass:[SectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADERSECTION];
    [self.collectionView registerClass:[BannerHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_BANNERSECTION];

}
#pragma mark - 重写父类的请求方法
-(void)requestData{

    WEAKSELF(weakSelf)
    [_ZQHttpTool getHomeListDataWithSuccesed:^(ZQHttpTool *manager, id responseObject) {
        
        NSArray *data = responseObject[@"data"];
        [data enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.headerViewTitles addObject:[NSString stringWithFormat:@"%@",obj[@"title"]]];
            [weakSelf addListData:obj[@"lists"]];
        }];
        
        [self.collectionView reloadData];
        
    } faild:^(ZQHttpTool *manager, NSError *error) {
        
        QLog(@"%@",error);
    }];
}

#pragma mark -添加列表数据
-(void)addListData:(NSArray *)lists{

    NSMutableArray *modelList = [NSMutableArray array];
    
    [lists enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ZQHomeListModel *model = [ZQHomeListModel mj_objectWithKeyValues:obj];
        
        [modelList addObject:model];
    }];
    
    [self.dataSource addObject:modelList];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.headerViewTitles.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *arr = self.dataSource[section];
    
    return arr.count;
}

-(YQBaseCollectionViewCell *)creatCellForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    
    YQBaseCollectionViewCell*cell =  [super creatCellForCollectionView:collectionView indexPath:indexPath];
    
    if (cell) {
        
        ZQGameDetailModel *model = self.dataSource[indexPath.section][indexPath.row];
        
        [cell fillCellWithZQGameDetailModel:model];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return CGSizeMake(SCREEN_WIDTH , SCREEN_WIDTH*9/16);
    }
    return CGSizeMake(SCREEN_WIDTH , 40);
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        if (indexPath.section ==0) {
            
            BannerHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_BANNERSECTION forIndexPath:indexPath];
            
            reusableview = headerView;
            [self setBanner:headerView];
            
        }else{
            SectionHeaderView *headerView =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADERSECTION forIndexPath:indexPath];
            
            [headerView fillHeaderViewWithTitle:self.headerViewTitles[indexPath.section]];
            
            reusableview = headerView;
        }
    }
    return reusableview;
}

#pragma mark 初始化轮播广告
-(void)setBanner:(BannerHeaderView *)reusableView{
    self.bannerImages = [NSMutableArray array];
    self.bannerTitles = [NSMutableArray array];
    [_ZQHttpTool getBannerDataWithSuccesed:^(ZQHttpTool *manager, id responseObject) {
        
        NSArray *data = responseObject[@"data"];
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           BannerModel*model = [BannerModel mj_objectWithKeyValues:obj];
            [self.banners addObject:model];
            
            [self.bannerTitles addObject:model.title];
            [self.bannerImages addObject:model.spic];
        }];
        
        [reusableView fillBannerHeaderViewWithImages:self.bannerImages titles:self.bannerTitles selectedBlock:^(NSInteger index) {
            
            QLog(@"%ld",index);
        }];
        
    } faild:^(ZQHttpTool *manager, NSError *error) {
        
        QLog(@"%@",error);
    }];
}

@end
