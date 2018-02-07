//
//  FirstTableViewCell.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/2/6.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    var model: DataModel? {
        didSet {
            textLabel?.text = model?.name
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
