//
//  VideoAndImgBanner.h
//  VideoAndImgBanner
//
//  Created by 闫继祥 on 2023/6/15.
//

#import <UIKit/UIKit.h>
#import "VideoPlayerCell.h"
#import "ImageCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoAndImgBanner : UIView

@property (nonatomic, strong) NSArray *mediaPaths;

@property (nonatomic,strong)VideoPlayerCell *videoCell;

@end

NS_ASSUME_NONNULL_END
