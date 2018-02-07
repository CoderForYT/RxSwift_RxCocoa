//
//  LoginViewModel.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/1/29.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginVIewModel {
    var userNameUsable: Driver<Result>
    let loginButtonEnabled: Driver<Bool>
    let loginResult: Driver<Result>
    
    init(input: (username: Driver<String>, password: Driver<String>, loginTips: Driver<Void>), service: ValidationService) {
        
        userNameUsable = input.username.flatMapLatest{ username in
            return service.loginUserNameValid(username).asDriver(onErrorJustReturn: .failed(message:"链接服务器失败"))
        }
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) {
            ($0, $1)
        }
        
        loginResult = input.loginTips.withLatestFrom(usernameAndPassword).flatMapLatest{ (input)-> Driver<Result> in
            
            return service.login(username: "123", password: "2111").asDriver(onErrorJustReturn: .failed(message: "登录异常"))
        }
        
        loginButtonEnabled = Driver.combineLatest(userNameUsable, input.password) {result, password in
            if !result.isValid && password.count < 6 {
                return false
            } else {
                return true
            }
        }
        
        
    }
}
