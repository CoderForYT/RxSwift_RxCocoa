//
//  FirstViewModel.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/2/6.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import Moya
import HandyJSON

class BaseViewModel: NSObject {
    let provide = MoyaProvider<APIManager>()
    var disposeBag = DisposeBag()
    var refreshStatus = Variable(RefreshStatus.InvalidData)
    var loadData = PublishSubject<Int>()
    var dataSource = [SectionModel<String, DataModel>]()
    var result: Observable<[SectionModel<String, DataModel>]>?
    var page: Int = 1
}

class FirstViewModel: BaseViewModel {
    
    var dataArray = Variable([SectionModel<String, FirstModel>]())
    
    func getNewsData(completed: @escaping(_ model: ListModel?) ->()) {
        provide.rx.request(.News).asObservable().mapModel(ListModel.self).subscribe(onNext: { model in
            completed(model)
        }).disposed(by: disposeBag)
    }
}

