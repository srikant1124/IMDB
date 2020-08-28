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
    @IBOutlet weak var loginButton: ActivityButton!
    @IBOutlet weak var mailErrorLabel: UILabel!
    @IBOutlet weak var networkError: NotificationView!
    @IBOutlet weak var networkErrorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        emailField.text = "srikant@gmail.com"
        passwordFiled.text = "testtest"
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
        view.endEditing(true)
        if viewModel.isValidUserForSignIn {
            loginButton.animate()
            view.isUserInteractionEnabled = false
            viewModel.doLogin { result in
                self.loginButton.stopAnimate()
                self.view.isUserInteractionEnabled = true
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
            self.networkErrorLabel.text = message
            self.networkErrorLabel.isHidden = false
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
            loginButton.enableButton(true)
        } else {
            loginButton.enableButton()
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
