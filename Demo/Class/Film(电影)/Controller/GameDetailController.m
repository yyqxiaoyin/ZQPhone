//
//  GameDetailController.m
//  Demo
//
//  Created by Mopon on 16/5/10.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "GameDetailController.h"
#import "ZQGameDetailModel.h"
#import "ZQGameDetailCell.h"
#import "ZQLiveRoomController.h"

@interface GameDetailController ()

@end

@implementation GameDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 重写父类请求方法
-(void)requestData{
    
    [_ZQHttpTool getGameDetailDataWithGameID:self.model.id Succesed:^(ZQHttpTool *manager, id responseObject) {
        
        NSMutableArray *data = responseObject[@"data"][@"rooms"];
        
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ZQGameDetailModel *model = [ZQGameDetailModel mj_objectWithKeyValues:obj];
            
            [self.dataSource addObject:model];
        }];
        [self.collectionView reloadData];
        
    } faild:^(ZQHttpTool *manager, NSError *error) {
        
        NSLog(@"%@",error);
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
    
    ZQGameDetailModel *model = self.dataSource[indexPath.row];
    ZQLiveRoomController *live = [[ZQLiveRoomController alloc]init];
    live.vid = model.videoId;
    [self.navigationController pushViewController:live animated:YES];
}


@end
