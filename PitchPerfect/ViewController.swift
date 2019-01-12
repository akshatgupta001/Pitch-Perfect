//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Akshat Gupta on 12/01/19.
//  Copyright © 2019 coded. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder : AVAudioRecorder!
    @IBOutlet weak var record: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        stop.isEnabled = false
    }
    @IBAction func recordPressed(_ sender: Any) {
        lbl.text = "Recording in progress"
        stop.isEnabled = true
        record.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        print(pathArray)
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    @IBAction func stopPressed(_ sender: Any) {
        record.isEnabled = true
         lbl.text = "press to record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("finishsed recording")
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Recording unsuccesful", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundVC = segue.destination as! playSoundVC
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
}

