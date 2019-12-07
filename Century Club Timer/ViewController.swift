//
//  ViewController.swift
//  Century Club Timer
//
//  Created by Zach Radford on 2019-12-07.
//  Copyright © 2019 Zach Radford. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController  {

    @IBOutlet weak var progressBar: ProgressBar!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var counterView: UIStackView!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

