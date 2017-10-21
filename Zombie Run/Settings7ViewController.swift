//
//  Settings7ViewController.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 15.09.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit
import AVFoundation

class Settings7ViewController: UIViewController
{
    /* VARIABLES */
    
    var speed:Int = 4
    var number:Int = 10
    
    var music:Bool = true
    var sound:Bool = true
    var intro:Bool = true
    
    var clickPlayer: AVAudioPlayer?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let UDspeed = UserDefaults.standard.object(forKey: "UDspeed")
        {
            speed = UDspeed as! Int
            speedSlider.value = Float(speed)
        }
        
        if let UDnumber = UserDefaults.standard.object(forKey: "UDnumber")
        {
            number = UDnumber as! Int
            numberSlider.value = Float(number)
        }
        
        if let UDmusic = UserDefaults.standard.object(forKey: "UDmusic")
        {
            music = UDmusic as! Bool
            isMusic.isOn = music
        }
        
        if let UDsound = UserDefaults.standard.object(forKey: "UDsound")
        {
            sound = UDsound as! Bool
            isSound.isOn = sound
        }
        
        if let UDintro = UserDefaults.standard.object(forKey: "UDintro")
        {
            intro = UDintro as! Bool
            isIntro.isOn = intro
        }
        
        showSpeed.text = String(Int(speedSlider.value))
        showNumber.text = String(Int(numberSlider.value))
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    /* ACTIONS */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "unwindToMenu"
        {
                player().playClick()
        }
    }
    
    @IBAction func speedChanges(_ sender: Any)
    {
        showSpeed.text = String(Int(speedSlider.value))
        speed = Int(speedSlider.value)
        /* print("s: ", speed) */
    }
    
    @IBAction func numberChanges(_ sender: Any)
    {
        showNumber.text = String(Int(numberSlider.value))
        number = Int(numberSlider.value)
        /* print("n: ", number) */
    }
    
    @IBAction func changeSwitch(sender: UIButton)
    {
        switch sender
        {
        case isMusic:
            music = isMusic.isOn
        case isSound:
            sound = isSound.isOn
            UserDefaults.standard.set(sound, forKey: "UDsound")
        case isIntro:
            intro = isIntro.isOn
        default:
            break
        }
    }
    
    @IBAction func saveSettings(_ sender: Any)
    {
        UserDefaults.standard.set(speed, forKey: "UDspeed")
        UserDefaults.standard.set(number, forKey: "UDnumber")
        UserDefaults.standard.set(music, forKey: "UDmusic")
        UserDefaults.standard.set(intro, forKey: "UDintro")
    }
    
    /* OUTLETS */
    
    @IBOutlet weak var showSpeed: UILabel!
    @IBOutlet weak var showNumber: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var isMusic: UISwitch!
    @IBOutlet weak var isSound: UISwitch!
    @IBOutlet weak var isIntro: UISwitch!
}
