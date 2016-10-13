//
//  ZYGuideViewController.h
//  ZYGuideImg
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYGuideViewController : UIViewController

#pragma mark - Properties

/**
 Whether to hide pageControl, default is NO which means show pageControl.
 */
@property (nonatomic, assign) BOOL hidePageControl;

/**
 Whether to hide skip Button, default is YES which means hide skip Button.
 */
@property (nonatomic, assign) BOOL hideSkipButton;

/**
 Current page indicator tint color, default is [UIColor whiteColor].
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

/**
 Other page indicator tint color, default is [UIColor lightGrayColor].
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

#pragma mark - Class methods
/**
  Only the first start app need show new features.

 @return return YES to show, NO not to show.
 */
+ (BOOL)zy_shouldShowNewFeature;
/**
 Create new features view controller with images.
 
 @param imageNames The image's name array.
 @param rootVC     The key window's true root view controller.
 
 @return SRNewFeatureViewController
 */
+ (instancetype)zy_newFeatureWithImageNames:(NSArray *)imageNames rootViewController:(UIViewController *)rootVC;

@end
