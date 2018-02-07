//
//  Protocol.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/1/26.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum Result {
    case ok(message: String)
    case empty
    case failed(message: String)
}

extension Result {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

extension Result {
    var textColor: UIColor {
        switch self {
        case .ok:
            return UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
        case .empty:
            return UIColor.black
        case .failed:
            return UIColor.red
        }
    }
}

extension Result {
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .failed(message):
            return message
        }
    }
}


extension Reactive where Base: UILabel {
    var validationResult: Binder<Result> {
        return Binder<Result>(self.base) { label, result in
            label.text = result.description
            label.textColor = result.textColor
        }
    }
}
