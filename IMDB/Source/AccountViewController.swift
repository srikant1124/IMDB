//
//  AccountViewController.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/7/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    var viewModel = AccountViewModel()
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var networkError: NotificationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signOut(_ sender: UIButton) {
        enableSignOut()
        viewModel.sginOut { result in
            self.enableSignOut(true)
            switch result {
            case .success:
                self.showLoginScreen()
            case .failure(let error):
                self.showNetworkError(message: error.localizedDescription)
            }
        }
    }
    
    func showNetworkError(message: String) {
        DispatchQueue.main.async {
            self.networkError.text.text = message
            self.networkError.isHidden = false
        }
    }
    
    func enableSignOut(_ result: Bool = false) {
        signOutButton.isEnabled = result
        signOutButton.alpha = result ? 1 : 0.5
    }
    
    func showLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let signVc = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {
            return
        }
        self.parent?.navigationController?.viewControllers = [signVc]
    }
}
