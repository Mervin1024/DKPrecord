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

@interface MainViewController ()

@end

@implementation MainViewController{
    MERHTTPServerManager *_server;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _server = [[MERHTTPServerManager alloc] init];
    [_server getTestTextSuccess:^(BFEHTTPServer *bfeHttpServer) {
        NSDictionary *dic = [MERHTTPServerManager parseObjectFromRequest:bfeHttpServer];
        NSLog(@"%@",dic);
    } faild:^(BFEHTTPServer *bfeHttpServer) {
        NSString *str = bfeHttpServer.error.localizedDescription;
        [AutoRemoveMessageView show:str];
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
