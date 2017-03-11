//
//  JJHUD.swift
//  JJHUD
//
//  Created by 晋先森 on 17/2/28.
//  Copyright © 2017年 晋先森. All rights reserved.
//

import UIKit

private let delayTime : TimeInterval = 1.5
private let padding : CGFloat = 10
private let cornerRadius : CGFloat = 13.0
private let imageWidth_Height : CGFloat = 36

private let textFont = UIFont.systemFont(ofSize: 13)

private let keyWindow = UIApplication.shared.keyWindow!

private let JIdentifier = "JScreenView"

enum JJHUDType {
    case success // image + text
    case error   // image + text
    case info    // image + text
    case loading // image // 禁止交互
    case text    // text
}


public class JJHUD:UIView {

    private var delay : TimeInterval = delayTime
    private var imageView :UIImageView?
    private var activityView : UIActivityIndicatorView?
    private var type : JJHUDType?
    private var text : String?
    private var selfWidth:CGFloat = 90
    private var selfHeight:CGFloat = 90
    private var screenView : UIView?

    init(text:String?,type:JJHUDType,delay:TimeInterval) {
        self.delay = delay
        self.text = text
        self.type = type

        super.init(frame: CGRect(origin: CGPoint.zero,
                                   size: CGSize(width: selfWidth,
                                                height: selfWidth)))
        config()
    }

    private func config() {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.layer.cornerRadius = cornerRadius

        if text != nil {
            selfWidth = 110
        }

        guard let type = type else { return }
        switch type {
        case .success:
            addImageView(image: JJHUDImage.imageOfSuccess)
        case .error:
            addImageView(image: JJHUDImage.imageOfError)
        case .info:
            addImageView(image: JJHUDImage.imageOfInfo)
        case .loading:
            addActivityView()
        case .text:
            break
        }

        addLabel()
        addSelfToKeyWindow()
    }

    private func addSelfToKeyWindow() {
        guard self.superview == nil else { return }
        keyWindow.addSubview(self)
        self.alpha = 0

        addConstraint(width: selfWidth, height: selfHeight) //
        keyWindow.addConstraint(toCenterX: self, constantx: 0, toCenterY: self, constanty: -50)

        if type == .loading { // loading 状态加 View 遮挡，不可交互。
            screenView = UIView(frame: UIScreen.main.bounds)
            screenView?.backgroundColor = UIColor.brown.withAlphaComponent(0.1)
            screenView?.restorationIdentifier = JIdentifier
            screenView?.isUserInteractionEnabled = true
            keyWindow.addSubview(screenView!)
        }

    }

    private func addLabel() {

        var labelY:CGFloat = 0.0
        if type == .text {
            labelY = padding
        } else {
            labelY = padding * 2 + imageWidth_Height
        }
        if let text = text {
            textLabel.text = text
            addSubview(textLabel)

            addConstraint(to: textLabel,
                          edageInset: UIEdgeInsets(top: labelY,
                                                   left: padding/2,
                                                   bottom: -padding,
                                                   right: -padding/2))
            let textSize:CGSize = size(from: text)
            selfHeight = textSize.height + labelY + padding + 2
        }
    }

    private func size(from text:String) -> CGSize {
       return text.textSizeWithFont(font: textFont,
                                         constrainedToSize:
            CGSize(width:selfWidth - padding, height:CGFloat(MAXFLOAT)))
    }

    private func addImageView(image:UIImage) {

        imageView = UIImageView(image: image)
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView!)

