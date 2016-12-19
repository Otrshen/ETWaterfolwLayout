//
//  ETWaterflowLayout.h
//  TestUICollectionView
//
//  Created by syn on 16/8/1.
//  Copyright © 2016年 syn. All rights reserved.
//
//  瀑布流

#import <UIKit/UIKit.h>

@class ETWaterflowLayout;

@protocol ETWaterflowLayoutDelegate <NSObject>
@required
/**
 *  Item的索引和宽度
 */
- (CGFloat)waterflowLayout:(ETWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(ETWaterflowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(ETWaterflowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(ETWaterflowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ETWaterflowLayout *)waterflowLayout;
@end

@interface ETWaterflowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<ETWaterflowLayoutDelegate> delegate;
@end
