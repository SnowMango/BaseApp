//
//  ModuleBasic.m
//  Demo
//
//  Created by zhengfeng on 16/11/7.
//
//

#import "Module.h"
#import "ModuleManager.h"
#import "ModuleHandle.h"

@implementation Module

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadModule];
    }
    return self;
}
- (void)loadModule
{
    self.title = @"Basic: Module name";
    self.loadingImage = @"Icon: module icon"; 
    self.identifier = @"identifier";
    self.version = @"1.0.0";
    self.detail = @"this is a basic module detail ";
    self.rootViewController = nil;
    
}

@end

@implementation ExampleModule



@end

@implementation ToolModule


@end

