//
//  APIManager.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/2/5.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Moya

enum APIManager {
    case News
}

extension APIManager: TargetType {
    var baseURL: URL {
        return URL(string: "http://api.dantangapp.com")!
    }
    var path: String {
        switch self {
            case .News:
                return "/v2/items"
        }
    }
    
    var method: Method {
        switch self {
        case .News:
            return Method.get
        }
    }
    
    
    var paramters:[String: Any]? {
        switch self {
        case .News:
            return nil
        }
    }
    
    var paramterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return Task.requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
