//
//  PPThirdViewController.m
//  PPLibnam
//
//  Created by donfer on 16/3/24.
//  Copyright (c) 2016年 donfer. All rights reserved.
//

#import "PPThirdViewController.h"
#import "PPCollectionViewCell.h"

#define ITEM_W self.view.bounds.size.width/2.2
#define VIEW_W self.view.bounds.size.width
#define NUM_ITEMS 2 //item个数
#define SPACE ((VIEW_W)-(ITEM_W)*NUM_ITEMS)/(NUM_ITEMS+1.0)//item间距


@interface PPThirdViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *heightArr;
@property(nonatomic,strong)UICollectionReusableView *RView;


@end

@implementation PPThirdViewController

static NSString *MYCell = @"MYCell";
static NSString *HELDER = @"MYCell1";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.heightArr = [NSMutableArray array];
    [self createCollectView];
    
    _RView = [UICollectionReusableView new];

}

-(void)createCollectView
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//    int colorBlu = arc4random()%66;
//    layout.itemSize = CGSizeMake(self.view.bounds.size.width/7, self.view.bounds.size.width/7);//每个cell的大小
    
    layout.minimumLineSpacing = 10.0f;//每行的最小间距
//
    layout.minimumInteritemSpacing = 10.0f;//每列的最小间距
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//网格视图的/上/左/下/右,的边距
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout]; //初始化网格视图大小
    
    [self.collectionView registerClass:[PPCollectionViewCell class] forCellWithReuseIdentifier:MYCell];//cell重用设置ID
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HELDER];
    
    self.collectionView.delegate = self;//实现网格视图的delegate
    
    self.collectionView.dataSource = self;//实现网格视图的dataSource
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView registerNib:[UINib nibWithNibName:@"PPCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:MYCell];
    
    PPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MYCell forIndexPath:indexPath];
    
    NSInteger remider = indexPath.row%NUM_ITEMS;
    NSInteger currentRow = indexPath.row/NUM_ITEMS;
    
    CGFloat currentHeight = [self.heightArr[indexPath.row] integerValue];
    CGFloat posiTionX = ITEM_W*remider + SPACE*(remider +1);
    CGFloat positionY = (currentRow+1)*SPACE+120;
    
//    根据上一个item可以做优化
    for (int i = 0; i < currentRow; i++) {
        NSInteger position = remider + i*NUM_ITEMS;
        positionY += [self.heightArr[position] floatValue];
    }

    cell.frame = CGRectMake(posiTionX, positionY, ITEM_W, currentHeight);

    return cell;
}

//返回collectionView的helder高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(VIEW_W, 120);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int colorBlu = rand()%2;
    int a = colorBlu == 1? 66:33;
    [self.heightArr addObject:[NSString stringWithFormat:@"%d",a]];
    
    return CGSizeMake(ITEM_W, a);
}

//通过注册的Identifier返回头部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    self.RView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HELDER forIndexPath:indexPath];
    _RView.backgroundColor = [UIColor grayColor];
    return self.RView;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
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
