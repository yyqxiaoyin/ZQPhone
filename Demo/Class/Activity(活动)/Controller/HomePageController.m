//
//  HomePageController.m
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "HomePageController.h"
#import "YQBannerController.h"
#import "BannerModel.h"
#import "ZQHomeListModel.h"

@interface HomePageController ()

@property (nonatomic ,strong)NSMutableArray *banners;

@property (nonatomic ,strong)NSMutableArray *headerViewTitles;

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
    
    
    
}
#pragma mark - 重写父类的请求方法
-(void)requestData{

    WEAKSELF(weakSelf)
    [_ZQHttpTool getHomeListDataWithSuccesed:^(ZQHttpTool *manager, id responseObject) {
        
        NSArray *data = responseObject[@"data"];
        [data enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [_headerViewTitles addObject:obj[@"title"]];
            
            [weakSelf addListData:obj[@"lists"]];
        }];
        
        [self.collectionView reloadData];
        
    } faild:^(ZQHttpTool *manager, NSError *error) {
        
        QLog(@"%@",error);
    }];
}

#pragma mark -添加列表数据
-(void)addListData:(NSArray *)lists{

    [lists enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ZQHomeListModel *model = [ZQHomeListModel mj_objectWithKeyValues:obj];
        
        [self.dataSource addObject:model];
        
    }];
    
}

-(YQBaseCollectionViewCell *)creatCellForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    
    YQBaseCollectionViewCell*cell =  [super creatCellForCollectionView:collectionView indexPath:indexPath];
    
    if (cell) {
        
        [cell fillCellWithZQGameDetailModel:self.dataSource[indexPath.row]];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark 初始化轮播广告
-(void)setBanner{
    NSMutableArray *titleArr = [NSMutableArray array];
    NSMutableArray *imageArr = [NSMutableArray array];
    [_ZQHttpTool getBannerDataWithSuccesed:^(ZQHttpTool *manager, id responseObject) {
        
        NSArray *data = responseObject[@"data"];
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           BannerModel*model = [BannerModel mj_objectWithKeyValues:obj];
            [self.banners addObject:model];
            
            [titleArr addObject:model.title];
            [imageArr addObject:model.spic];
        }];
        YQBannerController *banner = [[YQBannerController alloc]initWithNetWorkImages:imageArr titles:titleArr frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16)];
        [banner showInViewController:self];
        
    } faild:^(ZQHttpTool *manager, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

@end
