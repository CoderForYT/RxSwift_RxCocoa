//
//  RootTableViewCell.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/2/5.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import UIKit

class RootTableViewCell:UITableViewCell {
    
    var model: RootModel? {
        didSet {
            
            guard model != nil else {
                textLabel?.text = ""
                detailTextLabel?.text = ""
                return
            }
            textLabel?.text = model!.name
            detailTextLabel?.text = String(describing: model!.age)
        }
    }
}
