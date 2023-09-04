//
//  Extensions.swift
//  Undisturbed
//
//  Created by Monica Qiu on 9/1/23.
//

import UIKit

extension UIView {
    
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
    
    func addGradientBackground(colors: [UIColor]) {
        clipsToBounds = true
        let gradientLayer = makeGradientBackground(colors: colors)
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func replaceGradientBackground(colors: [UIColor]) {
        
        guard let originalLayer = self.layer.sublayers?.first else { return }
        
        clipsToBounds = true
        let gradientLayer = makeGradientBackground(colors: colors)
        self.layer.replaceSublayer(originalLayer, with: gradientLayer)
    }
    
    private func makeGradientBackground(colors: [UIColor]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .radial
        gradientLayer.colors = colors.compactMap({ $0.cgColor })
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: Double.random(in: 0.4...0.6), y: Double.random(in: 0.4...0.6))
        gradientLayer.endPoint = CGPoint(x: 1.8, y: 1.8)
        return gradientLayer
    }
    
}
