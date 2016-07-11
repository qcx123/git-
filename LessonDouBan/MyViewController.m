//
//  MyViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewController.h"
#import "MyHeaderTableViewCell.h"
#import "MyTableViewCell.h"

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(nonatomic,strong)NSArray *titles;


@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightNavigateionItem];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"MyHeaderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyHeaderTableViewCell_Identify];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyTableViewCell_1];
    
    self.titles = @[@"我的活动",@"我的电影",@"清除缓存"];
}


- (void)addRightNavigateionItem{

    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"登录" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:@selector(rightBarButtonItemClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
}

- (void)rightBarButtonItemClicked:(UIButton *)btn{

    // 跳转到登录界面
    
    // 获取当前storyboard
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    // 获取登录界面
    LoginViewController *loginVC = [mainSB instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginVC animated:YES completion:nil];
    
}


// 显示缓存
-(float)getFilePath{
    
    //文件管理
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //缓存路径
    
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    
    NSString *cacheDir = [cachePaths objectAtIndex:0];
    
    NSArray *cacheFileList;
    
    NSEnumerator *cacheEnumerator;
    
    NSString *cacheFilePath;
    
    unsigned long long cacheFolderSize = 0;
    
    cacheFileList = [fileManager subpathsOfDirectoryAtPath:cacheDir error:nil];
    
    cacheEnumerator = [cacheFileList objectEnumerator];
    
    while (cacheFilePath = [cacheEnumerator nextObject]) {
        
        NSDictionary *cacheFileAttributes = [fileManager attributesOfItemAtPath:[cacheDir stringByAppendingPathComponent:cacheFilePath] error:nil];
        
        cacheFolderSize += [cacheFileAttributes fileSize];
        
    }
    
    //单位MB
    
    return cacheFolderSize/1024/1024;
    
}

// 清除缓存 自己写
- (void)removeCache{

    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row == 3){
    
        [self removeCache];
        [self.myTableView reloadData];
        
    }
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        MyHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyHeaderTableViewCell_Identify];
    return cell;
    }else{
    
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTableViewCell_1];
        cell.contentLabel.text = self.titles[indexPath.row - 1];
        if (indexPath.row == 3) {
            cell.subLabel.text = [NSString stringWithFormat:@"%.1fM",[self getFilePath]];
        }
        return cell;

        
    }
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        return 184;
    }
    return 40;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
