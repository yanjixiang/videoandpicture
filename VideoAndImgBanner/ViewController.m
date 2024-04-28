//
//  ViewController.m
//  VideoAndImgBanner
//
//  Created by 闫继祥 on 2023/6/15.
//

#import "ViewController.h"

#import <Masonry.h>
#import "VideoAndPicBanner.h"


#define  SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width


@interface ViewController ()

@property (nonatomic,strong)VideoAndPicBanner *bannerView;
@property (nonatomic,strong)NSArray *bannerArray;
@end



@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(100);
        make.height.mas_equalTo(300);
    }];
    
    self.bannerView.mediaPaths = self.bannerArray;
}

- (VideoAndPicBanner *)bannerView {
    if (!_bannerView) {
        _bannerView = [[VideoAndPicBanner alloc] init];
    }
    return _bannerView;
}
-(NSArray *)bannerArray
{
    return @[
        @"http://www.w3school.com.cn/example/html5/mov_bbb.mp4",
        @"https://img0.baidu.com/it/u=2810162682,1658069482&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1200",
        @"http://img0.baidu.com/it/u=4041499034,1836682537&fm=253&app=138&f=JPEG?w=800&h=1200",
        @"http://img2.baidu.com/it/u=2251990402,2452081879&fm=253&app=138&f=JPEG?w=1200&h=800",
        @"http://img0.baidu.com/it/u=3914136240,3888777778&fm=253&app=138&f=JPEG?w=800&h=1200",
        @"http://img1.baidu.com/it/u=2308921345,283361833&fm=253&app=138&f=JPEG?w=800&h=1200"];
}

// 以下的代码都是固定的, 可以直接copy到视图控制器中
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.bannerView.videoCell.player vc_viewDidAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.bannerView.videoCell.player vc_viewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.bannerView.videoCell.player vc_viewDidDisappear];
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}


@end
