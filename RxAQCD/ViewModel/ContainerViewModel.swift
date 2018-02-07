//
//  ContainerViewModel.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/1/29.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ContainerViewModel {
    var models: Driver<[Hero]>
    init(withSearchText searchText: Observable<String>, service: SearchService) {
        models = searchText.observeOn(ConcurrentMainScheduler.instance).flatMap({ text in
            return service.getHeros(WithName: text);
        }).asDriver(onErrorJustReturn: [])
    }
}

