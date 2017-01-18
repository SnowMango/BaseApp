#!/bin/sh

#  pod_install.sh
#  OneApplication
#
#  Created by zhengfeng on 17/1/16.
#  Copyright © 2017年 zhengfeng. All rights reserved.
# 文件为工程快捷更新pod，需要可执行权限，可使用终端：chomd +x 文件绝对路径
cd `dirname $0`
echo `pwd`
pod install
