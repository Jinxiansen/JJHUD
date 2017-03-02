//
//  ViewController.swift
//  JJHUD
//
//  Created by 晋先森 on 17/2/28.
//  Copyright © 2017年 晋先森. All rights reserved.
//


import UIKit

class PatternView: UIView {
    
    var color: UIColor = UIColor.black {
        didSet {
            self.updatePattern(animated: false)
        }
    }
    var cellWidthFactor: CGFloat = 0.2 {
        didSet {
            self.updatePattern(animated: false)
        }
    }
    var cellWidthMin: CGFloat = 50 {
        didSet {
            self.updatePattern(animated: false)
        }
    }
    var cellWidthMax: CGFloat? {
        didSet {
            self.updatePattern(animated: false)
        }
    }
    var pattern: UIBezierPath? {
        didSet {
            self.updatePattern(animated: false)
        }
    }

    func setRhombusPattern() {
        self.pattern = rhombus()
    }
    
    private func setPattren() {
        if let pattern = self.pattern {
            var newWidth = self.frame.width * self.cellWidthFactor
            if newWidth < self.cellWidthMin {
                newWidth = self.cellWidthMin
            }
            if self.cellWidthMax != nil {
                if newWidth > self.cellWidthMax! {
                    newWidth = self.cellWidthMax!
                }
            }
            let patternBezierPath = pattern
            patternBezierPath.resizeTo(width: newWidth)
            let patternImage = patternBezierPath.convertToImage(fill: false, stroke: true, color: self.color)
            self.backgroundColor = UIColor.init(patternImage: patternImage)
        }
    }

    
    func updatePattern(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.setPattren()
            })
        } else {
            self.setPattren()
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    init(pattern: UIBezierPath) {
        super.init(frame: CGRect.zero)
        self.pattern = pattern
        self.updatePattern(animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updatePattern(animated: true)
    }

    public func rhombus(color: UIColor = .white) -> UIBezierPath {
        let strokeColor = color
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 72.67, y: 49.96))
        bezierPath.addLine(to: CGPoint(x: 44, y: 49.96))
        bezierPath.addLine(to: CGPoint(x: 58.19, y: 25.11))
        bezierPath.addLine(to: CGPoint(x: 44, y: 0.27))
        bezierPath.addLine(to: CGPoint(x: 72.67, y: 0.27))
        bezierPath.addLine(to: CGPoint(x: 87, y: 25.11))
        bezierPath.addLine(to: CGPoint(x: 72.67, y: 49.96))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 15.33, y: 0.27))
        bezierPath.addLine(to: CGPoint(x: 44, y: 0.27))
        bezierPath.addLine(to: CGPoint(x: 29.81, y: 25.11))
        bezierPath.addLine(to: CGPoint(x: 44, y: 49.96))
        bezierPath.addLine(to: CGPoint(x: 15.33, y: 49.96))
        bezierPath.addLine(to: CGPoint(x: 1, y: 25.11))
        bezierPath.addLine(to: CGPoint(x: 15.33, y: 0.27))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 1, y: 25))
        bezierPath.addLine(to: CGPoint(x: 30, y: 25))
        bezierPath.addLine(to: CGPoint(x: 1, y: 25))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 58, y: 25))
        bezierPath.addLine(to: CGPoint(x: 87, y: 25))
        bezierPath.addLine(to: CGPoint(x: 58, y: 25))
        bezierPath.close()
        strokeColor.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.lineCapStyle = .square
        bezierPath.stroke()
        return bezierPath
    }
}


extension UIBezierPath {


    func resizeTo(width: CGFloat) {
        let currentWidth = self.bounds.width
        let relativeFactor = width / currentWidth
        self.apply(CGAffineTransform(scaleX: relativeFactor, y: relativeFactor))
    }

    func convertToImage(fill: Bool, stroke: Bool, color: UIColor = .white) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.bounds.width, height: self.bounds.height), false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        if let context = context {
            context.setStrokeColor(color.cgColor)
            context.setFillColor(color.cgColor)
        } else {

        }
        if stroke {
            self.stroke()
        }
        if fill {
            self.fill()
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = image {
            return image
        }else {
            return UIImage()
        }
    }
}


