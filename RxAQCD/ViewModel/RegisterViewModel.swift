//
//  RegisterViewModel.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/1/26.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class RegisterViewModel {
    let userName = Variable<String>("")
    var usernameUsable: Observable<Result>
    
    let password = Variable<String>("")
    var passwordUsable: Observable<Result>
    
    let repeatPassword = Variable<String>("")
    let repeatPasswordUsable: Observable<Result>
    // 输入
    let registerTaps = PublishSubject<Void>()
    // 输出
    let registerButtonEnable: Observable<Bool>
    let registerResult: Observable<Result>
    
    init() {
        let server = ValidationService.instance
        // 由于校验用户名需要联网操作，通过flatMapLatest 装换成新的流，并取最新的流
        usernameUsable = userName.asObservable().flatMapLatest{name in
            return server.validateUsername(name).observeOn(MainScheduler.instance).catchErrorJustReturn(.failed(message: "username检测出错"))
        }.share(replay: 1, scope: .whileConnected)
        
        // 校验验证码是在本地进行操作，只需要改变内部元素就可以了
        passwordUsable = password.asObservable().map { password in
            return server.validatePassword(password: password)
        }
        // 校验两个变量，可以使用合并留的方式
        repeatPasswordUsable = Observable.combineLatest(password.asObservable(), repeatPassword.asObservable()){
            return server.validateRepeatedPassword($0, repeatedPasswordword: $1)
        }
        
        // 点击按钮是否可用, 返回一个Bool值的流
        // distinctUntilChanged 压缩流
        registerButtonEnable = Observable.combineLatest(usernameUsable, passwordUsable, repeatPasswordUsable) { userNameResult, passwordResult, repeatPasswordResult in
             return userNameResult.isValid && passwordResult.isValid && repeatPasswordResult.isValid
            }.distinctUntilChanged().share(replay: 1, scope: .whileConnected)

        //      获取一个用户名和密码的流
        let usernameAndPassword = Observable.combineLatest(userName.asObservable(), password.asObservable()) {
            ($0, $1)
        }
        
//      withLatestFrom 和另外一个流的最新合并
        registerResult = registerTaps.asObservable().withLatestFrom(usernameAndPassword).flatMapLatest{
            (username, password) in
            return server.register(username: username, password: username)
                        .observeOn(MainScheduler.instance)
                        .catchErrorJustReturn(.failed(message: "注册出错"))
        }.share(replay: 1, scope: .whileConnected)
    }
}
