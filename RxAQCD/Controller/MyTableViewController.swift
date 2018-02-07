//
//  MyTableViewController.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/1/29.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxDataSources


class MyTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = LQUser.user
        user.age = 29
        user.name = "absc"
        user.paw = "123456"
        user.save()
        
        let user1 = LQUser.user
        print(user1.name)
        
    }
}
