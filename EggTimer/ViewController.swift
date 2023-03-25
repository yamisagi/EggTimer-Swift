//
//  ViewController.swift
//  EggTimer
//
//  Created by Eren Candan on 25.03.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        print(sender.currentTitle!)
        
    }
    
}

