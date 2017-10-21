//
//  Killed8ViewController.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 15.09.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit
import AVFoundation

class Killed8ViewController: UIViewController
{
    /* VARIABLES */
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        player().stop()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0)
        {
            self.performSegue(withIdentifier: "unwindKilled", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        player().playSound(title: "killed", format: "wav")
    }
}
