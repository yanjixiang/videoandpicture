//
//  VideoAndImgBanner.m
//  VideoAndImgBanner
//
//  Created by 闫继祥 on 2023/6/15.
//

#import "VideoAndPicBanner.h"
//#import <SDCycleScrollView.h>
#import <TYCyclePagerView.h>
#import <SJVideoPlayer/SJVideoPlayer.h>
#import <Masonry.h>
#import "UIImageView+WebCache.h"

@interface VideoAndPicBanner ()<TYCyclePagerViewDelegate,TYCyclePagerViewDataSource>

@property (nonatomic, strong) TYCyclePagerView *pagerView;


@property (nonatomic,strong)UILabel *indexL;


@property (nonatomic,strong)UIButton *videoBtn;

@property (nonatomic,strong)UIButton *imgBtn;

@end

@implementation VideoAndPicBanner

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.pagerView];
        [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.top.offset(0);
            make.bottom.offset(0);
        }];
        
        [self.pagerView addSubview:self.indexL];
        [self.indexL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(50);
            make.right.offset(-10);
            make.bottom.offset(-38);
            make.height.mas_equalTo(24);
        }];
        
        
        CGFloat x = ([UIScreen mainScreen].bounds.size.width - 120 - 20)/2;
        [self addSubview:self.videoBtn];
        [self.videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(24);
            make.left.offset(x);
            make.top.equalTo(self.indexL);
        }];
        
        
        [self addSubview:self.imgBtn];
        [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(24);
            make.left.equalTo(self.videoBtn.mas_right).offset(20);
            make.top.equalTo(self.videoBtn);
        }];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
}
- (void)setMediaPaths:(NSArray *)mediaPaths {
    _mediaPaths = mediaPaths;
    self.indexL.text = [NSString stringWithFormat:@"1/%ld",mediaPaths.count - 1];
    [self.pagerView reloadData];
    
}
- (TYCyclePagerView *)pagerView {
    if (!_pagerView) {
        _pagerView = [[TYCyclePagerView alloc]init];
        _pagerView.layer.borderWidth = 1;
        //无限循环开关
        _pagerView.isInfiniteLoop = YES;
        //自动滚动的时间间隔
        _pagerView.autoScrollInterval = 0.0;
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        [_pagerView registerClass:[BannerVideoCell class] forCellWithReuseIdentifier:@"cell1"];
        [_pagerView registerClass:[BannerPicCell class] forCellWithReuseIdentifier:@"cell2"];
    }
    return _pagerView;
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.mediaPaths.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    if (index == 0) {
        //视频
        if (self.videoCell == nil) {
            self.videoCell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndex:index];
            self.videoCell.videoUrl = self.mediaPaths[0];
        }
        //        __weak typeof(self) weakSelf = self;
        // 关闭所有手势
        __weak typeof(self.videoCell) weakCell = self.videoCell;
        self.videoCell.player.gestureRecognizerShouldTrigger = ^BOOL(__kindof SJBaseVideoPlayer * _Nonnull player, SJPlayerGestureType type, CGPoint location) {
            if (type == SJPlayerGestureType_Pan) {
                [weakCell.player pause];
                return NO;
            }
            return YES;
        };
        
        return self.videoCell;
    }else {
        //图片
        BannerPicCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndex:index];
        NSString *imagePath = self.mediaPaths[index];
        [cell.img sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:nil];
        
        return cell;
    }
    
}
- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame)*1.0, CGRectGetHeight(pageView.frame)*1.0);
    layout.itemSpacing = 0;
    //layout.minimumAlpha = 0.3;
    //    layout.itemHorizontalCenter = _horCenterSwitch.isOn;
    return layout;
}
- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
    if (toIndex == 0) {
        self.indexL.hidden = YES;
        
        self.videoBtn.selected = YES;
        self.imgBtn.selected = NO;
        self.videoBtn.backgroundColor = [UIColor redColor];
        self.imgBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        
    }else {
        self.indexL.hidden = NO;
        
        self.videoBtn.selected = NO;
        self.imgBtn.selected = YES;
        self.videoBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        self.imgBtn.backgroundColor = [UIColor redColor];
        
    }
    self.indexL.text = [NSString stringWithFormat:@"%ld/%ld",toIndex,self.mediaPaths.count - 1];
}

- (void)changeBtnClick:(UIButton *)btn{
    if (btn.tag == 1) {
        
        if (self.pagerView.curIndex != 0) {
            [self.pagerView scrollToItemAtIndex:0 animate:NO];
        }
    }
    else{
        if (self.mediaPaths.count < 2) {
            return;
        }
        
        if (self.pagerView.curIndex != 1) {
            [self.pagerView scrollToItemAtIndex:1 animate:NO];
        }
    }
    return;
}

- (UILabel *)indexL {
    if (!_indexL) {
        _indexL = [[UILabel alloc] init];
        _indexL.font = [UIFont systemFontOfSize:11];
        _indexL.textColor = UIColor.whiteColor;
        _indexL.textAlignment = NSTextAlignmentCenter;
        _indexL.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        _indexL.layer.cornerRadius = 24.0/2.0;
        _indexL.layer.masksToBounds = YES;
    }
    return _indexL;
}

- (UIButton *)videoBtn {
    if (!_videoBtn) {
        _videoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _videoBtn = [[UIButton alloc]init];
        [_videoBtn setTitle:@"视频" forState:UIControlStateNormal];
        [_videoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_videoBtn setBackgroundColor:[UIColor redColor]];
        _videoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _videoBtn.layer.cornerRadius = 24.0/2.0;
        _videoBtn.layer.masksToBounds = YES;
        _videoBtn.tag = 1;
        [_videoBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoBtn;
}
- (UIButton *)imgBtn {
    if (!_imgBtn){
        _imgBtn = [[UIButton alloc]init];
        [_imgBtn setTitle:@"图片" forState:UIControlStateNormal];
        [_imgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_imgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _imgBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _imgBtn.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        _imgBtn.layer.cornerRadius = 24.0/2.0;
        _imgBtn.layer.masksToBounds = YES;
        _imgBtn.tag = 2;
        [_imgBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _imgBtn;
}
@end
