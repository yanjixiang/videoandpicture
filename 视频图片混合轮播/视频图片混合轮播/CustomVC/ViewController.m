//
//  ViewController.m
//  视频图片混合轮播
//
//  Created by 闫继祥 on 2019/7/18.
//  Copyright © 2019 闫继祥. All rights reserved.
//

#import "ViewController.h"
#import "TSVideoPlayback.h"
#import "SDPhotoBrowser.h"

#define  SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<TSVideoPlaybackDelegate,SDPhotoBrowserDelegate>
@property (nonatomic,strong) TSVideoPlayback *video;
@property(nonatomic, strong)UIView *headerView;
@end

@implementation ViewController

- (void)dealloc {
    [self.video clearCache];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initialControlUnit];
}
-(void)initialControlUnit
{
    //状态栏高度
    
    CGRect statusbar_frame =[[UIApplication sharedApplication]statusBarFrame];
    
    CGFloat statusbar_height = statusbar_frame.size.height;
    
    //导航栏高度
    CGFloat navi_height = statusbar_height + self.navigationController.navigationBar.frame.size.height;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, navi_height, SCREEN_WIDTH, 280)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: headerView];
    
    self.video = [[TSVideoPlayback alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) ];
    self.video.delegate = self;
  
    self.navigationItem.title = @"视频图片轮播";
    //全图片  ---  TSDETAILTYPEIMAGE
    [self.video setWithIsVideo:TSDETAILTYPEVIDEO andDataArray:[self bannerArray]];
    [headerView addSubview:self.video];
 
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.video.frame.size.height+self.video.frame.origin.y, SCREEN_WIDTH, 30)];
    bottomView.backgroundColor = [UIColor redColor];
    [headerView addSubview:bottomView];
    
    UILabel *leftL = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, (SCREEN_WIDTH-10)/2, 30)];
    leftL.textColor = [UIColor whiteColor];
    leftL.font = [UIFont systemFontOfSize:14];
    leftL.text = @"阶梯价格买得越多优惠越多";
    [bottomView addSubview:leftL];
    leftL.adjustsFontSizeToFitWidth = YES;
    
    UILabel *rightL = [[UILabel alloc] initWithFrame:CGRectMake(leftL.frame.origin.x+leftL.frame.size.width, 0, leftL.frame.size.width, 30)];
    rightL.textColor = [UIColor whiteColor];
    rightL.font = [UIFont systemFontOfSize:12];
    rightL.text = @"多阶梯满足不同采购需求";
    [bottomView addSubview:rightL];
    rightL.textAlignment = NSTextAlignmentRight;
    
}
-(NSArray *)bannerArray
{
    return @[
             @"http://zhibo.hnasjing.cn/vedio/5.mp4",
             @"http://img.ptocool.com/3332-1518523974126-29",
             @"http://img.ptocool.com/3332-1518523974125-28",
             @"http://img.ptocool.com/3332-1518523974125-27",
             @"http://img.ptocool.com/3332-1518523974124-26",
             @"http://img.ptocool.com/3332-1518523974124-26"];
}
#pragma mark - TSVideoPlaybackDelegate
-(void)videoView:(TSVideoPlayback *)view didSelectItemAtIndexPath:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
    
    SDPhotoBrowser * broser = [[SDPhotoBrowser alloc] init];
    broser.currentImageIndex = index-1;
    broser.sourceImagesContainerView = self.video.scrolView;
    broser.imageCount =self.bannerArray.count-1;
    broser.delegate = self;
    [broser show];
    
}
////网址 的iamge
-(NSURL*)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    //网络图片（如果崩溃，可能是此图片地址不存在了）
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.bannerArray];
    [array removeObjectAtIndex:0];
    NSString *imageName = array[index];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", imageName]];

    return url;
}

//大图占位图/或者本地图片展示
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
   
    UIImage *img = [UIImage imageNamed:@"zhanweitu"];
   
    return img;
}

@end
