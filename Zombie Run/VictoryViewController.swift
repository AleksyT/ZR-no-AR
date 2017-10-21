//
//  VictoryViewController.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 19.10.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit

class VictoryViewController: UIViewController
{
    /* VARIABLES */
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        player().stop()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0)
        {
            self.performSegue(withIdentifier: "unwindVictory", sender: self)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        player().playSound(title: "victory", format: "wav")
    }
}
