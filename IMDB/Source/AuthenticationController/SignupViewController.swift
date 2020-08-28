//
//  SignupViewController.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/7/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var signupButton: ActivityButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var conformPassword: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorlabel: UILabel!
    
    @IBOutlet weak var networkErrorLabel: UILabel!
    var viewModel = AccountViewModel()
    @IBOutlet weak var networkError: NotificationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    @IBAction func signup(_ sender: UIButton) {
        view.endEditing(true)
        if viewModel.isValidUserForSignUp {
            signupButton.animate()
            viewModel.sginup { result in
                self.signupButton.stopAnimate()
                switch result {
                case .success:
                    self.shomHomeScreen()
                    print("Success")
                case .failure(let error):
                    print(error.localizedDescription)
                    self.showNetworkError(message: error.localizedDescription)
                }
            }
        } else {
            
        }
    }
    
    func shomHomeScreen() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarController = storyBoard.instantiateViewController(identifier: "TabBarViewController") as? TabBarViewController else {
            return
        }
        self.navigationController?.viewControllers = [tabBarController]
    }
    
    func showNetworkError(message: String) {
        DispatchQueue.main.async {
            self.networkErrorLabel.text = message
            self.networkErrorLabel.isHidden = false
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func setupTextField() {
        emailField.addTarget(self, action: #selector(updateTextField), for: .editingChanged)
        password.addTarget(self, action: #selector(updatePasswordField), for: .editingChanged)
        conformPassword.addTarget(self, action: #selector(updateConformPasswordField), for: .editingChanged)
    }
    
    @objc
    func updateTextField() {
        if let email = emailField,
            let text = email.text,
            viewModel.validateAndSetEmailId(text) {
            emailErrorLabel.isHidden = true
        } else {
            emailErrorLabel.isHidden = false
        }
        updateSignUpButton()
    }
    
    @objc
    func updatePasswordField() {
        if let passord = password,
            let text = passord.text {
            viewModel.setPassword(text)
        }
        updateSignUpButton()
    }
    
    @objc
    func updateConformPasswordField() {
        if let passord = conformPassword,
            let text = passord.text,
            viewModel.setConformPassword(text) {
            passwordErrorlabel.isHidden = true
        } else {
            passwordErrorlabel.isHidden = false
        }
        updateSignUpButton()
    }
    
    func updateSignUpButton() {
        if viewModel.isValidUserForSignUp {
            signupButton.enableButton(true)
        } else {
            signupButton.enableButton()
        }
    }
}

extension SignupViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
