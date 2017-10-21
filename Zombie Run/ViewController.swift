//
//  ViewController.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 31.07.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    /* ACTIONS */
        
    @IBAction func play(_ sender: Any)
    {
        player().playClick()
        performSegue(withIdentifier: "menuToIntro", sender: self)
    }
    
    @IBAction func settings(_ sender: Any)
    {
        player().playClick()
        performSegue(withIdentifier: "menuToSettings", sender: self)
    }
    
    @IBAction func unwindToMenu(_ segue: UIStoryboardSegue)
    {
        player().playClick()
        print("Back in the ViewController")
    }
}
