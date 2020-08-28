//
//  CustomButton.swift
//  IMDB
//
//  Created by Kumar jena, Srikant - Srikant on 8/9/20.
//  Copyright © 2020 Kumar jena, Srikant - Srikant. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        setupProperties()
    }
    
    func setupProperties() {
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 18)
        layer.cornerRadius = frame.size.height / 2
        backgroundColor = UIColor(rgb: 0xF7C800)
    }

    /*func shake() {
        let key = "shake"
        let shake = CABasicAnimation(keyPath: key)
        shake.duration = 0.1
        shake.autoreverses = true
        shake.repeatCount = 2
        let fromPoint = CGPoint(x: self.center.x - 8, y: center.y)
        let toPoint = CGPoint(x: self.center.x + 8, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        self.layer.add(shake, forKey: key)
    }*/
    
    func enableButton(_ result: Bool = false) {
        isEnabled = result
        alpha = result ? 1 : 0.5
    }
}
