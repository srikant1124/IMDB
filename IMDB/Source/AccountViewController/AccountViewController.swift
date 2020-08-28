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
    @IBOutlet weak var signOutButton: ActivityButton!
    @IBOutlet weak var networkError: NotificationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signOut(_ sender: UIButton) {
        signOutButton.animate()
        viewModel.sginOut { result in
            self.signOutButton.stopAnimate()
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
    
    func showLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let signVc = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {
            return
        }
        self.parent?.navigationController?.viewControllers = [signVc]
    }
}
