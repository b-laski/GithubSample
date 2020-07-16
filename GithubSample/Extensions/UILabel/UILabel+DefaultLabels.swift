//
//  UILabel+DefaultLabels.swift
//  GithubSample
//
//  Created by Bartłomiej Łaski on 13/07/2020.
//

import UIKit

extension UILabel {
    static private func newInstance(font: UIFont, textAlignment: NSTextAlignment = .natural) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.tintColor = .black
        label.font = font
        label.textAlignment = textAlignment
        return label
    }
    
    static var bold18: UILabel {
        return newInstance(font: .boldSystemFont(ofSize: 18))
    }
    
    static var centerBold32: UILabel {
        return newInstance(font: .boldSystemFont(ofSize: 32), textAlignment: .center)
    }
    
    static var light12: UILabel {
        return newInstance(font: .systemFont(ofSize: 12, weight: .light))
    }
    
    static var regular18: UILabel {
        return newInstance(font: .systemFont(ofSize: 16))
    }
    
}
