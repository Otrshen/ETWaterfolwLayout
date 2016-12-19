//
//  ETHorizontalWaterflowLayout.h
//  TestUICollectionView
//
//  Created by syn on 16/8/1.
//  Copyright © 2016年 syn. All rights reserved.
//
//  水平瀑布流

#import <UIKit/UIKit.h>

@class ETHorizontalWaterflowLayout;

@protocol ETHorizontalWaterflowLayoutDelegate <NSObject>
@required
/** Item的索引和高度 */
- (CGFloat)waterflowLayout:(ETHorizontalWaterflowLayout *)waterflowLayout widthForItemAtIndex:(NSUInteger)index itemHeight:(CGFloat)itemHeight;

@optional

/** 共几行 */
- (CGFloat)rowCountInWaterflowLayout:(ETHorizontalWaterflowLayout *)waterflowLayout;
/** 每一列之间的间距 */
- (CGFloat)columnMarginInWaterflowLayout:(ETHorizontalWaterflowLayout *)waterflowLayout;
/** 每一行之间的间距 */
- (CGFloat)rowMarginInWaterflowLayout:(ETHorizontalWaterflowLayout *)waterflowLayout;
/** 边缘间距 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ETHorizontalWaterflowLayout *)waterflowLayout;
@end

@interface ETHorizontalWaterflowLayout : UICollectionViewLayout

/** 代理 */
@property (nonatomic, weak) id<ETHorizontalWaterflowLayoutDelegate> delegate;
@end
