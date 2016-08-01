//
//  ETHorizontalWaterflowLayout.m
//  TestUICollectionView
//
//  Created by syn on 16/8/1.
//  Copyright © 2016年 syn. All rights reserved.
//

#import "ETHorizontalWaterflowLayout.h"

/** 默认的列数 */
static const NSInteger ETDefaultRowCount = 2;
/** 每一列之间的间距 */
static const CGFloat ETDefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat ETDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets ETDefaultEdgeInsets = {10, 10, 10, 10};

@interface ETHorizontalWaterflowLayout()
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前宽度 */
@property (nonatomic, strong) NSMutableArray *rowWidths;
/** 内容的宽度 */
@property (nonatomic, assign) CGFloat contentWidth;

// 声明是为了可以使用点语法
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)rowCount;
- (UIEdgeInsets)edgeInsets;
@end

@implementation ETHorizontalWaterflowLayout


/**
 * 初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.contentWidth = 0;
    
    // 清除以前计算的所有宽度
    [self.rowWidths removeAllObjects];
    for (NSInteger i = 0; i < self.rowCount; i++) {
        [self.rowWidths addObject:@(self.edgeInsets.left)];
    }
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/**
 * 决定cell的排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView的高度
    CGFloat collectionViewH = self.collectionView.frame.size.height;
    
//    CGFloat w = 40 + arc4random_uniform(100);
    CGFloat h = (collectionViewH - self.edgeInsets.top - self.edgeInsets.bottom - (self.rowCount - 1) * self.rowMargin) / self.rowCount;
    CGFloat w = [self.delegate waterflowLayout:self widthForItemAtIndex:indexPath.item itemHeight:h];
    
    // 找出宽度最短的那一行
    NSInteger destRow = 0;
    CGFloat minRowWidth = [self.rowWidths[0] doubleValue];
    for (NSInteger i = 1; i < self.rowCount; i++) {
        // 取得第i行的高度
        CGFloat rowWidth = [self.rowWidths[i] doubleValue];
        
        if (minRowWidth > rowWidth) {
            minRowWidth = rowWidth;
            destRow = i;
        }
    }
    
    CGFloat y = self.edgeInsets.top + destRow * (h + self.rowMargin);
    CGFloat x = minRowWidth;
    if (x != self.edgeInsets.left) {
        x += self.columnMargin;
    }
    
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新最短那行的宽度
    self.rowWidths[destRow] = @(CGRectGetMaxX(attrs.frame));
    
    // 记录内容的高度
    CGFloat rowWidth = [self.rowWidths[destRow] doubleValue];
    if (self.contentWidth < rowWidth) {
        self.contentWidth = rowWidth;
    }
    
    return attrs;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.contentWidth + self.edgeInsets.right, self.collectionView.frame.size.height);
}

#pragma mark - 常见数据处理
- (NSInteger)rowCount
{
    if ([self.delegate respondsToSelector:@selector(rowCountInWaterflowLayout:)]) {
        return [self.delegate rowCountInWaterflowLayout:self];
    } else {
        return ETDefaultRowCount;
    }
}

- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return ETDefaultRowMargin;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)]) {
        return [self.delegate columnMarginInWaterflowLayout:self];
    } else {
        return ETDefaultColumnMargin;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)]) {
        return [self.delegate edgeInsetsInWaterflowLayout:self];
    } else {
        return ETDefaultEdgeInsets;
    }
}

#pragma mark - 懒加载

- (NSMutableArray *)rowWidths
{
    if (!_rowWidths) {
        _rowWidths = [NSMutableArray array];
    }
    return _rowWidths;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

@end
