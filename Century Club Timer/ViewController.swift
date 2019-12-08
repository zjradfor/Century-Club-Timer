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
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var countdownTimerDidStart: Bool = false
    
    lazy var countdownTimer: CountdownTimer = {
        let timer = CountdownTimer()
        return timer
    }()
    
    let selectedSecs: Int = 10
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "DONE"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdownTimer.delegate = self
        countdownTimer.setTimer(seconds: selectedSecs)
        progressBar.setProgressBar(hours: 0, minutes: 0, seconds: selectedSecs)
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
        
        view.addSubview(messageLabel)
        
        var constraintCenter = NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        self.view.addConstraint(constraintCenter)
        constraintCenter = NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view.addConstraint(constraintCenter)
        
        messageLabel.isHidden = true
        
    }
    
    func countdownTimerDone() {
        messageLabel.isHidden = false
        countdownTimerDidStart = false
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
        startButton.setTitle("START",for: .normal)
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        print("countdownTimerDone")
    }

    @IBAction func startTimer() {
        messageLabel.isHidden = true
        
        stopButton.isEnabled = true
        stopButton.alpha = 1.0
        
        if !countdownTimerDidStart{
            countdownTimer.start()
            progressBar.start()
            countdownTimerDidStart = true
            startButton.setTitle("PAUSE",for: .normal)
            
        }else{
            countdownTimer.pause()
            progressBar.pause()
            countdownTimerDidStart = false
            startButton.setTitle("RESUME",for: .normal)
        }
    }
    

    @IBAction func stopTimer() {
        countdownTimer.stop()
        progressBar.stop()
        countdownTimerDidStart = false
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
        startButton.setTitle("START",for: .normal)
    }
}

