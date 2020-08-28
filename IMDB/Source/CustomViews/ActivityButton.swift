//
//  ActivityButton.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/9/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import UIKit

class ActivityButton: CustomButton {
    
    var title = ""
    var activityIndicator = UIActivityIndicatorView(style: .medium)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        addActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        addActivityIndicator()
    }
    
    private func addActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        updateViewConstraints()
    }
    
    func animate() {
        activityIndicator.startAnimating()
        if let title = titleLabel?.text {
            self.title = title
        }
        setTitle("", for: .normal)
        enableButton()
    }
    
    func stopAnimate() {
        activityIndicator.stopAnimating()
        setTitle(self.title, for: .normal)
        enableButton(true)
    }
    
    fileprivate func updateViewConstraints() {
        let constraints = [
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 20),
            activityIndicator.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
        self.setNeedsLayout()
    }
    
}
