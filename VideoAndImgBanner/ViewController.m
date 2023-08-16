//
//  ViewController.m
//  VideoAndImgBanner
//
//  Created by 闫继祥 on 2023/6/15.
//

#import "ViewController.h"

#import <Masonry.h>
#import "VideoAndImgBanner.h"

#define  SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width


@interface ViewController ()

@property (nonatomic,strong)VideoAndImgBanner *bannerView;
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

- (VideoAndImgBanner *)bannerView {
    if (!_bannerView) {
        _bannerView = [[VideoAndImgBanner alloc] init];
    }
    return _bannerView;
}
-(NSArray *)bannerArray
{
    return @[
        @"http://vjs.zencdn.net/v/oceans.mp4",
        @"http://img.ptocool.com/3332-1518523974126-29",
        @"http://img.ptocool.com/3332-1518523974125-28",
        @"http://img.ptocool.com/3332-1518523974125-27",
        @"http://img.ptocool.com/3332-1518523974124-26",
        @"http://img.ptocool.com/3332-1518523974124-26"];
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
