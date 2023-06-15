//
//  ImageCell.m
//  VideoAndImgBanner
//
//  Created by 闫继祥 on 2023/6/15.
//

#import "ImageCell.h"
#import <Masonry.h>
@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.img];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
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
- (UIImageView *)img {
    if (!_img) {
        _img = [[UIImageView alloc] init];
    }
    return _img;
}
@end
