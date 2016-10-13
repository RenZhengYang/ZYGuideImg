//
//  ZYGuideViewController.m
//  ZYGuideImg
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZYGuideViewController.h"

@interface ZYGuideViewController () <UIScrollViewDelegate>

@end

@implementation ZYGuideViewController
{
    UIViewController     *_rootVC;
    NSArray                  *_imageNames;
    UIPageControl        *_pageControl;
    UIButton                  *_skipButton;
}

+ (BOOL)zy_shouldShowNewFeature
{
    // the app version in the sandbox
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:@"CFBundleShortVersionString"];
    // the current app version
      NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    // Compare versions
    if ([currentVersion isEqualToString:lastVersion]) {
        return NO;
    }else {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"CFBundleShortVersionString"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
     }
    
}

- (instancetype)initWithImageNames:(NSArray *)imageNames rootViewController:(UIViewController *)rootVC
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
        _imageNames = imageNames;
        _rootVC = rootVC;
        [self setup];
}
    return self;
}

+ (instancetype)zy_newFeatureWithImageNames:(NSArray *)imageNames rootViewController:(UIViewController *)rootVC
{
    return [[self alloc]initWithImageNames:imageNames rootViewController:rootVC];
}


- (void)setup {
  
    if(_imageNames.count > 0){
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        [self.view addSubview:({
            scrollView.delegate = self;
            scrollView.bounces = NO;
            scrollView.pagingEnabled = YES;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.frame = self.view.bounds;
            scrollView.contentSize = (CGSize){self.view.frame.size.width * _imageNames.count, 0};
            scrollView;
        })];
    
        CGFloat imageW = self.view.frame.size.width;
        CGFloat imageH = self.view.frame.size.height;
    
        for (int i = 0; i < _imageNames.count; i++) {
         
            [scrollView addSubview:({
            UIImageView *imageView = [[UIImageView alloc] init];
                
            [imageView setImage:[UIImage imageNamed:_imageNames[i]]];
            [imageView setFrame:(CGRect){imageW * i, 0, imageW, imageH}];

             if (i == _imageNames.count - 1) {
                 // Here you can add a custom Button to switch the root controller.
                // Such as
                {
                    UIButton *customBtn = [[UIButton alloc] init];
                    [customBtn setImage:[UIImage imageNamed:@"start_huanshi_AR_normal"]  forState:UIControlStateNormal];
                    [customBtn setImage:[UIImage imageNamed:@"start_huanshi_AR_pressed"] forState:UIControlStateHighlighted];
                    [customBtn sizeToFit];
                    customBtn.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height - customBtn.frame.size.height - 100);
                    [customBtn addTarget:self action:@selector(tapAciton) forControlEvents:UIControlEventTouchUpInside];
                    [imageView addSubview:customBtn];
                    [imageView setUserInteractionEnabled:YES];
                }
                  [imageView setUserInteractionEnabled:YES];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAciton)];
                [imageView addGestureRecognizer:tap];
            }
            imageView;
            
            })];
   }
    
        [self.view addSubview:({
            _pageControl = [[UIPageControl alloc] init];
            [_pageControl setNumberOfPages:_imageNames.count];
            [_pageControl setHidesForSinglePage:YES];
            [_pageControl setUserInteractionEnabled:NO];
            [_pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
            [_pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
            [_pageControl setFrame:CGRectMake(0, self.view.frame.size.height * 0.9, self.view.frame.size.width, 40)];
            _pageControl;
        })];

        [self.view addSubview:({
            CGFloat margin = 10;
            _skipButton = [[UIButton alloc] init];
            _skipButton.frame = CGRectMake(self.view.frame.size.width - margin - 60, self.view.frame.size.height - margin - 40, 60, 30);
            _skipButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            _skipButton.layer.cornerRadius = 15;
            _skipButton.layer.masksToBounds = YES;
            _skipButton.titleLabel.adjustsFontSizeToFitWidth = YES;
            _skipButton.titleLabel.font = [UIFont systemFontOfSize:16];
            _skipButton.hidden = YES;
            [_skipButton setTitle:@"跳过" forState:UIControlStateNormal];
            [_skipButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [_skipButton addTarget:self action:@selector(skipBtnAction) forControlEvents:UIControlEventTouchUpInside];
            _skipButton;
        })];

}}

- (void)tapAciton {
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow
                      duration:0.75f
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [UIApplication sharedApplication].keyWindow.rootViewController = _rootVC;
                    }
                    completion:nil];
}

- (void)skipBtnAction {
    
    [self tapAciton];
}

#pragma mark - Setters

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    
    [_pageControl setCurrentPageIndicatorTintColor:currentPageIndicatorTintColor];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    
    _pageIndicatorTintColor = pageIndicatorTintColor;
    
    [_pageControl setPageIndicatorTintColor:pageIndicatorTintColor];
}

- (void)setHidePageControl:(BOOL)hidePageControl {
    
    _hidePageControl = hidePageControl;
    
    _pageControl.hidden = hidePageControl;
}

- (void)setHideSkipButton:(BOOL)hideSkipButton {
    
    _hideSkipButton = hideSkipButton;
    
    _skipButton.hidden = hideSkipButton;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    _pageControl.currentPage = page;
}

@end
