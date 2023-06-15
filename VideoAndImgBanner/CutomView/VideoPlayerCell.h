//
//  VideoPlayerCell.h
//  VideoAndImgBanner
//
//  Created by 闫继祥 on 2023/6/15.
//

#import <UIKit/UIKit.h>
#import <SJVideoPlayer/SJVideoPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerCell : UICollectionViewCell

@property (nonatomic,strong)SJVideoPlayer *player;
@property (nonatomic,copy)NSString *videoUrl;

@end

NS_ASSUME_NONNULL_END
