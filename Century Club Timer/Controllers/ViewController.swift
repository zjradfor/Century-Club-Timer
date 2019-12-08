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
    @IBOutlet weak var counterLabel: UILabel!
    
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
        counterLabel.text = "\(count)"
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        // this should go 1 more than 100 to account for drink 100 then show a finish screen
        if count == 3 {
            countdownTimerDidStart = false
            startButton.setTitle("START",for: .normal)
            count = 0
            counterLabel.text = "0"
            
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
    @IBAction func addPlayerPressed() {
        let alert = UIAlertController(title: "Add Player", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { alertAction in }))

        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            if let textField = alert?.textFields?[0] {
                if textField.text != "" {
                    print("\(textField.text ?? "default")")
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func endGamePressed() {
        let alert = UIAlertController(title: "End Game", message: "The current game will end, are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { alertAction in }))

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak alert] (_) in
            // do stuff to end game
        }))
        self.present(alert, animated: true, completion: nil)
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
