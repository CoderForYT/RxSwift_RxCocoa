//
//  ViewController.swift
//  RxAQCD
//
//  Created by MarkMyLove-Mac on 2018/1/23.
//

import UIKit
import RxCocoa
import RxSwift


class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = RegisterViewModel()
        
        usernameTextField.rx.text.orEmpty.bind(to: viewModel.userName).disposed(by: disposeBag)
        viewModel.usernameUsable.bind(to: usernameLabel.rx.validationResult).disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        viewModel.passwordUsable.bind(to: passwordLabel.rx.validationResult).disposed(by: disposeBag)
        
        repeatPasswordTextField.rx.text.orEmpty.bind(to: viewModel.repeatPassword).disposed(by: disposeBag)
        viewModel.repeatPasswordUsable.bind(to: repeatPasswordLabel.rx.validationResult).disposed(by: disposeBag)
        
        registerButton.rx.tap.bind(to: viewModel.registerTaps).disposed(by: disposeBag)
        
        _ = viewModel.registerButtonEnable.subscribe(onNext: {
            [unowned self] valid in
            self.registerButton.isEnabled = valid
            self.registerButton.alpha = valid ? 1.0 : 0.5
        }).disposed(by: disposeBag)
        
        _ = viewModel.registerResult.subscribe(onNext: {
            [unowned self] result in
            switch result {
            case let .ok(message):
                self.showAlert(message: message)
            case .empty:
                self.showAlert(message: "")
            case let .failed(message):
                self.showAlert(message: message)
            }
        })
    }
}

extension ViewController {
    
    func showAlert(message: String){
        print(message);
    }
    
}


