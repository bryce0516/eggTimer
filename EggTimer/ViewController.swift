//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player : AVAudioPlayer?
    
    let eggTimes = ["Soft": 3, "Medium":4, "Hard": 7]
    
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    
    var secondRemaining = 60
    var totalTime = 0
    var secondPassed = 0
    var timer = Timer()

    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
       
        
        timer.invalidate()
        progressBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        
        secondRemaining = eggTimes[hardness]!
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {

        if secondPassed < totalTime {
            print("\(secondRemaining) seconds.")

            
            secondPassed += 1
            secondRemaining -= 1
            
            let percentageProgress = Float(secondPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
            
        } else {
            timer.invalidate()
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {return}
            do {
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                guard let player = player else {
                    return
                }
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
      
            
            titleLabel.text = "Done!"
        }
    }
    
}
