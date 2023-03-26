//
//  ViewController.swift
//  EggTimer
//
//  Created by Eren Candan on 25.03.2023.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    // Create Instance of AVAudioPlayer
    var player: AVAudioPlayer!

    // Create a dict

    let times: [String: Int] = ["Soft": 3, "Medium": 5, "Hard": 7]

    var totalTime: Int = 0
    var secondPassed: Int = 0
    var timer = Timer()

    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var label: UILabel!

    @IBOutlet weak var progressPercentage: UILabel!
    func playRing() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()

        let hardness: String = sender.currentTitle ?? "Soft"

        totalTime = times[hardness]!

        progressBar.progress = 0.0
        secondPassed = 0
        label.text = hardness

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if secondPassed <= totalTime {
            secondPassed += 1

            // Int değerindeki türündeki bir değerin bölümünü Float'a çevirsek bile istediğimiz sonucu alamıyorduk.
            // Dikkat etmemiz gereken şey Float Float'a bölünebilir onun dışında Int / Int yapmaya çalıştığımızda,
            // Sonuca en yakın 0 değerini aldığımızdan istediğimiz progressi alamıyorduk.
            // Bu yüzden veri tiplerini değiştirdik
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            formatter.roundingMode = .floor
            let percentageMaxDigit = formatter.string(from: NSNumber(value: (progressBar.progress * 100)))
            progressBar.progress = Float(secondPassed) / Float(totalTime)
            progressPercentage.text = "%  \(percentageMaxDigit!)"

        } else {
            timer.invalidate()
            playRing()
            label.text = "Done !"
        }
    }
}
