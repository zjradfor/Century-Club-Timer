//
//  CountdownTimer.swift
//  Century Club Timer
//
//  Created by Zach Radford on 2019-12-07.
//  Copyright © 2019 Zach Radford. All rights reserved.
//

import UIKit

class CountdownTimer {
    
    weak var delegate: CountdownTimerDelegate?
    
    private var defaultTime: Double = 0.0
    private var duration: Double = 0.0
    
    let decrement: Double = 0.01
    
    lazy var timer: Timer = {
        let timer = Timer()
        return timer
    }()
    
    func setTimer(seconds: Int) {
        duration = Double(seconds)
        defaultTime = Double(seconds)
    }
    
    func start() {
        runTimer()
    }
    
    func pause() {
        timer.invalidate()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: decrement, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if duration < 0.0 {
            timer.invalidate()
            timerDone()
        } else {
            duration -= decrement
        }
    }
    
    func timerDone() {
        timer.invalidate()
        duration = defaultTime
        delegate?.countdownTimerDone()
    }
}
