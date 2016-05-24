//
//  BannerModel.h
//  Demo
//
//  Created by Mopon on 16/5/11.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Room;
@interface BannerModel : NSObject


@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, copy) NSString *gameId;

@property (nonatomic, copy) NSString *positionType;

@property (nonatomic, copy) NSString *bpic;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *chnId;

@property (nonatomic, copy) NSString *roomId;

@property (nonatomic, copy) NSString *spic;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, strong) Room *room;

@property (nonatomic, copy) NSString *contents;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *matchId;


@end


@interface Room : NSObject

@property (nonatomic, copy) NSString *roomNotice;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *gameName;

@property (nonatomic, copy) NSString *hotsLevel;

@property (nonatomic, copy) NSString *gameUrl;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger fans;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *bpic;

@property (nonatomic, copy) NSString *gameId;

@property (nonatomic, copy) NSString *allowVideo;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *gameIcon;

@property (nonatomic, copy) NSString *addTime;

@property (nonatomic, copy) NSString *gameBpic;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *template;

@property (nonatomic, copy) NSString *videoId;

@property (nonatomic, copy) NSString *chatStatus;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, copy) NSString *editTime;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *online;

@property (nonatomic, copy) NSString *liveTime;

@property (nonatomic, copy) NSString *allowRecord;

@property (nonatomic, copy) NSString *videoIdKey;

@property (nonatomic, copy) NSString *roomCoverType;

@property (nonatomic, assign) BOOL bonus;

@property (nonatomic, copy) NSString *publishUrl;

@property (nonatomic, copy) NSString *anchorNotice;

@property (nonatomic, assign) NSInteger follows;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *roomCover;

@property (nonatomic, copy) NSString *translateLanguages;

@property (nonatomic, copy) NSString *fansTitle;

@property (nonatomic, copy) NSString *verscr;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *spic;

@end

