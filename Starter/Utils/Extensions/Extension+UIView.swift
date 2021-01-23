//
//  Extension+UIView.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

extension UIView {
    /// Round
    func rounded() {
        circularEdges()
        customizeBorderColor(color: UIColor.white)
    }
    
    /// Round edge
    func roundedEdges() {
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
    /// Circle edge
    func circularEdges() {
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
    
    /// Custom border color
    func customizeBorderColor(color: UIColor) {
        layer.borderWidth = 2
        layer.borderColor = color.cgColor
    }
    
    /// Custom border color radius
    func customizeBorderColorRadius(color: UIColor, radius: CGFloat, borderWidth: CGFloat = 1) {
        layer.cornerRadius = radius
        layer.borderWidth = borderWidth
        layer.borderColor = color.cgColor
    }
    
    /// Round corners
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// Reset corner and border
    func resetCornerAndBorder() {
        layer.cornerRadius = 0
        layer.borderWidth = 0
        layer.borderColor = nil
    }
    
    /// Drop a shadow
    func dropShadow(shadowOffset: CGSize = CGSize(width: 0, height: 1.0),
                    shadowRadius: CGFloat = 1.0,
                    shadowOpacity: Float = 0.5) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.masksToBounds = false
    }
    
    /// Dashed border
    func addDashedBorder() {
        let color = UIColor.black.cgColor
        
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.masksToBounds = true
        self.layer.addSublayer(shapeLayer)
    }
    
    /// Single dashed line
    func singleDashedLine(start point: CGPoint = CGPoint(x: 0, y: 0),
                          width value: CGFloat,
                          end pointY: CGPoint = CGPoint(x: 0, y: 0),
                          color: UIColor = .white) {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        /// 5 is the length of dash, 3 is length of the gap.
        shapeLayer.lineDashPattern = [5, 3]

        let path = CGMutablePath()
        let widthPoint = CGPoint(x: value, y: pointY.y)
        
        path.addLines(between: [point, widthPoint])
        shapeLayer.path = path
        
        self.layer.addSublayer(shapeLayer)
    }
    
    /// Shake animation
    func shake(delegate: CAAnimationDelegate) {
        let animationKeyPath = "transform.translation.x"
        let shakeAnimation = "shake"
        let duration = 0.6
        let animation = CAKeyframeAnimation(keyPath: animationKeyPath)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        animation.delegate = delegate
        layer.add(animation, forKey: shakeAnimation)
    }
    
    /// Load View From Nib
    class func viewFromNibName(_ name: String) -> UIView? {
        let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        return views?.first as? UIView
    }
    
    /// Rotation
    func rotate(degrees: CGFloat) {
        rotate(radians: CGFloat.pi * degrees / 180.0)
    }
    
    private func rotate(radians: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }
}
