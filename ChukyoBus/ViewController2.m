//
//  ViewController2.m
//  ChukyoBus
//
//  Created by 旦 on 2014/07/07.
//  Copyright (c) 2014年 walktan. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scroll.frame = self.view.bounds;
    
    // スクロールしたときバウンドさせる
    self.scroll.bounces = YES;
    
    //背景設定
    self.view.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    
    CGRect rect = CGRectMake(0, 0, 320, 600);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    
    // 画像を設定
    imageView.image = [UIImage imageNamed:@"2015time.png"];
    
    // UIScrollViewのインスタンスに画像を貼付ける
	[self.scroll addSubview:imageView];
    // UIScrollViewのコンテンツサイズを画像のサイズに合わせる
    self.scroll.contentSize = imageView.bounds.size;
    // 表示されたときスクロールバーを点滅
    [self.scroll flashScrollIndicators];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