        generalConstraint(at: imageView!)
    }

    private func addActivityView() {
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView?.translatesAutoresizingMaskIntoConstraints = false
        activityView?.startAnimating()
        addSubview(activityView!)

        generalConstraint(at: activityView!)
    }

    private func generalConstraint(at view:UIView) {

        view.addConstraint(width: imageWidth_Height,
                                    height: imageWidth_Height)
        if let _ = text {
            addConstraint(toCenterX: view, toCenterY: nil)
            addConstraint(with: view,
                          topView: self,
                          leftView: nil,
                          bottomView: nil,
                          rightView: nil,
                          edgeInset: UIEdgeInsets(top: padding, left: 0, bottom: 0, right: 0))
        } else {
            addConstraint(toCenterX: view, toCenterY: view)
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // TODO: Show func
    public static func showSuccess(text:String?,delay:TimeInterval) {
        JJHUD(text: text, type: .success, delay: delay).show()
    }

    public static func showError(text:String?,delay:TimeInterval) {
        JJHUD(text: text, type: .error, delay: delay).show()
    }

    public static func showLoading() {
        JJHUD(text: nil,type:.loading,delay: 0).show()
    }

    public static func showLoading(text:String?) {
        JJHUD(text: text,type:.loading,delay: 0).show()
    }

    public static func showInfo(text:String?,delay:TimeInterval) {
        JJHUD(text: text, type: .info, delay: delay).show()
    }

    public static func showText(text:String?,delay:TimeInterval) {
        JJHUD(text: text,type:.text,delay: delay).show()
    }

    public func show() {
        self.animate(hide: false) { 
            if self.delay > 0 {
                JJHUD.asyncAfter(duration: self.delay, completion: {
                    self.hide()
                })
            }
        }
    }

    //MARK: Hide func
    public func hide() {
        self.animate(hide: true, completion: {
            self.removeFromSuperview()
            self.screenView?.removeFromSuperview()
        })
    }

    public func hide(delay:TimeInterval = delayTime) {
        JJHUD.asyncAfter(duration: delay) {
            self.hide()
        }
    }

    public static func hide() {
        for view in keyWindow.subviews {
            if view.isKind(of:self) {
                view.animate(hide: true, completion: { 
                    view.removeFromSuperview()
                })
            }
            if view.restorationIdentifier == JIdentifier {
                view.removeFromSuperview()
            }
        }
    }

    public static func hide(delay:TimeInterval = delayTime) {
        asyncAfter(duration: delay) {
            hide()
        }
    }

    private lazy var textLabel:UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor.white
        $0.font = textFont
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())

}

//TODO: Extension String
extension String {

   fileprivate func textSizeWithFont(font: UIFont,
                                     constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        if size.equalTo(CGSize.zero) {
            let attributes = NSDictionary(object: font,
                                          forKey: NSFontAttributeName as NSCopying)
            textSize = self.size(attributes: attributes as? [String : AnyObject])
        } else {
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let attributes = NSDictionary(object: font,
                                          forKey: NSFontAttributeName as NSCopying)

            let stringRect = self.boundingRect(with: size,
                                               options: option,
                                               attributes: attributes as? [String : AnyObject],
                                               context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}
//TODO: Extension JJHUD
extension JJHUD {

    fileprivate class func asyncAfter(duration:TimeInterval,
                                completion:(() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration,
                                      execute: {
            completion?()
        })
    }
}

//TODO: Extension UIView
extension UIView {
    fileprivate func animate(hide:Bool,
                             completion:(() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3,
                       animations: {
            if hide {
                self.alpha = 0
            }else {
                self.alpha = 1
            }
        }) { _ in
            completion?()
        }
    }
}

//MARK: Class JJHUDImage
private class JJHUDImage {
    fileprivate struct HUD {
        static var imageOfSuccess: UIImage?
        static var imageOfError: UIImage?
        static var imageOfInfo: UIImage?
    }

    fileprivate class func draw(_ type: JJHUDType) {
        let checkmarkShapePath = UIBezierPath()

        checkmarkShapePath.move(to: CGPoint(x: 36, y: 18))
        checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 18),
                                  radius: 17.5,
                                  startAngle: 0,
                                  endAngle: CGFloat(M_PI*2),
                                  clockwise: true)
        checkmarkShapePath.close()

        switch type {
        case .success:
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.addLine(to: CGPoint(x: 16, y: 24))
            checkmarkShapePath.addLine(to: CGPoint(x: 27, y: 13))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.close()
        case .error:
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 26))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 26))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 10))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.close()
        case .info:
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.addLine(to: CGPoint(x: 18, y: 22))
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.close()

            UIColor.white.setStroke()
            checkmarkShapePath.stroke()
            let checkmarkShapePath = UIBezierPath()
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 27))
            checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 27),
                                      radius: 1,
                                      startAngle: 0,
                                      endAngle: CGFloat(M_PI*2),
                                      clockwise: true)
            checkmarkShapePath.close()

            UIColor.white.setFill()
            checkmarkShapePath.fill()
        case .loading:
            break
        case .text:
            break
        }

        UIColor.white.setStroke()
        checkmarkShapePath.stroke()
    }

    fileprivate static var imageOfSuccess :UIImage {

        guard HUD.imageOfSuccess == nil else { return HUD.imageOfSuccess! }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth_Height,
                                                     height: imageWidth_Height),
                                                     false, 0)
        JJHUDImage.draw(.success)
        HUD.imageOfSuccess = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return HUD.imageOfSuccess!
    }

    fileprivate static var imageOfError : UIImage {

        guard HUD.imageOfError == nil else { return HUD.imageOfError! }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth_Height,
                                                     height: imageWidth_Height),
                                                     false, 0)
        JJHUDImage.draw(.error)
        HUD.imageOfError = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return HUD.imageOfError!
    }

    fileprivate static var imageOfInfo : UIImage {

       guard HUD.imageOfInfo == nil else { return HUD.imageOfInfo! }
       UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth_Height,
                                                    height: imageWidth_Height),
                                                    false, 0)
       JJHUDImage.draw(.info)
       HUD.imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       return HUD.imageOfInfo!
    }

}

