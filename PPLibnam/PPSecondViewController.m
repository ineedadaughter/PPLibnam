//
//  PPSecondViewController.m
//  PPLibnam
//
//  Created by donfer on 16/3/24.
//  Copyright (c) 2016年 donfer. All rights reserved.
//

#import "PPSecondViewController.h"
#import "PPMidViewController.h"

@interface PPSecondViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *titleArray;
    UIView *coverView;
    UISearchBar *searchBar1;
}

@property(nonatomic,strong)UILabel *tishi;

@end

@implementation PPSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    滑动隐藏导航栏
//    self.navigationController.hidesBarsOnSwipe = YES;
    
    titleArray = [NSMutableArray array];
    [titleArray addObject:@"1"];
    [titleArray addObject:@"2"];
    [titleArray addObject:@"3"];
    [titleArray addObject:@"4"];
    [titleArray addObject:@"5"];
    [titleArray addObject:@"6"];
    [titleArray addObject:@"7"];
    [titleArray addObject:@"8"];
    [titleArray addObject:@"9"];
    [titleArray addObject:@"10"];
    [titleArray addObject:@"11"];
    [titleArray addObject:@"12"];
    [titleArray addObject:@"13"];
    [titleArray addObject:@"14"];
    [titleArray addObject:@"15"];
    [titleArray addObject:@"16"];
    [titleArray addObject:@"17"];
    
    self.myTableView.tableFooterView = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49);
    
    self.tishi = [[UILabel alloc] initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, 44)];
    self.tishi.text = @"继续下拉进入搜索";
    self.tishi.textAlignment = NSTextAlignmentCenter;
    self.tishi.textColor = [UIColor whiteColor];
    self.tishi.font = [UIFont systemFontOfSize:12];
    [self.view insertSubview:self.tishi belowSubview:self.myTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ScroViewDelegate
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    NSLog(@"%f",velocity.y);
//    if (velocity.y > 0) {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        self.tabBarController.tabBar.hidden = YES;
//    }else{
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        self.tabBarController.tabBar.hidden = NO;
//    }
//    
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < -100) {
        CGRect rect = self.myTableView.frame;
        rect.origin.y = self.view.frame.size.height;
        [UIView animateWithDuration:0.6 animations:^{
            self.myTableView.frame = rect;
        }completion:^(BOOL finished) {
            if (!coverView) {
                self.tabBarController.tabBar.hidden = YES;
                [self createTextField];
                coverView = [[UIView alloc] initWithFrame:self.view.bounds];
                coverView.backgroundColor = [UIColor whiteColor];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCover)];
                [coverView addGestureRecognizer:tap];
                coverView.alpha = 0;
                [self.view addSubview:coverView];
                [UIView animateWithDuration:0.25 animations:^{
                    coverView.alpha = 0.9;
                }];
            }
        }];
    }
}

- (void)createTextField
{
    if (!searchBar1) {
        searchBar1 = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*0.6, 44)];
        searchBar1.searchBarStyle = UISearchBarStyleDefault;
        self.navigationItem.titleView = searchBar1;
        [searchBar1 becomeFirstResponder];
        searchBar1.showsCancelButton = YES;
        searchBar1.delegate = self;
        [searchBar1 sizeToFit];
        
        for (id a in [searchBar1.subviews[0] subviews]) {
            if ([a isKindOfClass:[UIButton class]]) {
                UIButton *bun = (UIButton *)a;
                [bun setTitle:@"取消" forState:UIControlStateNormal];
            }
        }
    }
}

- (void)removeCover
{
    [self dismissCover];
}

- (void)dismissCover
{
    [searchBar1 resignFirstResponder];
    [searchBar1 removeFromSuperview];
    [coverView removeFromSuperview];
    coverView = nil;
    searchBar1 = nil;
    self.myTableView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"second";
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"+++++++++%@",searchBar);
    UIButton *btn = [searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"-----------%@",searchBar);
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissCover];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdetify = @"FirstTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[PPMidViewController alloc] init] animated:YES];
    
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
