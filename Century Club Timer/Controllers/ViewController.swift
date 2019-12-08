//
//  ViewController.swift
//  Century Club Timer
//
//  Created by Zach Radford on 2019-12-07.
//  Copyright © 2019 Zach Radford. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, CountdownTimerDelegate {

    @IBOutlet weak var progressBar: ProgressBar!
    @IBOutlet weak var startButton: UIButton!
    
    var countdownTimerDidStart: Bool = false
    
    lazy var countdownTimer: CountdownTimer = {
        let timer = CountdownTimer()
        return timer
    }()
    
    let selectedSecs: Int = 5
    
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdownTimer.delegate = self
        countdownTimer.setTimer(seconds: selectedSecs)
        progressBar.setProgressBar(hours: 0, minutes: 0, seconds: selectedSecs)
    }
    
    func countdownTimerDone() {
        count += 1
        
        if count == 2 {
            countdownTimerDidStart = false
            startButton.setTitle("START",for: .normal)
            count = 0
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            print("countdownTimerDone")
        } else {
            startTimer()
        }
    }

    @IBAction func startButtonPressed() {
        if !countdownTimerDidStart {
            startTimer()
            countdownTimerDidStart = true
            startButton.setTitle("PAUSE",for: .normal)
        } else {
            pauseTimer()
            countdownTimerDidStart = false
            startButton.setTitle("RESUME",for: .normal)
        }
    }
    
    func startTimer() {
        countdownTimer.start()
        progressBar.start()
    }
    
    func pauseTimer() {
        countdownTimer.pause()
        progressBar.pause()
    }
}