//TODO: Extension UIView
extension UIView {

    fileprivate func addConstraint(width: CGFloat,height:CGFloat) {
        if width>0 {
            addConstraint(NSLayoutConstraint(item: self,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: NSLayoutAttribute(rawValue: 0)!,
                                             multiplier: 1,
                                             constant: width))
        }
        if height>0 {
            addConstraint(NSLayoutConstraint(item: self,
                                             attribute: .height,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: NSLayoutAttribute(rawValue: 0)!,
                                             multiplier: 1,
                                             constant: height))
        }
    }

    fileprivate func addConstraint(toCenterX xView:UIView?,toCenterY yView:UIView?) {
        addConstraint(toCenterX: xView, constantx: 0, toCenterY: yView, constanty: 0)
    }

    func addConstraint(toCenterX xView:UIView?,
                       constantx:CGFloat,
                       toCenterY yView:UIView?,
                       constanty:CGFloat) {
        if let xView = xView {
            addConstraint(NSLayoutConstraint(item: xView,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .centerX,
                                             multiplier: 1, constant: constantx))
        }
        if let yView = yView {
            addConstraint(NSLayoutConstraint(item: yView,
                                             attribute: .centerY,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .centerY,
                                             multiplier: 1,
                                             constant: constanty))
        }
    }

    fileprivate func addConstraint(to view:UIView,edageInset:UIEdgeInsets) {
         addConstraint(with: view,
                       topView: self,
                       leftView: self,
                       bottomView: self,
                       rightView: self,
                       edgeInset: edageInset)
    }

    fileprivate func addConstraint(with view:UIView,
                       topView:UIView?,
                       leftView:UIView?,
                       bottomView:UIView?,
                       rightView:UIView?,
                       edgeInset:UIEdgeInsets) {
        if let topView = topView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .top,
                                             relatedBy: .equal,
                                             toItem: topView,
                                             attribute: .top,
                                             multiplier: 1,
                                             constant: edgeInset.top))
        }
        if let leftView = leftView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .left,
                                             relatedBy: .equal,
                                             toItem: leftView,
                                             attribute: .left,
                                             multiplier: 1,
                                             constant: edgeInset.left))
        }
        if let bottomView = bottomView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: bottomView,
                                             attribute: .bottom,
                                             multiplier: 1,
                                             constant: edgeInset.bottom))
        }
        if let rightView = rightView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .right,
                                             relatedBy: .equal,
                                             toItem: rightView,
                                             attribute: .right,
                                             multiplier: 1,
                                             constant: edgeInset.right))
        }
    }
}

















