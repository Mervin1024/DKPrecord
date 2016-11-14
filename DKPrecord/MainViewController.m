//
//  ViewController.m
//  DKPrecord
//
//  Created by mervin on 2016/11/11.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "MainViewController.h"
#import "MERHTTPServerManager.h"
#import "AutoRemoveMessageView.h"
#import "RecordDBSet.h"
#import "RecordItemModel.h"
#import "RecordDailyModel.h"
#import "NSDate+Category.h"
#import "RecordGlobal.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    MERHTTPServerManager *_server;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _server = [[MERHTTPServerManager alloc] init];
//    [_server getTestTextSuccess:^(BFEHTTPServer *bfeHttpServer) {
//        NSDictionary *dic = [MERHTTPServerManager parseObjectFromRequest:bfeHttpServer];
//        NSLog(@"%@",dic);
//    } faild:^(BFEHTTPServer *bfeHttpServer) {
//        NSString *str = bfeHttpServer.error.localizedDescription;
//        [AutoRemoveMessageView show:str];
//    }];
    NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    [self selectData];  //查询数据

    
}

- (void)selectData{
    FMDTSelectCommand *cmd = [[RecordDBSet shared].dailyModel createSelectCommand];
    [cmd orderByAscending:@"version"];
    NSArray *arr = [cmd fetchArray];
    RecordDailyModel *dailyModel = [arr lastObject];
    [RecordGlobal sharedInstance].tableVersion = [dailyModel.version unsignedIntegerValue];
    [self insertData];  //插入数据
}

- (void)insertData{
    
    NSMutableArray *userArray = [NSMutableArray new];
    NSArray *nameArr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二"];
    for (int i = 0; i < [nameArr count]; i++) {
        RecordItemModel *item = [RecordItemModel new];
        item.userName = [NSString stringWithFormat:@"%@",nameArr[i]];
        item.gameClass = [NSString stringWithFormat:@"%@", @(arc4random()%11)];
        item.initialScore = @(arc4random()%20+40);
        item.finalScore = @([item.initialScore integerValue]+20);
        item.ScoreChanges = @[@(-1),@(-3),@(24)];
//        item.date = [NSDate date].monthAndMinuteDescription;
        [userArray addObject:item];
    }
    RecordDailyModel *dailyModel = [RecordDailyModel new];
    dailyModel.schedule = [NSString stringWithFormat:@"%@",@(arc4random()%4+3)];
    dailyModel.date = [[NSDate date] monthAndSecondDescription];
    dailyModel.version = @([RecordGlobal sharedInstance].tableVersion+1);
    
    //创建插入对象
    FMDTInsertCommand *dcmd = [[RecordDBSet shared].dailyModel createInsertCommand];
    FMDTInsertCommand *icmd = [[RecordDBSet shared].itemModel createInsertCommand];
    //添加要插入的对象集合
    [dcmd add:dailyModel];
    [icmd addWithArray:userArray];
    //设置添加操作是否使用replace语句
    [dcmd setRelpace:YES];
    [icmd setRelpace:YES];
    //执行插入操作
    [dcmd saveChangesInBackground:^{
        NSLog(@"dailyModel提交完成");
    }];
    [icmd saveChangesInBackground:^{
        NSLog(@"itemModel提交完成");
        [RecordGlobal sharedInstance].tableVersion++;
    }];
}



@end
