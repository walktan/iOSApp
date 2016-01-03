//
//  ViewController.m
//  ChukyoBus
//
//  Created by 旦 on 2014/02/16.
//  Copyright (c) 2014年 walktan. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
#import "CustomCell.h"

//出発地フラグ（デフォルト：大学発）
static NSInteger dFlg =0;
static UITableViewCell *ad ;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /* 20150712
    //広告対応
    ad = [[UITableViewCell alloc] init];
    // NADView の作成
    _nadView = [[NADView alloc] initWithFrame:CGRectMake(0.f, 0.f, NAD_ADVIEW_SIZE_320x50.width, NAD_ADVIEW_SIZE_320x50.height)];
    // apiKey, spotID をセットする
    [_nadView setNendID:@"bd9e07fe8723f762f49f62bde4213278aa3e4d2b" spotID:@"170854"];
    // デリゲートオブジェクトの指定
    [_nadView setDelegate:self];
    // 広告のロードを開始
    [_nadView load];
     20170712 */
    
    
    //背景設定
    self.view.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    
    //移動方向画像の表示
    self.forward.image = [UIImage imageNamed:@"dforward.png"];
    
    //出発地選択セグメントの装飾
    NSArray *ar = [NSArray arrayWithObjects:@"大学発", @"浄水発", nil];
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:ar ];
    sc.frame = CGRectMake(15, 84, 290, 60);
    [sc setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:17] forKey:NSFontAttributeName] forState:UIControlStateNormal];
    sc.selectedSegmentIndex = 0;
    // セグメントの選択が変更されたときに呼ばれるメソッドを設定
    [sc addTarget:self
           action:@selector(segment_ValueChanged:)
    forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sc];
    
    //table調整
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.allowsSelection = NO;
    [UITableView appearance].separatorInset  = UIEdgeInsetsMake(0, 40, 0, 40);
    self.table.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    self.table.separatorColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
    [self.table registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    //時間取得
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *now = [NSDate date];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    self.timeLabel.text = [formatter stringFromDate:now];
    self.timeLabel.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
    
    //タブバー設定
    
}


/**
 * セグメントの選択が変更されたとき
 * @param sender セグメント
 */
- (void)segment_ValueChanged:(id)sender
{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    switch (segment.selectedSegmentIndex) {
        case 0: // 大学発が選択されたとき
            self.forward.image = [UIImage imageNamed:@"dforward.png"];
            dFlg = 0;
            [self.table reloadData];
            break;
            
        case 1: // 浄水発が選択されたとき
            self.forward.image = [UIImage imageNamed:@"jforward.png"];
            dFlg = 1;
            [self.table reloadData];
            break;
            
        default:
            break;
    }
}

//テーブルのセル数
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    //20140712改変8→7
    return 7;
}

