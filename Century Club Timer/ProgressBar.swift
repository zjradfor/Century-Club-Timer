//
//  ProgressBar.swift
//  Century Club Timer
//
//  Created by Zach Radford on 2019-12-07.
//  Copyright © 2019 Zach Radford. All rights reserved.
//

import UIKit

class ProgressBar: UIView, CAAnimationDelegate {
    fileprivate var animation = CABasicAnimation()
    fileprivate var animationDidStart = false
    fileprivate var timerDuration = 0
    
    lazy var fgProgressLayer: CAShapeLayer = {
        let fgProgressLayer = CAShapeLayer()
        return fgProgressLayer
    }()
    
    lazy var bgProgressLayer: CAShapeLayer = {
        let bgProgressLayer = CAShapeLayer()
        return bgProgressLayer
    }()
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadBgProgressBar()
        loadFgProgressBar()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadBgProgressBar()
        loadFgProgressBar()
    }
    
    
    fileprivate func loadFgProgressBar() {
        
        let startAngle = CGFloat(-Double.pi / 2)
        let endAngle = CGFloat(3 * Double.pi / 2)
        let centerPoint = CGPoint(x: frame.width/2 , y: frame.height/2)
        let gradientMaskLayer = gradientMask()
        fgProgressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: frame.width/2 - 30.0, startAngle:startAngle, endAngle:endAngle, clockwise: true).cgPath
        fgProgressLayer.backgroundColor = UIColor.clear.cgColor
        fgProgressLayer.fillColor = nil
        fgProgressLayer.strokeColor = UIColor.black.cgColor
        fgProgressLayer.lineWidth = 4.0
        fgProgressLayer.strokeStart = 0.0
        fgProgressLayer.strokeEnd = 0.0
        
        gradientMaskLayer.mask = fgProgressLayer
        layer.addSublayer(gradientMaskLayer)
    }
    
    
    
    fileprivate func gradientMask() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.locations = [0.0, 1.0]
        let colorTop: AnyObject = CustomColor.lime.cgColor
        let colorBottom: AnyObject = CustomColor.summerSky.cgColor
        let arrayOfColors: [AnyObject] = [colorTop, colorBottom]
        gradientLayer.colors = arrayOfColors
        
        return gradientLayer
    }
    
    
    fileprivate func loadBgProgressBar() {
        
        let startAngle = CGFloat(-Double.pi / 2)
        let endAngle = CGFloat(3 * Double.pi / 2)
        let centerPoint = CGPoint(x: frame.width/2 , y: frame.height/2)
        let gradientMaskLayer = gradientMaskBg()
        bgProgressLayer.path = UIBezierPath(arcCenter:centerPoint, radius: frame.width/2 - 30.0, startAngle:startAngle, endAngle:endAngle, clockwise: true).cgPath
        bgProgressLayer.backgroundColor = UIColor.clear.cgColor
        bgProgressLayer.fillColor = nil
        bgProgressLayer.strokeColor = UIColor.black.cgColor
        bgProgressLayer.lineWidth = 4.0
        bgProgressLayer.strokeStart = 0.0
        bgProgressLayer.strokeEnd = 1.0
        
        gradientMaskLayer.mask = bgProgressLayer
        layer.addSublayer(gradientMaskLayer)
    }
    
    
    fileprivate func gradientMaskBg() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.locations = [0.0, 1.0]
        let colorTop: AnyObject = CustomColor.flipside.cgColor
        let colorBottom: AnyObject = CustomColor.flipside.cgColor
        let arrayOfColors: [AnyObject] = [colorTop, colorBottom]
        gradientLayer.colors = arrayOfColors
        
        return gradientLayer
    }
    
    
    public func setProgressBar(hours:Int, minutes:Int, seconds:Int) {
        let hoursToSeconds = hours * 3600
        let minutesToSeconds = minutes * 60
        let totalSeconds = seconds + minutesToSeconds + hoursToSeconds
        timerDuration = totalSeconds
    }
    
    public func start() {
        if !animationDidStart {
            startAnimation()
        }else{
            resumeAnimation()
        }
    }
    
    public func pause() {
        pauseAnimation()
    }
    
    public func stop() {
        stopAnimation()
    }
    
    
    fileprivate func startAnimation() {
        
        resetAnimation()
        
        fgProgressLayer.strokeEnd = 0.0
        animation.keyPath = "strokeEnd"
        animation.fromValue = CGFloat(0.0)
        animation.toValue = CGFloat(1.0)
        animation.duration = CFTimeInterval(timerDuration)
        animation.delegate = self
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        fgProgressLayer.add(animation, forKey: "strokeEnd")
        animationDidStart = true
        
    }
    
    
    fileprivate func resetAnimation() {
        fgProgressLayer.speed = 1.0
        fgProgressLayer.timeOffset = 0.0
        fgProgressLayer.beginTime = 0.0
        fgProgressLayer.strokeEnd = 0.0
        animationDidStart = false
    }
    
    
    fileprivate func stopAnimation() {
        fgProgressLayer.speed = 1.0
        fgProgressLayer.timeOffset = 0.0
        fgProgressLayer.beginTime = 0.0
        fgProgressLayer.strokeEnd = 0.0
        fgProgressLayer.removeAllAnimations()
        animationDidStart = false
    }
    
    
    fileprivate func pauseAnimation(){
        let pausedTime = fgProgressLayer.convertTime(CACurrentMediaTime(), from: nil)
        fgProgressLayer.speed = 0.0
        fgProgressLayer.timeOffset = pausedTime
        
    }
    
    
    fileprivate func resumeAnimation(){
        let pausedTime = fgProgressLayer.timeOffset
        fgProgressLayer.speed = 1.0
        fgProgressLayer.timeOffset = 0.0
        fgProgressLayer.beginTime = 0.0
        let timeSincePause = fgProgressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        fgProgressLayer.beginTime = timeSincePause
    }
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        stopAnimation()
    }
}

struct CustomColor {
    //UIColor is a website used to convert HEX & RGB colors to UIColor for both Objective-C and Swift featuring a colorpicker and copy to clipboard functionality making things easier. http://uicolor.xyz/#/hex-to-ui
    
    static let flipside = UIColor(red:0.09, green:0.10, blue:0.11, alpha:1.0)
    static let aquaBlue = UIColor(red:0.00, green:0.50, blue:1.00, alpha:1.0)
    static let snow = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    static let tungsten = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
    static let strawberry = UIColor(red:0.999, green:0.184, blue:0.572, alpha:1.0)
    static let blackTranslucent = UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.1)
    static let black = UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0)
    static let red = UIColor(red:1.00, green:0.00, blue:0.00, alpha:1.0)
    static let groupTable = UIColor(red:0.92, green:0.92, blue:0.95, alpha:1.0)
    
    static let lime = UIColor(red:0.00, green:1.00, blue:0.00, alpha:1.0)
    static let lemon = UIColor(red:1.00, green:1.00, blue:0.00, alpha:1.0)
    static let summerSky = UIColor(red:0.00, green:0.68, blue:1.00, alpha:1.0)
    
}
