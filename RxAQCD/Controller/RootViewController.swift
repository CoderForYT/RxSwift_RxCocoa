//
//  RootViewController.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/2/5.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class RootViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RootModel>>(configureCell: { (sectionModel, tableView, indexPath, model) -> UITableViewCell in
        let cell = RootTableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.model = model
        return cell
    })
    let viewModel = RootViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getNewData().bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)

// 方法1：
        tableView.rx.itemSelected.map { indexPath in
            return (indexPath, self.dataSource[indexPath.row])
            }.subscribe(onNext: { indexPath, model in
                print("click:--------> \(indexPath.row), \(model)")
            }).disposed(by: disposeBag)
// 方法2：
//        tableView.rx.modelSelected(RootModel.self).subscribe { (model) in
//            print("click:--------> \(model)")
//        }.disposed(by: disposeBag)
    }
}


