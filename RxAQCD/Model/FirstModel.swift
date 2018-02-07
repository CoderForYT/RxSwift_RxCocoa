//
//  File.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/2/6.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation
import HandyJSON


struct ListModel: HandyJSON {
    var data: ListItemModel?
}

struct ListItemModel: HandyJSON {
    
    var items: [FirstModel]?
}

struct FirstModel: HandyJSON {
    
    var data: DataModel?
}

struct DataModel: HandyJSON {
    
    var cover_image_url: String?
    var description: String?
    var name: String?
}
