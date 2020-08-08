//
//  NotificationView.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/8/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import UIKit

class NotificationView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var text: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    func setupView() {
        Bundle.main.loadNibNamed("NotificationView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.translatesAutoresizingMaskIntoConstraints = false
        updateViewConstraints(withParentView: contentView)
    }
    
    fileprivate func updateViewConstraints(withParentView view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
        self.setNeedsLayout()
    }
}
