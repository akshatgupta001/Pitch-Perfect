//
//  playSoundVC.swift
//  PitchPerfect
//
//  Created by Akshat Gupta on 12/01/19.
//  Copyright © 2019 coded. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundVC: UIViewController {
    var recordedAudioURL : URL!
    
    @IBOutlet weak var snailBtn : UIButton!
    @IBOutlet weak var chipmunkBtn : UIButton!
    @IBOutlet weak var vaderBtn : UIButton!
    @IBOutlet weak var rabbitBtn : UIButton!
    @IBOutlet weak var echoBtn : UIButton!
    @IBOutlet weak var reverbBtn : UIButton!
     @IBOutlet weak var stopBtn : UIButton!
    
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBAction func playSoundForbutton(_ sender : UIButton){
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    @IBAction func stopSoundPressed(_ sender : Any){
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        setupAudio()
    }
    

   

}
