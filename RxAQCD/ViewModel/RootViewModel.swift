//
//  RootViewModel.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/2/5.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import RxCocoa
import Moya
import HandyJSON



struct RootViewModel {
    
    let provider = MoyaProvider<APIManager>()
    let disposeBag = DisposeBag()
    
    func getNewData() -> Observable<[SectionModel<String, RootModel>]> {
        return Observable.create({ (observer) -> Disposable in
            let array = [RootModel(name: "111", age: 10),  RootModel(name: "222", age: 20), RootModel(name: "333", age: 30)]
            let seciont = [SectionModel(model:"", items: array)]
            observer.onNext(seciont)
            observer.onCompleted()
            return Disposables.create()
        })
    }
}




