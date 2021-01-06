//
//  YMRefresh.m
//  YunMaiTest
//
//  Created by zpf on 16/11/25.
//  Copyright © 2016年 YunMai. All rights reserved.
//

//核心类

#define Image(fileName) [UIImage imageNamed:fileName]

#import "YMRefresh.h"
#import "MJRefresh.h"

@interface YMRefresh () {
    NSArray *idleImages;
    NSArray *pullingImages;
    NSArray *refreshingImages;
}

//下拉时候触发的block
@property (nonatomic, copy) void(^DropDownRefreshBlock)(void);

//上拉时候触发的block
@property (nonatomic, copy) void(^UpDropRefreshBlock)(void);

@property (nonatomic, strong) UIScrollView *parameterScrollowView;

@end

@implementation YMRefresh

- (instancetype)init {
    if (self = [super init]) {
        
        //此gif为逐帧动画由多张图片组成
        
        //闲置状态下的gif(就是拖动的时候变化的gif)
        idleImages = [[NSArray alloc] initWithObjects:Image(@"refresh1"), Image(@"refresh2"), Image(@"refresh3"), Image(@"refresh4"), nil];
        
        //已经到达偏移量的gif(就是已经到达偏移量的时候的gif)
        pullingImages = [[NSArray alloc] initWithObjects:Image(@"refresh1"), Image(@"refresh2"), Image(@"refresh3"), Image(@"refresh4"), nil];
        
        //正在刷新的时候的gif
        refreshingImages = [[NSArray alloc] initWithObjects:Image(@"refresh1"), Image(@"refresh2"), Image(@"refresh3"), Image(@"refresh4"), nil];
        
    }
    return self;
}

//正常模式下拉上拉刷新(firstRefresh第一次进入的时候是否要刷新,这个值只对下拉刷新有影响)(refreshType设置为只支持上拉或者下拉的时候,将另外一个block置为nil)
- (void)normalModelRefresh:(UIScrollView *)scrollowView refreshType:(RefreshType)refreshType firstRefresh:(BOOL)firstRefresh timeLabHidden:(BOOL)timeLabHidden stateLabHidden:(BOOL)stateLabHidden dropDownBlock:(void(^)(void))dropDownBlock upDropBlock:(void(^)(void))upDropBlock {
    
    _parameterScrollowView = scrollowView;
    
    if (refreshType == RefreshTypeDropDown) {
        //只支持下拉
        
        //将block传入
        self.DropDownRefreshBlock = dropDownBlock;
        //初始化
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownBlockAction)];
        //是否隐藏上次更新的时间
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        //是否隐藏刷新状态label
        header.stateLabel.hidden = stateLabHidden;
        //tableView.mj_header接收header
        scrollowView.mj_header = header;
        //首次进来是否需要刷新
        if (firstRefresh) {
            [scrollowView.mj_header beginRefreshing];
        }
        //透明度渐变
        scrollowView.mj_header.automaticallyChangeAlpha = YES;
    }else if (refreshType == RefreshTypeUpDrop) {
        //只支持上拉
        //传入block
        self.UpDropRefreshBlock = upDropBlock;
        //初始化并指定方法
        scrollowView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDropBlockAction)];
        //指定数据加载完毕的文字
        [(MJRefreshAutoNormalFooter *)scrollowView.mj_footer setTitle:@"~已经到底了~" forState:MJRefreshStateNoMoreData];
    }else if (refreshType == RefreshTypeDouble) {
        //上拉和下拉都持支持
        
        //下拉
        //将block传入
        self.DropDownRefreshBlock = dropDownBlock;
        //初始化
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownBlockAction)];
        //是否隐藏上次更新的时间
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        //是否隐藏刷新状态label
        header.stateLabel.hidden = stateLabHidden;
        //tableView.mj_header接收header
        scrollowView.mj_header = header;
        //首次进来是否需要刷新
        if (firstRefresh) {
            [scrollowView.mj_header beginRefreshing];
        }
        //透明度渐变
        scrollowView.mj_header.automaticallyChangeAlpha = YES;
        //上拉
        //将block传入
        self.UpDropRefreshBlock = upDropBlock;
        //初始化并指定方法
        scrollowView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDropBlockAction)];
        //指定数据加载完毕的文字
        [(MJRefreshAutoNormalFooter *)scrollowView.mj_footer setTitle:@"~已经到底了~!" forState:MJRefreshStateNoMoreData];
    }
}


//gifRefresh
- (void)gifModelRefresh:(UIScrollView *)scrollowView refreshType:(RefreshType)refreshType firstRefresh:(BOOL)firstRefresh timeLabHidden:(BOOL)timeLabHidden stateLabHidden:(BOOL)stateLabHidden dropDownBlock:(void(^)(void))dropDownBlock upDropBlock:(void(^)(void))upDropBlock {
    
    _parameterScrollowView = scrollowView;
    
    if (refreshType == RefreshTypeDropDown) {
        //只支持下拉
        self.DropDownRefreshBlock = dropDownBlock;
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownBlockAction)];
        [header setImages:idleImages forState:MJRefreshStateIdle];
        [header setImages:pullingImages forState:MJRefreshStatePulling];
        [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        header.stateLabel.hidden = stateLabHidden;
        scrollowView.mj_header = header;
        if (firstRefresh) {
            [scrollowView.mj_header beginRefreshing];
        }
    }else if (refreshType == RefreshTypeUpDrop) {
        //只支持上拉
        self.UpDropRefreshBlock = upDropBlock;
        //初始化并指定方法
        scrollowView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDropBlockAction)];
        //指定数据加载完毕的文字
        [(MJRefreshAutoNormalFooter *)scrollowView.mj_footer setTitle:@"~已经到底了~!" forState:MJRefreshStateNoMoreData];
    }else if (refreshType == RefreshTypeDouble) {
        //支持上拉和下拉加载
        self.DropDownRefreshBlock = dropDownBlock;
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropDownBlockAction)];
        [header setImages:idleImages forState:MJRefreshStateIdle];
        [header setImages:pullingImages forState:MJRefreshStatePulling];
        [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.lastUpdatedTimeLabel.hidden = timeLabHidden;
        header.stateLabel.hidden = stateLabHidden;
        scrollowView.mj_header = header;
        if (firstRefresh) {
            [scrollowView.mj_header beginRefreshing];
        }
        self.UpDropRefreshBlock = upDropBlock;
        //初始化并指定方法
        scrollowView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDropBlockAction)];
        //指定数据加载完毕的文字
        [(MJRefreshAutoNormalFooter *)scrollowView.mj_footer setTitle:@"~已经到底了~" forState:MJRefreshStateNoMoreData];
    }
}

//下拉时候触发的block
- (void)dropDownBlockAction {
    if (_DropDownRefreshBlock) {
        _DropDownRefreshBlock();
        [_parameterScrollowView.mj_footer resetNoMoreData];
    }
}

//上拉时候触发的block
- (void)upDropBlockAction {
    if (_UpDropRefreshBlock) {
        _UpDropRefreshBlock();
    }
}

@end
