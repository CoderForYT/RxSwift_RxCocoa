//
//  FirstViewController.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/2/6.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources



class FirstViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = FirstViewModel()

    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, FirstModel>>(configureCell: { (dataSource, tableView, indexPath, model) -> UITableViewCell in
        let cell = FirstTableViewCell(style: .default, reuseIdentifier: "FirstTableViewCell")
        cell.model = model.data
        return cell
    })
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getNewsData { (model) in
            self.viewModel.dataArray.value = [SectionModel(model: "", items: (model?.data!.items)!)]
        }
        viewModel.dataArray.asObservable().bind(to: self.tableView.rx.items(dataSource: self.dataSource)).disposed(by: disposeBag);
        tableView.rx.modelSelected(FirstModel.self).subscribe(onNext: { (model) in
            print("")
            
        }).disposed(by: disposeBag)
    }
}
