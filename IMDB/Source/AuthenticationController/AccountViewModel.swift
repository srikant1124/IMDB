//
//  UserViewModel.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/8/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import Foundation

class AccountViewModel {
    private var user = User()
    
    var isValidUserForSignIn: Bool {
        guard let mail = user.mailId,
            let password = user.password else {
                return false
        }
        if !mail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        return false
    }
    
    var isValidUserForSignUp: Bool {
        guard let mail = user.mailId,
            let password = user.password,
            let conformPassword = user.conformPassword,
            password == conformPassword else {
                return false
        }
        if !mail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !conformPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return true
        }
        return false
    }
    
    func setFirstName(_ value: String) {
        user.firstName = value
    }
    
    func setSecondName(_ value: String) {
        user.lastName = value
    }
    
    func setPassword(_ value: String) {
        user.password = value
    }
    
    func setConformPassword(_ value: String) -> Bool {
        if value == user.password ?? "" {
            user.conformPassword = value
            return true
        }
        return false
    }
    
    var emailError: String {
        "Please enter a valid mail id"
    }
    
    var passwordMatchingError: String {
        "Passwords are not matching"
    }
    
    func validateAndSetEmailId(_ value: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = predicate.evaluate(with: value)
        user.mailId = result ? value : ""
        return result
    }
    
    func doLogin(completion: @escaping AuthResponseHandler) {
        if isValidUserForSignIn {
            AuthManager.share.login(user: user) { result in
                switch result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        } else {
            
        }
    }
    
    func sginup(completion: @escaping AuthResponseHandler) {
        if isValidUserForSignUp {
            AuthManager.share.signup(user: user) { result in
                switch result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            
        }
    }
    
    func sginOut(completion: @escaping AuthResponseHandler) {
        AuthManager.share.signOut { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

