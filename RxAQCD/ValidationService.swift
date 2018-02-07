//
//  ValidationService.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/1/26.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ValidationService {
    let filePath = NSHomeDirectory() + "/Documents/users.plist"
    static let instance = ValidationService()
    private init() {}
    let minCharactersCount = 6
    
    
    
    func userDict() -> NSDictionary {
        var userDic = NSDictionary(contentsOfFile: filePath)
        if userDic == nil {
            userDic = NSDictionary.init()
            userDic?.write(toFile: filePath, atomically: true)
        }
        return userDic!
    }
}

// 注册
extension ValidationService {
    /// 因为校验用户名的时候需要联网操作，所以需要返回一个可被监听的对象
    func validateUsername(_ username: String) -> Observable<Result> {
        if username.count == 0 {
            return Observable<Result>.just(.empty)
        }
        if username.count < minCharactersCount {
            return Observable<Result>.just(.failed(message: "号码长度至少6个字符"))
        }
        // 模拟异步网络请求，创建一个被观察者
        return Observable<Result>.create({ (observable) -> Disposable in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                if self.usernameValid(username) {
                    observable.onNext(.failed(message: "账号已存在"))
                    print("----------账号已存在")
                } else {
                    observable.onNext(.ok(message: "用户名可用"))
                    print("----------用户名可用")
                }
            })
            return Disposables.create {}
        })
    }
    
    func validatePassword(password: String) -> Result {
        if password.count == 0 {
            return .empty
        }
        if password.count < minCharactersCount {
            return .failed(message: "密码长度至少6个字符")
        }
        return .ok(message: "密码可用")
    }
    
    func validateRepeatedPassword(_ password: String, repeatedPasswordword: String) -> Result {
        if repeatedPasswordword.lengthOfBytes(using: .utf8) == 0 {
            return .empty
        }
        if repeatedPasswordword == password {
            return .ok(message: "密码可用")
        }
        return .failed(message: "两次密码不一样")
    }
    
    func  usernameValid(_ username:String) -> Bool {
        let userDic = self.userDict()
        let userNameArray = userDic.allKeys as NSArray
        if userNameArray.contains(username){
            return true
        }
        return false
    }
    
    func register(username: String, password: String) -> Observable<Result> {
        return Observable<Result>.create({ (obversable) -> Disposable in
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
                let userDict = self.userDict().mutableCopy() as! NSMutableDictionary
                if userDict.value(forKey: username) == nil {
                    userDict.setValue(password, forKey: username)
                    obversable.onNext(.ok(message: "注册成功"))
                } else {
                    obversable.onNext(.failed(message: "注册失败"))
                }
            }
            return Disposables.create {}
        })
    }
}

// 注册
extension ValidationService {
    func loginUserNameValid(_ username: String) -> Observable<Result> {
        if username.count == 0 {
            return Observable.just(.empty)
        }
        return Observable<Result>.create{ observable -> Disposable in
            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(1), execute: {
                if self.usernameValid(username) {
                    return observable.onNext(.ok(message: "登录成功"))
                }
                return observable.onNext(.failed(message: "用户名不存在"))
            })
            return Disposables.create {}
        }
    }
    
    func login(username: String, password: String) -> Observable<Result> {
        return Observable<Result>.create{ observable -> Disposable in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                if self.usernameValid(username) {
                    return observable.onNext(.ok(message: "登录成功"))
                }
                return observable.onNext(.failed(message: "用户名不存在"))
            })
            return Disposables.create {}
        }
    }
}
