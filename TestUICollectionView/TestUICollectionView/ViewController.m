//
//  ViewController.m
//  TestUICollectionView
//
//  Created by syn on 16/8/1.
//  Copyright © 2016年 syn. All rights reserved.
//

#import "ViewController.h"
#import "ETWaterflowLayout.h"
#import "ETHorizontalWaterflowLayout.h"

static NSString * const XMGShopId = @"shop";

@interface ViewController () <UICollectionViewDataSource, ETWaterflowLayoutDelegate , ETHorizontalWaterflowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 垂直瀑布流
    ETWaterflowLayout *layout = [[ETWaterflowLayout alloc] init];
    layout.delegate = self;
    
//    ETHorizontalWaterflowLayout *layout = [[ETHorizontalWaterflowLayout alloc] init];
//    layout.delegate = self;
    
    CGRect viewFrame = CGRectMake(20, 20, 330, 200);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:viewFrame collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:XMGShopId];
    

    self.collectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XMGShopId forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    
    NSInteger tag = 10;
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        [cell.contentView addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"%zd", indexPath.item];
    [label sizeToFit];
    
    return cell;
}

#pragma mark - ETHorizontalWaterflowLayoutDelegate
- (CGFloat)waterflowLayout:(ETHorizontalWaterflowLayout *)waterflowLayout widthForItemAtIndex:(NSUInteger)index itemHeight:(CGFloat)itemHeight
{
    return 80 + arc4random_uniform(100);
}


#pragma mark - <ETWaterflowLayoutDelegate>

- (CGFloat)waterflowLayout:(ETWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    return 80 + arc4random_uniform(100);
}

#pragma mark - 公用代理
//
//- (CGFloat)rowMarginInWaterflowLayout:(ETWaterflowLayout *)waterflowLayout
//{
//    return 10;
//}
//
//- (CGFloat)columnCountInWaterflowLayout:(ETWaterflowLayout *)waterflowLayout
//{
//    return 4;
//}

- (CGFloat)rowCountInWaterflowLayout:(ETHorizontalWaterflowLayout *)waterflowLayout
{
    return 3;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ETWaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
@end
