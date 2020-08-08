//
//  LoginViewController.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/7/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var viewModel = AccountViewModel()
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordFiled: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var mailErrorLabel: UILabel!
    @IBOutlet weak var networkError: NotificationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }

    @IBAction func doLogin(_ sender: UIButton) {
        view.endEditing(true)
        if viewModel.isValidUserForSignIn {
            enableLoginButton()
            viewModel.doLogin { result in
                self.enableLoginButton(true)
                switch result {
                case .success:
                    self.showTabbar()
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showNetworkError(message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func showNetworkError(message: String) {
         DispatchQueue.main.async {
            self.networkError.text.text = message
             self.networkError.isHidden = false
         }
     }
    
    func showTabbar() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarController = storyBoard.instantiateViewController(identifier: "TabBarViewController") as? TabBarViewController else {
            return
        }
        self.navigationController?.viewControllers = [tabBarController]
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         guard let signupVc = storyBoard.instantiateViewController(identifier: "SignupViewController") as? SignupViewController else {
             return
         }
         self.navigationController?.pushViewController(signupVc, animated: true)
    }
    
   func setupTextField() {
        emailField.addTarget(self, action: #selector(updateTextField), for: .editingChanged)
        passwordFiled.addTarget(self, action: #selector(updateTextField), for: .editingChanged)
    }
    
    @objc
    func updateTextField() {
        if let email = emailField,
            let text = email.text, viewModel.validateAndSetEmailId(text) {
            updateLoginButton()
            mailErrorLabel.isHidden = true
        } else {
            mailErrorLabel.isHidden = false
        }
        if let passord = passwordFiled,
            let text = passord.text {
            viewModel.setPassword(text)
        }
        updateLoginButton()
    }
    
    func updateLoginButton() {
        if viewModel.isValidUserForSignIn {
            enableLoginButton(true)
        } else {
            enableLoginButton()
        }
    }
    
    func enableLoginButton(_ result: Bool = false) {
        loginButton.isEnabled = result
        loginButton.alpha = result ? 1 : 0.5
    }
}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
