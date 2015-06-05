//
//  ViewController.swift
//  Fighter
//
//  Created by 天池邵 on 15/6/5.
//  Copyright (c) 2015年 rainbow. All rights reserved.
//

import UIKit

extension CGPoint {
    func distanceBetweenPoint(point: CGPoint) -> CGFloat {
        let xDist = (point.x - self.x)
        let yDist = (point.y - self.y)
        let distance = sqrt((xDist * xDist) + (yDist * yDist))
        return distance
    }
    
    func angleBetweenPoint(point: CGPoint) -> CGFloat {
        let xDist = (point.x - self.x)
        let yDist = (point.y - self.y)
        return xDist / yDist
    }
}

class ViewController: UIViewController {

    var target: UIView?
    var fighter: UIView?
    var timer: NSTimer!
    var tick = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetTargetToView()
        self.start()
        self.addAFighter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetTargetToView() {
        if target == nil {
            target = UIView(frame: CGRectMake(CGRectGetWidth(self.view.frame) / 2.0, CGRectGetHeight(self.view.frame) - 20, 10, 10))
            target?.backgroundColor = UIColor.redColor()
            target?.layer.masksToBounds = true
            target?.layer.cornerRadius = 5
        } else {
            target?.frame = CGRectMake(CGRectGetWidth(self.view.frame) / 2.0, CGRectGetHeight(self.view.frame) - 20, 10, 10);
        }
        self.view.addSubview(target!)
    }
    
    func addAFighter() {
        fighter = UIView(frame: CGRectMake(CGRectGetWidth(self.view.frame) / 2.0 - 50, CGRectGetHeight(self.view.frame) / 2.0 - 2, 4, 4))
        fighter?.backgroundColor = UIColor.greenColor()
        fighter?.layer.masksToBounds = true
        fighter?.layer.cornerRadius = 2
        self.view.addSubview(fighter!)
    }
    
    func start() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0 / 60.0, target: self, selector: "timerTick", userInfo: nil, repeats: true)
    }
    
    func timerTick () {
        tick++
        let targetSpeed = -CGRectGetHeight(self.view.frame) / 10000.0
        let fighterSpeed = 3 * targetSpeed
        target?.frame = CGRectOffset(target!.frame, 0, targetSpeed);
        if fighter == nil {
            return
        }
        
        let c_center = CGPointMake(CGRectGetWidth(self.view.frame) / 2.0 - 40, CGRectGetHeight(self.view.frame) / 2.0 - 2)
        
        let center = fighter!.center
        println(center)
        println((center.y - c_center.y) / 10)
        println(asin(center.y / 10))
        let angle = Double(asin(center.y / 10))
        println(angle)
        let y = CGFloat(10 * sin((3 * M_PI / 180.0) + angle) - Double(center.y))
        let x = CGFloat(10 * cos((3 * M_PI / 180.0) + angle) - Double(center.x))
        println("\(x) \(y)")
        fighter?.frame = CGRectOffset(fighter!.frame, -x, y)
//        let distance = fighter!.center.distanceBetweenPoint(target!.center)
//        if distance > 10 {
//            let angle = fighter!.center.angleBetweenPoint(target!.center)
//            fighter?.frame = CGRectOffset(fighter!.frame, -fighterSpeed, -fighterSpeed / angle)
//        } else {
//            println("start criterium")
//            fighter?.frame = CGRectOffset(fighter!.frame, 0, targetSpeed)
//            let y = CGFloat(10 * sin(3 * M_PI / 180.0))
//            let x = CGFloat(10 * cos(3 * M_PI / 180.0))
//            println("\(x) \(y)")
//            fighter?.frame = CGRectOffset(fighter!.frame, -x, y)
//        }
    }
}

