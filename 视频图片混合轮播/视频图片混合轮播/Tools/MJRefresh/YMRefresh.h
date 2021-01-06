//
//  YMRefresh.h
//  YunMaiTest
//
//  Created by zpf on 16/11/25.
//  Copyright © 2016年 YunMai. All rights reserved.
//

//核心类

//当前类的封装都是基于MJRefresh的(当前类为对MJRefresh的二次封装)
//当前类的使用需要先导入MJRefresh三方库,git上有下载哦!
//当前类提供了连个刷新的方法(正常模式和gif模式)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshTypeDropDown = 0,  //只支持下拉
    RefreshTypeUpDrop = 1,    //只支持上拉
    RefreshTypeDouble = 2,    //支持上拉和下拉
};

@interface YMRefresh : NSObject

//正常模式上拉下拉刷新
- (void)normalModelRefresh:(UIScrollView *)scrollowView refreshType:(RefreshType)refreshType firstRefresh:(BOOL)firstRefresh timeLabHidden:(BOOL)timeLabHidden stateLabHidden:(BOOL)stateLabHidden dropDownBlock:(void(^)(void))dropDownBlock upDropBlock:(void(^)(void))upDropBlock;

//gifRefresh
- (void)gifModelRefresh:(UIScrollView *)scrollowView refreshType:(RefreshType)refreshType firstRefresh:(BOOL)firstRefresh timeLabHidden:(BOOL)timeLabHidden stateLabHidden:(BOOL)stateLabHidden dropDownBlock:(void(^)(void))dropDownBlock upDropBlock:(void(^)(void))upDropBlock;

//后期如果有需要还要对diy的模式进行封装



@end