//テーブルの中身
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"db接続前ですぞ");
    
    //db接続
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"ChukyoBus15"];
    
    BOOL result_flag = [fm fileExistsAtPath:writableDBPath];
    if(!result_flag){
        //dbが存在してなかったらここが呼ばれて、作成したDBをコピー
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ChukyoBus15"];
        
        BOOL copy_result_flag = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if(!copy_result_flag){
            //失敗したらここ
            NSLog(@"dbオープンできませんでしたー");
        }
    }
    //作成したテーブルからデータを取得
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    CustomCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell0.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    CustomCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell1.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    CustomCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell2.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    CustomCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell3.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    CustomCell *cell4 = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell4.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    CustomCell *cell5 = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell5.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    CustomCell *cell6 = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell6.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    ad.backgroundColor = [UIColor colorWithRed:240/256.0 green:240/256.0 blue:240/256.0 alpha:1.0];
    
    cell0.msg.text = @"";
    cell1.msg.text = @"";
    cell2.msg.text = @"";
    cell3.msg.text = @"";
    cell4.msg.text = @"";
    cell5.msg.text = @"";
    cell6.msg.text = @"";
    
    //大学発選択時（デフォルト）
    if(dFlg == 0){
        // 現在日付を取得
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps;
        
        // 年・月・日を取得
        comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit )
                            fromDate:now];
        NSInteger ntime = [comps hour] * 60 + [comps minute];
        NSInteger yet0 = 0;
        NSInteger yet1 = 0;
        NSInteger yet2 = 0;
        NSInteger yet3 = 0;
        NSInteger yet4 = 0;
        NSInteger yet5 = 0;
        NSInteger yet6 = 0;
        NSString *ji ;
        NSString *fun ;
        NSString *sql = @"select hour,minute from DWeekDia where hour > ? or (hour = ? and minute >= ?) order by hour,minute" ;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:now],@"平日ダイヤ"];
        self.timeLabel.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
        
        [db open];
        
        //ダイア取得
        //土曜日
        if(comps.weekday == 7 ){
            sql = @"select hour,minute from DSatDia where hour > ? or (hour = ? and minute >= ?) order by hour,minute";
            self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:now],@"土曜ダイヤ"];
        }
        
        //休日
        FMResultSet *isOff = [db executeQuery:@"select year,month,day from OffDay where year = ? and month = ? and day = ?",
                              [NSNumber numberWithInt:(int)[comps year]],[NSNumber numberWithInt:(int)[comps month]],[NSNumber numberWithInt:(int)[comps day]]];
        if([comps weekday] == 1 || [isOff next]){
            sql = @"";
            cell0.msg.text = @"本日は運休です";
            cell0.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell0.msg.font = [UIFont fontWithName:@"Courier" size:22];
            self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:now],@"運休日"];
        }
        
        //補講
        FMResultSet *isHokou = [db executeQuery:@"select year,month,day from HokouDay where year = ? and month = ? and day = ?",
                                [NSNumber numberWithInt:(int)[comps year]],[NSNumber numberWithInt:(int)[comps month]],[NSNumber numberWithInt:(int)[comps day]]];
        if([isHokou next]){
            sql = @"select hour,minute from DHokouDia where hour > ? or (hour = ? and minute >= ?) order by hour,minute";
            self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:now],@"補講ダイヤ"];
        }
        
        //臨時
        FMResultSet *isEx = [db executeQuery:@"select year,month,day from ExDay where year = ? and month = ? and day = ?",
                             [NSNumber numberWithInt:(int)[comps year]],[NSNumber numberWithInt:(int)[comps month]],[NSNumber numberWithInt:(int)[comps day]]];
        if([isEx next]){
            sql = @"";
            cell0.msg.text = @"本日は臨時ダイヤです";
            cell0.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell0.msg.font = [UIFont fontWithName:@"Courier" size:20];
            cell1.msg.text = @"ALBO等でご確認ください";
            cell1.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell1.msg.font = [UIFont fontWithName:@"Courier" size:20];
            self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:now],@"臨時ダイヤ"];
        }
        
        
        FMResultSet *results = [db executeQuery:sql,
                                [NSNumber numberWithInt:(int)[comps hour]],[NSNumber numberWithInt:(int)[comps hour]],[NSNumber numberWithInt:(int)[comps minute]]];
        
        if( [results next] ){
            
            //繰り返し運行
            if([results intForColumn:@"hour"] == 9 && [results intForColumn:@"minute"] == 21){
                cell0.msg.text = @"浄水発繰り返し運行";
                cell0.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell0.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell0.msg.text = @"本日の運行は以上です";
                cell0.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell0.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            
            
            cell0.left.text = @"先発";
            cell0.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell0.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell0.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell0.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet0 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell0.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet0];
            cell0.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
            
        }
        if( [results next] ){
            //繰り返し運行
            if([results intForColumn:@"hour"] == 9 && [results intForColumn:@"minute"] == 21){
                cell1.msg.text = @"・・浄水発繰り返し運行・・";
                cell1.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell1.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell1.msg.text = @"本日の運行は以上です";
                cell1.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell1.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            
            cell1.left.text = @"次発";
            cell1.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell1.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell1.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell1.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet1 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell1.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet1];
            cell1.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
        }
        if( [results next] ){
            if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell2.msg.text = @"本日の運行は以上です";
                cell2.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell2.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            cell2.left.text = @"3rd";
            cell2.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell2.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell2.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell2.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet2 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell2.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet2];
            cell2.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
        }
        if( [results next] ){
            if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell3.msg.text = @"本日の運行は以上です";
                cell3.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell3.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            cell3.left.text = @"4th";
            cell3.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell3.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell3.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell3.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet3 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell3.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet3];
            cell3.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
        }
        if( [results next] ){
            if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell4.msg.text = @"本日の運行は以上です";
                cell4.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell4.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            cell4.left.text = @"5th";
            cell4.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell4.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell4.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell4.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet4 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell4.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet4];
            cell4.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
        }
        if( [results next] ){
            if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell5.msg.text = @"本日の運行は以上です";
                cell5.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell5.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            cell5.left.text = @"6th";
            cell5.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell5.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell5.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell5.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet5 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell5.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet5];
            cell5.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
        }
        if( [results next] ){
            if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell6.msg.text = @"本日の運行は以上です";
                cell6.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell6.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            cell6.left.text = @"7th";
            cell6.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell6.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell6.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell6.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet6 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell6.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet6];
            cell6.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
        }
        [db close];
        
        
        
        if(indexPath.row == 0){
            return cell0;
        }
        if(indexPath.row == 1){
            return cell1;
        }
        if(indexPath.row == 2){
            return cell2;
        }
        if(indexPath.row == 3){
            return cell3;
        }
        if(indexPath.row == 4){
            return cell4;
        }
        /* 20150712
        if(indexPath.row == 5){
            return ad;
        }
    20150712 */
        if(indexPath.row == 5){
            return cell5;
        }
        if(indexPath.row == 6){
            return cell6;
        }
    }
    
    //浄水発選択時
    else{
        // 現在日付を取得
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps;
        
        // 年・月・日を取得
        comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit )
                            fromDate:now];
        NSInteger ntime = [comps hour] * 60 + [comps minute];
        NSInteger yet0 = 0;
        NSInteger yet1 = 0;
        NSInteger yet2 = 0;
        NSInteger yet3 = 0;
        NSInteger yet4 = 0;
        NSInteger yet5 = 0;
        NSInteger yet6 = 0;
        NSString *ji ;
        NSString *fun ;
        NSString *sql = @"select hour,minute from JWeekDia where hour > ? or (hour = ? and minute >= ?) order by hour,minute" ;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:now],@"平日ダイヤ"];
        self.timeLabel.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
        
        [db open];
        
        //ダイア取得
        //土曜日
        if(comps.weekday == 7 ){
            sql = @"select hour,minute from JSatDia where hour > ? or (hour = ? and minute >= ?) order by hour,minute";
            self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:now],@"土曜ダイヤ"];
        }
        
        //休日
        FMResultSet *isOff = [db executeQuery:@"select year,month,day from OffDay where year = ? and month = ? and day = ?",
                              [NSNumber numberWithInt:(int)[comps year]],[NSNumber numberWithInt:(int)[comps month]],[NSNumber numberWithInt:(int)[comps day]]];
        if([comps weekday] == 1 || [isOff next]){
            sql = @"";
            cell0.msg.text = @"本日は運休です";
            cell0.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell0.msg.font = [UIFont fontWithName:@"Courier" size:22];
            self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:now],@"運休日"];
        }
        
        //補講
        FMResultSet *isHokou = [db executeQuery:@"select year,month,day from HokouDay where year = ? and month = ? and day = ?",
                                [NSNumber numberWithInt:(int)[comps year]],[NSNumber numberWithInt:(int)[comps month]],[NSNumber numberWithInt:(int)[comps day]]];
        if([isHokou next]){
            sql = @"select hour,minute from JHokouDia where hour > ? or (hour = ? and minute >= ?) order by hour,minute";
            self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:now],@"補講ダイヤ"];
        }
        
        //臨時
        FMResultSet *isEx = [db executeQuery:@"select year,month,day from ExDay where year = ? and month = ? and day = ?",
                             [NSNumber numberWithInt:(int)[comps year]],[NSNumber numberWithInt:(int)[comps month]],[NSNumber numberWithInt:(int)[comps day]]];
        if([isEx next]){
            sql = @"";
            cell0.msg.text = @"本日は臨時ダイヤです";
            cell0.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell0.msg.font = [UIFont fontWithName:@"Courier" size:20];
            cell1.msg.text = @"ALBO等でご確認ください";
            cell1.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell1.msg.font = [UIFont fontWithName:@"Courier" size:20];
            self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:now],@"臨時ダイヤ"];
        }
        FMResultSet *results = [db executeQuery:sql,
                                [NSNumber numberWithInt:(int)[comps hour]],[NSNumber numberWithInt:(int)[comps hour]],[NSNumber numberWithInt:(int)[comps minute]]];
        
        if( [results next] ){
            if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell0.msg.text = @"本日の運行は以上です";
                cell0.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell0.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            cell0.left.text = @"先発";
            cell0.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell0.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell0.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell0.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet0 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell0.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet0];
            cell0.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
            
        }
        if( [results next] ){
            if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell1.msg.text = @"本日の運行は以上です";
                cell1.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell1.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            cell1.left.text = @"次発";
            cell1.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell1.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell1.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell1.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet1 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell1.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet1];
            cell1.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
        }
        if( [results next] ){
            if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell2.msg.text = @"本日の運行は以上です";
                cell2.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell2.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            cell2.left.text = @"3rd";
            cell2.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell2.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell2.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell2.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet2 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell2.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet2];
            cell2.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
        }
        if( [results next] ){
            if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell3.msg.text = @"本日の運行は以上です";
                cell3.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell3.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            cell3.left.text = @"4th";
            cell3.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell3.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell3.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell3.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet3 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell3.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet3];
            cell3.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
        }
        if( [results next] ){
            if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell4.msg.text = @"本日の運行は以上です";
                cell4.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell4.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            cell4.left.text = @"5th";
            cell4.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell4.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell4.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell4.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet4 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell4.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet4];
            cell4.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
        }
        if( [results next] ){
            if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell5.msg.text = @"本日の運行は以上です";
                cell5.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell5.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            cell5.left.text = @"6th";
            cell5.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell5.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell5.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell5.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet5 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell5.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet5];
            cell5.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
        }
        if( [results next] ){
            if([results intForColumn:@"hour"] == 23 && [results intForColumn:@"minute"] == 59){
                cell6.msg.text = @"本日の運行は以上です";
                cell6.msg.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
                cell6.msg.font = [UIFont fontWithName:@"Courier" size:20];
            }else{
            cell6.left.text = @"7th";
            cell6.left.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            ji = [NSString stringWithFormat: @"%02d",[results intForColumn:@"hour"]];
            fun = [NSString stringWithFormat:@"%02d",[results intForColumn:@"minute"]];
            cell6.naka.text = [NSString stringWithFormat:@"%@時%@分",ji,fun];
            cell6.naka.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            cell6.naka.font = [UIFont fontWithName:@"Courier" size:22];
            yet6 = ([results intForColumn:@"hour"] *60)  + [results intForColumn:@"minute"] - ntime ;
            cell6.right.text =  [NSString stringWithFormat:@"%ld min later",(long)yet6];
            cell6.right.textColor = [UIColor colorWithRed:60/256.0 green:60/256.0 blue:60/256.0 alpha:1.0];
            }
        }
        [db close];
        
        
        
        if(indexPath.row == 0){
            return cell0;
        }
        if(indexPath.row == 1){
            return cell1;
        }
        if(indexPath.row == 2){
            return cell2;
        }
        if(indexPath.row == 3){
            return cell3;
        }
        if(indexPath.row == 4){
            return cell4;
        }
/* 20170712
        if(indexPath.row == 5){
            return ad;
        }
 20150712 */
        if(indexPath.row == 5){
            return cell5;
        }
        if(indexPath.row == 6){
            return cell6;
        }
    }
    
    
    
    return cell;
}

//セルの高さ

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//以下、広告対応
/* 20150712
- (void)dealloc
{
    // delegate プロパティに nil をセットする
    [_nadView setDelegate:nil];
    _nadView = nil;
}

// 広告のロードが完了した時に実行される
- (void)nadViewDidFinishLoad:(NADView *)adView
{
    // NADView を貼り付ける
    _nadView.frame = CGRectMake(0, 10, 320, 50);
    [ad addSubview:_nadView];
}
20150712 */



@end


