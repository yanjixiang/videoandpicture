//
//  VideoPlayerCell.m
//  VideoAndImgBanner
//
//  Created by 闫继祥 on 2023/6/15.
//

#import "BannerVideoCell.h"
#import <Masonry.h>
#import <SDWebImage.h>
@implementation BannerVideoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.player.view];
        [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.top.offset(0);
            make.bottom.offset(0);
        }];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
}
- (void)setVideoUrl:(NSString *)videoUrl {
    _videoUrl = videoUrl;
    // 设置资源进行播放
    NSURL *url = [NSURL URLWithString:videoUrl];
    // 创建 SJVideoPlayerURLAsset 实例，并将 autoPlay 属性设置为 NO
    SJVideoPlayerURLAsset *asset = [[SJVideoPlayerURLAsset alloc] initWithURL:url];
    self.player.URLAsset = asset;
    
    //封面
    //    [self.player.presentView.placeholderImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.ptocool.com/3332-1518523974126-29"]];
    //
    //设置初始状态为暂停，不自动播放
    [self.player pause];
    
    //监听播放状态
    self.player.playbackObserver.playbackStatusDidChangeExeBlock = ^(__kindof SJBaseVideoPlayer * _Nonnull player) {
        if (player.assetStatus == SJAssetStatusReadyToPlay) {
            //当前资源可随时进行播放(播放控制请查看
            
        }else if (player.assetStatus == SJAssetStatusFailed) {
            //发生错误
            
        }else if (player.assetStatus == SJAssetStatusPreparing) {
            //准备中
            
        }else if (player.assetStatus == SJAssetStatusUnknown) {
            //位置状态
            
        }
        
        if (player.timeControlStatus == SJPlaybackTimeControlStatusPlaying) {
            NSLog(@"正在播放");
            
        }else if (player.timeControlStatus == SJPlaybackTimeControlStatusPaused) {
            NSLog(@"暂停状态");
            
        }else if (player.timeControlStatus == SJPlaybackTimeControlStatusWaitingToPlay) {
            NSLog(@"正在缓冲");
        }
    };
}
- (SJVideoPlayer *)player {
    if (!_player) {
        _player = [[SJVideoPlayer alloc] init];
        //隐藏返回按钮
        _player.defaultEdgeControlLayer.hiddenBackButtonWhenOrientationIsPortrait = YES;
        //暂停的时候保持控制层显示
        _player.pausedToKeepAppearState = YES;
        //    准备好显示画面时, 是否隐藏占位图
        //        _player.automaticallyHidesPlaceholderImageView = NO;
        
    }
    return _player;
}

@end
