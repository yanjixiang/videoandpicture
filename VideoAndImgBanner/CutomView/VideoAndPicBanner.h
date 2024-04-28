//
//  VideoAndImgBanner.h
//  VideoAndImgBanner
//
//  Created by 闫继祥 on 2023/6/15.
//

#import <UIKit/UIKit.h>
#import "BannerVideoCell.h"
#import "BannerPicCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoAndPicBanner : UIView

@property (nonatomic, strong) NSArray *mediaPaths;

@property (nonatomic,strong)BannerVideoCell *videoCell;

@end

NS_ASSUME_NONNULL_END
