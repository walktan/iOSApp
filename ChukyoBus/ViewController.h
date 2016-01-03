//
//  ViewController.h
//  ChukyoBus
//
//  Created by 旦 on 2014/02/16.
//  Copyright (c) 2014年 walktan. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NADView.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{//,NADViewDelegate>{
    //NADView *_nadView;
}

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIImageView *forward;

@property (weak, nonatomic) IBOutlet UITableView *table;


@end