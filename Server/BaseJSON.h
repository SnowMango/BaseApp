//
//  BaseJSON.h
//  OneApplication
//
//  Created by 郑丰 on 2017/1/14.
//  Copyright © 2017年 zhengfeng. All rights reserved.
//
// a network response data model
#import <Foundation/Foundation.h>
@interface BaseJSON : NSObject<NSCopying, NSMutableCopying, NSCoding>
{
    //动态property的key、value存储空间 
    NSMutableDictionary * ivar_list;
}
@property (nonatomic, strong) NSString * identifer;

/**
 设置property并将keyedValues中的所有Dictionary转化成self class 对象
 @param keyedValues properties keys and values
 */
- (void)setValuesForKeysAutoObjectWithDictionary:(NSDictionary<NSString *,id> *)keyedValues;

/**
 动态属性推荐的设置方式
 */
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues;

/**
  动态属性推荐的设置方式
 */
- (void)setValue:(nullable id)value forKey:(NSString *)key;

- (NSArray *)runtimeProperties;

@end








