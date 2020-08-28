//
//  AuthManager.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/8/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import Foundation
import Firebase
typealias AuthResponseHandler = (Swift.Result<Bool, Error>) -> Void
class AuthManager {
    static let share = AuthManager()

    func signup(user: User, completion: @escaping AuthResponseHandler) {
        guard let mailId = user.mailId,
            let password = user.password else {
                return
        }
        Auth.auth().createUser(withEmail: mailId, password: password) { (authResult, error) in
            guard let error = error else {
                completion(.success(true))
                return
            }
            completion(.failure(error))
        }
    }
    
    func login(user: User, completion: @escaping AuthResponseHandler) {
        guard let mailId = user.mailId,
            let password = user.password else {
                return
        }
        Auth.auth().signIn(withEmail: mailId, password: password) { (authResult, error) in
            guard let error = error else {
                completion(.success(true))
                return
            }
            completion(.failure(error))
        }
    }
    
    func signOut(completion: @escaping AuthResponseHandler) {
        do {
            try Auth.auth().signOut()
            completion(.success(true))
        } catch let signOutError as NSError {
            print(signOutError.description)
            completion(.failure(signOutError))
        }
    }
}
