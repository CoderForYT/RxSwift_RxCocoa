//
//  ObservableType+Model.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/2/6.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation
import RxSwift
import HandyJSON
import Moya


extension Observable where E == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T>{
        return flatMap({ (response) -> Observable<T> in
            return Observable<T>.just(response.mapModel(T.self))
        })
    }
}

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString!)!
    }
}

