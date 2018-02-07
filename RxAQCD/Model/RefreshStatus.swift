//
//  RefreshStatus.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/2/6.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation

enum RefreshStatus: Int {
    case InvalidData // 无效的数据
    case DropDownSuccess // 下拉成功
    case PullSuccessHasMoreData // 上拉，还有更多数据
    case PullSuccessNoMoreData // 上拉，没有更多数据
}
