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
    
    private var seconds: Double = 0.0
    private var duration: Double = 0.0
    
    lazy var timer: Timer = {
        let timer = Timer()
        return timer
    }()
    
    func setTimer(seconds: Int) {
        duration = Double(seconds)
        self.seconds = Double(seconds)
    }
    
    func start() {
        runTimer()
    }
    
    func pause() {
        timer.invalidate()
    }
    
    func stop() {
        timer.invalidate()
        duration = seconds
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if duration < 0.0 {
            timer.invalidate()
            timerDone()
        } else {
            duration -= 0.01
        }
    }
    
    func timerDone() {
        timer.invalidate()
        duration = seconds
        delegate?.countdownTimerDone()
    }
}
