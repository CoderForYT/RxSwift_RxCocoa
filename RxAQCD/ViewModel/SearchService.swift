//
//  SearchService.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/1/29.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchService {
    static let shareInstance = SearchService()
    
    private init() {}
    
    func getHeros() -> Observable<[Hero]> {
        let herosString = Bundle.main.path(forResource: "heros", ofType: "plist")
        let herosArray = NSArray(contentsOfFile: herosString!) as! Array<[String: String]>
        var heros = [Hero]()
        for heroDic in herosArray {
            let hero = Hero(name: heroDic["name"]!, desc: heroDic["intro"]!, icon: heroDic["icon"]!)
            heros.append(hero)
        }
        return Observable.just(heros)
            .observeOn(MainScheduler.instance)
    }
    
    func getHeros(WithName naem : String) -> Observable<[Hero]> {
        return self.getHeros()
    }
}
