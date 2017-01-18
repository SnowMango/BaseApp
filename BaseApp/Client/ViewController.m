//
//  ViewController.m
//  OneApplication
//
//  Created by zhengfeng on 17/1/9.
//  Copyright © 2017年 zhengfeng. All rights reserved.
//

#import "ViewController.h"

/*
 UILaunchStoryboardName，UIMainStoryboardFile //系统会自动生成
 UIGuideStoryboardName,UILoginStoryboardName //手动在info.plist中配置
 */
NSString * const kRootLaunchStoryboardKey = @"UILaunchStoryboardName";
NSString * const kRootGuideStoryboardKey = @"UIGuideStoryboardName";
NSString * const kRootLoginStoryboardKey = @"UILoginStoryboardName";
NSString * const kRootMainStoryboardKey = @"UIMainStoryboardFile";


@interface ViewController ()
{
    UIViewController *launch;
    UIViewController *guide;
    UIViewController *login;
    UIViewController *main;

    NSDictionary * children;
    UIViewController *currentChild;
    UIInterfaceOrientation supportedInterface;
}

@end

@implementation ViewController



#pragma mark - Public
- (void)exitLogin
{
    [self showChildViewController:kRootLoginStoryboardKey];
}
- (void)login
{
    [self showChildViewController:kRootMainStoryboardKey];
}

- (void)showChildViewController:(NSString*)storyboardKey
{
    UIViewController * newVC = children[storyboardKey];
    if (newVC && ![newVC isKindOfClass:[NSNull class]] && ![newVC isEqual:currentChild]) {
        [self transitionFromOldViewController:currentChild toNewViewController:newVC];
    }
}

- (UIViewController*)rootChildViewController:(const NSString *)storyboardKey
{
    UIViewController * vc = children[storyboardKey];
    if ([vc isKindOfClass:[NSNull class]]) {
        vc = nil;
    }
    return vc;
}
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadChildrenViewController];
}


//设置childViewControllerd的frame
- (void)fitFrameForChildViewController:(UIViewController *)chileViewController{
    chileViewController.view.frame = self.view.bounds;
}

#pragma mark - 切换ViewController
- (void)transitionFromOldViewController:(UIViewController *)oldViewController toNewViewController:(UIViewController *)newViewController {
    
    currentChild = newViewController;
    [self transitionFromViewController:oldViewController
                      toViewController:newViewController
                              duration:0.5
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil completion:^(BOOL finished)
     {
         if (finished) {
             [newViewController didMoveToParentViewController:self];
         }else{
             currentChild = oldViewController;
         }
     }];
}

#pragma mark - ChildrenViewController

/**
    加载子viewcontroller
 */
- (void)loadChildrenViewController
{
    NSMutableDictionary * mutableDic = [@{kRootMainStoryboardKey: [NSNull null],
                                          kRootLoginStoryboardKey: [NSNull null],
                                          kRootGuideStoryboardKey: [NSNull null],
                                          kRootLaunchStoryboardKey: [NSNull null]} mutableCopy];
    main = [self viewControllerWithKey:kRootMainStoryboardKey];
    if (main) {
        mutableDic[kRootMainStoryboardKey] = main;
        [self addChildViewController:main];
    }
    
    login = [self viewControllerWithKey:kRootLoginStoryboardKey];
    if (login) {
        mutableDic[kRootLoginStoryboardKey] = login;
        [self addChildViewController:login];
    }
    guide = [self viewControllerWithKey:kRootGuideStoryboardKey];
    if (guide) {
        mutableDic[kRootGuideStoryboardKey] = guide;
        [self addChildViewController:guide];
    }
    launch = [self viewControllerWithKey:kRootLaunchStoryboardKey];
    if (launch) {
        mutableDic[kRootLaunchStoryboardKey] = launch;
        [self addChildViewController:launch];
    }
    currentChild = launch;
    children = [mutableDic copy];
    if (currentChild) {
        [self.view addSubview:currentChild.view];
    }
}

/**
    根据MainBundle info.plist 获取viewcontroller
 */
- (UIViewController *)viewControllerWithKey:(NSString *)key
{
    UIViewController *vc = nil;
    NSString *storyboardName = [[NSBundle mainBundle] infoDictionary][key];
    if ([self checkStoryboardName:storyboardName]) {
        vc = [UIStoryboard storyboardWithName:storyboardName bundle:nil].instantiateInitialViewController;
    
    }
    return vc;
}

// 检查项目中是否存在以name为名的storyboard
- (BOOL)checkStoryboardName:(NSString *)name
{
    BOOL ret = NO;
    if (name.length) {
       ret = [[NSBundle mainBundle] pathForResource:name ofType:@"storyboardc"].length ;
    }
    return ret;
}

#pragma mark - 旋转和状态栏
// 返回app 最上层的viewcontroller
- (UIViewController *)root_topViewController
{
    UIViewController * topViewController = currentChild;
    if (currentChild) {
        while ([topViewController isKindOfClass:[UINavigationController class]]
               ||
               [topViewController isKindOfClass:[UITabBarController class]]) {
            if ([topViewController isKindOfClass:[UINavigationController class]] ) {
                topViewController = ((UINavigationController*)topViewController).topViewController;
            }else if ([topViewController isKindOfClass:[UITabBarController class]]) {
                topViewController = ((UITabBarController*)topViewController).selectedViewController;
            }
        }
    }
    return topViewController;
}

//返回判断StatusBarStyle的viewcontroller
- (UIViewController *)childViewControllerForStatusBarStyle{
    return [self root_topViewController];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//返回支持屏幕旋转的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[self root_topViewController]
            supportedInterfaceOrientations];
}
- (BOOL)shouldAutorotate
{
    return YES;
}



@end
