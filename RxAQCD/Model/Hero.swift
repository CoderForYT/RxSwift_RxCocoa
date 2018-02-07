//
//  Hero.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/1/29.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation

class Hero: NSObject {
    var name: String
    var desc: String
    var icon: String
    
    init(name: String, desc: String, icon: String) {
        self.name = name
        self.desc = desc
        self.icon = icon
    }
}
