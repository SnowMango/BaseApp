//
//  Module+Example.m
//  Pods
//
//  Created by zhengfeng on 16/11/7.
//
//

#import "Module+Example.h"

@implementation Example

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"绘图";
        self.loadingImage = @"AppIcon29x29";
        self.identifier = @"identifier";
        self.version = @"1.0.0";
        self.detail = @"this is a example module detail";
        self.rootViewController = [UIStoryboard storyboardWithName:@"ExampleMain" bundle:nil].instantiateInitialViewController;
    }
    return self;
}


@end
