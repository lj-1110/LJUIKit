//
//  UITableView+CLSectionCorner.m
//  BabyGod
//
//  Created by mac on 2020/1/22.
//  Copyright © 2020年 mac. All rights reserved.
//

#import "UITableView+CLSectionCorner.h"

@implementation UITableView (CLSectionCorner)

- (void)corner_willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self corner_willDisplayCell:cell forRowAtIndexPath:indexPath radius:16];
}

- (void)corner_willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath radius:(float)radius
{
    //圆率
    CGFloat cornerRadius = radius;
    //大小
    CGRect bounds = cell.bounds;
    //行数
    NSInteger numberOfRows = [self numberOfRowsInSection:indexPath.section];
    
    //绘制曲线
    UIBezierPath *bezierPath = nil;
    
    if (indexPath.row == 0 && numberOfRows == 1) {
        //一个为一组时,四个角都为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else if (indexPath.row == 0) {
        //为组的第一行时,左上、右上角为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else if (indexPath.row == numberOfRows - 1) {
        //为组的最后一行,左下、右下角为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    } else {
        //中间的都为矩形
        bezierPath = [UIBezierPath bezierPathWithRect:bounds];
    }
    //cell的背景色透明
    cell.backgroundColor = [UIColor clearColor];
    //新建一个图层
    CAShapeLayer *layer = [CAShapeLayer layer];
    //图层边框路径
    layer.path = bezierPath.CGPath;
    //图层填充色,也就是cell的底色
    layer.fillColor = [UIColor whiteColor].CGColor;
    //图层边框线条颜色
    /*
     如果self.tableView.style = UITableViewStyleGrouped时,每一组的首尾都会有一根分割线,目前我还没找到去掉每组首尾分割线,保留cell分割线的办法。
     所以这里取巧,用带颜色的图层边框替代分割线。
     这里为了美观,最好设为和tableView的底色一致。
     设为透明,好像不起作用。
     */
    layer.strokeColor = [UIColor whiteColor].CGColor;
    //将图层添加到cell的图层中,并插到最底层
    [cell.layer insertSublayer:layer atIndex:0];
}

@end
