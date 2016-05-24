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
#import "ZQLiveRoomController.h"


#define IDENTIFIER_HEADERSECTION @"homeMenuHeaderSection"
#define IDENTIFIER_BANNERSECTION @"bannerHeaderSection"

@interface HomePageController ()<SectionHeaderViewDelegate>

@property (nonatomic ,strong)NSMutableArray *headerViewTitles;

@property (nonatomic ,strong)NSMutableArray *bannerModels;

@end

@implementation HomePageController

-(NSMutableArray *)headerViewTitles{

    if (!_headerViewTitles) {
        _headerViewTitles = [NSMutableArray array];
    }
    
    return _headerViewTitles;
}
-(NSMutableArray *)bannerModels{
    
    if (!_bannerModels) {
        _bannerModels = [NSMutableArray array];
    }
    
    return _bannerModels;
}

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
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
            NSLog(@"%@",obj[@"gameIds"]);
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
    
    ZQGameDetailModel *model = self.dataSource[indexPath.section][indexPath.row];
    ZQLiveRoomController *live = [[ZQLiveRoomController alloc]init];
    live.hidesBottomBarWhenPushed = YES;
    live.vid = model.videoId;
    [self.navigationController pushViewController:live animated:YES];
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
            headerView.delegate = self;
            [headerView fillHeaderViewWithTitle:self.headerViewTitles[indexPath.section]];
            
            reusableview = headerView;
        }
    }
    return reusableview;
}

#pragma mark 端头右边小箭头点击事件
-(void)didClickMoreBtn:(UIButton *)moreBtn{

    QLog(@"123");
}

#pragma mark 广告轮播器点击
-(void)didSelectAdWithIndex:(NSInteger)index{
    BannerModel *model = self.bannerModels[index];
    ZQLiveRoomController *live = [[ZQLiveRoomController alloc]init];
    live.vid = model.room.videoId;
    [self.navigationController pushViewController:live animated:YES];
    
}

#pragma mark 初始化轮播广告
-(void)setBanner:(BannerHeaderView *)reusableView{
    
    WEAKSELF(weakSelf)
    [_ZQHttpTool getBannerDataWithSuccesed:^(ZQHttpTool *manager, id responseObject) {
        NSArray *data = responseObject[@"data"];
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           BannerModel*model = [BannerModel mj_objectWithKeyValues:obj];
            
            [self.bannerModels addObject:model];
        }];
        
        [reusableView fillBannerHeaderViewWithBannerModels:self.bannerModels selectedBlock:^(NSInteger itemIndex) {
           
            [weakSelf didSelectAdWithIndex:itemIndex];
            
        }];
        
    } faild:^(ZQHttpTool *manager, NSError *error) {
        
        QLog(@"%@",error);
    }];
}



@end
