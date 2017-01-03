//
//  AnimationViewController.swift
//  Facebook-Pop
//
//  Created by yueyeqi on 8/13/16.
//  Copyright © 2016 yueyeqi. All rights reserved.
//

import UIKit
import pop

class AnimationViewController: UIViewController {

    var animationType: Int? //动画类型
    var animationView: UIView? = nil //测试view
    var testLabel: UILabel? = nil //测试label
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //初始化view
        animationView = UIView(frame: CGRectMake(0, 0, 50, 50))
        animationView?.center = view.center
        animationView!.backgroundColor = UIColor.blueColor()
        view.addSubview(animationView!)
    }

    @IBAction func beginAction(sender: AnyObject) {
        
        //每次点击begin初始化view的位置大小
        animationView?.layer.pop_removeAllAnimations()
        animationView?.frame = CGRectMake(0, 0, 50, 50)
        animationView?.center = view.center
        
        switch animationType! {
        case 0:
            positionX()
        case 1:
            rotation()
        case 2:
            springPosition()
        case 3:
            scaleXY()
        case 4:
            decayPosition()
        case 5:
            propertyAnimation()
        default:
            break
        }
        
    }
    //移动
    func positionX() {
        let animation = POPBasicAnimation(propertyNamed: kPOPLayerPositionX)
        animation.toValue = NSValue(CGPoint: CGPointMake(100, 200))
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animationView?.layer.pop_addAnimation(animation, forKey: "positionX")
    }
    
    //旋转
    func rotation() {
        
        let animation = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
        animation.toValue = M_PI * 2.0
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animationView?.layer.pop_addAnimation(animation, forKey: "rotation")
        
    }
    
    
    // MARK: - 弹性动画 POPSpringAnimation
    
    //移动
    func springPosition() {
        let animation = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        animation.toValue = NSValue(CGPoint: CGPointMake(100, 200))
        
        animation.springBounciness = 20
        animation.springSpeed = 12
        
        animationView?.layer.pop_addAnimation(animation, forKey: "springPosition")
    }
    
    //放大缩小
    func scaleXY() {
        
        let animation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        animation!.toValue = NSValue(CGSize: CGSizeMake(5, 5))
        
        animation!.springBounciness = 15 //[0-20] 弹力 越大则震动幅度越大
        animation.springSpeed = 15 //[0-20] 速度 越大则动画结束越快
        
        //以下3个与物理力学模拟相关，没特殊需求不建议使用
        //        animation.dynamicsFriction = 0 //拉力
        //        animation.dynamicsFriction = 0 //摩擦
        //        animation.dynamicsMass = 0 //质量
        
        //POPSpringAnimation是没有duration字段的 其动画持续时间由以上几个参数决定
        
        animationView?.layer.pop_addAnimation(animation, forKey: "scaleXY")
    }
    
    // MARK: - 衰减动画 POPDecayAnimation
    
    //移动
    func decayPosition() {
        let animation = POPDecayAnimation(propertyNamed: kPOPLayerPositionX)
        
        animation.velocity = 200 //速度
        animation.deceleration = 0.998 // 衰减系数(越小则衰减得越快)
        
        //目的状态通过velocity和deceleration计算，动态得到
        
        animationView?.layer.pop_addAnimation(animation, forKey: "decayPosition")
    }
    
    // MARK: - 自定义动画 POPAnimatableProperty
    
    func propertyAnimation() {
   
        if (testLabel != nil) {
            testLabel?.removeFromSuperview()
        }
        animationView?.removeFromSuperview()
        
        testLabel = UILabel(frame: CGRectMake(0,0,100,50))
        testLabel!.center = view.center
        view.addSubview(testLabel!)
        
        let prop = POPAnimatableProperty.propertyWithName("Custom") { (prop) in
            prop.writeBlock = {(obj, value) -> Void in
                let lable = obj as! UILabel
                lable.text = String.init(format: "%02d:%02d:%02d", Int(value[0]/60),Int(value[0]%60),Int((value[0]*100)%100))
            }
        }
        
        let anBasic = POPBasicAnimation.linearAnimation()
        anBasic.property = prop as! POPAnimatableProperty
        anBasic.fromValue = 0
        anBasic.toValue = 3*60
        anBasic.duration = 3*60
        testLabel!.pop_addAnimation(anBasic, forKey: "Custom")
    }
    
}
