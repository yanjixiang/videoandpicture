//
//  TSVideoPlayback.h
//  avplayer
//

#import <UIKit/UIKit.h>

@class TSVideoPlayback;
typedef enum : NSUInteger {
    TSDETAILTYPEVIDEO,//视频
    TSDETAILTYPEIMAGE,//图片
} TSDETAILTYPE;

@protocol TSVideoPlaybackDelegate <NSObject>

//点击图片索引
-(void)videoView:(TSVideoPlayback *)view didSelectItemAtIndexPath:(NSInteger)index;

@end

@interface TSVideoPlayback : UIView

@property (nonatomic,weak) id<TSVideoPlaybackDelegate> delegate;
@property (nonatomic,assign) TSDETAILTYPE type;

@property (nonatomic,strong) UIScrollView * scrolView;

/*
 * isVideo  是否带视屏链接
 * array    数据
 */
-(void)setWithIsVideo:(TSDETAILTYPE)type andDataArray:(NSArray *)array;

//清除缓存（必须写）
-(void)clearCache;

//是否自动播放视频
- (void)setPlayerIsAutoPlay:(BOOL)isAutoPlayer;
@end
