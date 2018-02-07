//
//  LoginViewController.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/1/29.
//  Copyright © 2018年 MarkMyLove-Mac. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = LoginVIewModel(input: (username: usernameTextField.rx.text.orEmpty.asDriver(), password: passwordTextField.rx.text.orEmpty.asDriver(), loginTips: loginButton.rx.tap.asDriver()), service: ValidationService.instance)
      
    viewModel.userNameUsable.drive(usernameLabel.rx.validationResult).disposed(by: disposeBag)
        viewModel.loginButtonEnabled.drive(onNext: {
            [unowned self] valid in
            self.loginButton.isEnabled = valid
            self.loginButton.alpha = valid ? 1 : 0.5
        }).disposed(by: disposeBag)
        
        viewModel.loginResult
            .drive(onNext: { [unowned self] result in
                switch result {
                case let .ok(message):
                    self.performSegue(withIdentifier: "container", sender: self)
                    self.showAlert(message: message)
                case .empty:
                    self.showAlert(message: "")
                case let .failed(message):
                    self.showAlert(message: message)
                }
            })
            .disposed(by: disposeBag)
    }
}


extension LoginViewController {
    func showAlert(message: String){
        print(message);
    }
    
}
