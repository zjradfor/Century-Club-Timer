//
//  ViewController.swift
//  Century Club Timer
//
//  Created by Zach Radford on 2019-12-07.
//  Copyright © 2019 Zach Radford. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var progressBar: ProgressBar!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var tableview: UITableView!
    
    var countdownTimerDidStart: Bool = false
    
    lazy var countdownTimer: CountdownTimer = {
        let timer = CountdownTimer()
        return timer
    }()
    
    let selectedSecs: Int = 5
    
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        countdownTimer.delegate = self
        countdownTimer.setTimer(seconds: selectedSecs)
        progressBar.setProgressBar(hours: 0, minutes: 0, seconds: selectedSecs)
    }
    
    func timerDone() {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "HELLO"
        return cell
    }
}

extension ViewController: CountdownTimerDelegate {
    func countdownTimerDone() {
        timerDone()
    }
}
