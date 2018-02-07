//
//  LQUser.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/2/6.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation

class LQUser: NSObject, Codable {
    var name: String = ""
    var age: Int = 0
    var paw = ""
    
    static var user: LQUser {
        let ud = UserDefaults.standard
        guard let data = ud.data(forKey: "lqUser_savedData") else {
            return LQUser()
        }
        guard let us = try? JSONDecoder().decode(self, from: data) else {
            return LQUser()
        }
        return us
    }
    private override init() {
        super.init()
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(self) {
            let us = UserDefaults.standard
            us.set(data, forKey: "lqUser_savedData")
            us.synchronize()
        }
    }
}
