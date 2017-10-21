//
//  Intro2ViewController.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 31.07.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit
import AVFoundation

class Intro2ViewController: UIViewController
{
    /* VARIABLES */
    
    var intro:Bool = true
    
    var introPlayer:AVAudioPlayer = AVAudioPlayer()
    
    var time:Double = 0.0
    var timer = Timer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let UDintro = UserDefaults.standard.object(forKey: "UDintro")
        {
            intro = UDintro as! Bool
        }
        audio()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    /* FUNCTIONS */
    
    func audio()
    {
        do
        {
            let audioPath = Bundle.main.path(forResource: "Intro", ofType: "wav")
            try introPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
            print("ERROR - AUDIO MALFUNCTION")
        }
    }
    
    func subtitles()
    {
        time+=0.5
        
        switch time
        {
        case 0.00...3.50:
            self.introDisplay.text = "If you're listening to this, then I'm probably dead or worse..."
            self.progressRec.progress = 1/17
        case 3.50...5.00:
            self.introDisplay.text = "I'm one of them..."
            self.progressRec.progress = 2/17
        case 5.00...7.00:
            self.introDisplay.text = "I don’t even know how it all started."
            self.progressRec.progress = 3/17
        case 7.00...9.00:
            self.introDisplay.text = "They say the virus came from laboratory"
            self.progressRec.progress = 4/17
        case 9.00...11.50:
            self.introDisplay.text = "and later on it spread throughout the globe."
            self.progressRec.progress = 5/17
        case 11.50...13.50:
            self.introDisplay.text = "That’s so crazy man I tell ya,"
            self.progressRec.progress = 6/17
        case 13.50...16.50:
            self.introDisplay.text = "one day you just wake up and everything’s gone."
            self.progressRec.progress = 7/17
        case 16.50...19.50:
            self.introDisplay.text = "We had it coming though, it was unavoidable."
            self.progressRec.progress = 8/17
        case 19.50...22.50:
            self.introDisplay.text = "I feel my strength ebbing me, and the pain is growing"
            self.progressRec.progress = 9/17
        case 22.50...25.50:
            self.introDisplay.text = "so I guess it’s my final chapter."
            self.progressRec.progress = 10/17
        case 25.50...29.00:
            self.introDisplay.text = "Take all this I’m leaving you. Take everything,"
            self.progressRec.progress = 11/17
        case 29.00...32.50:
            self.introDisplay.text = "the bag, painkillers and this gun."
            self.progressRec.progress = 12/17
        case 32.50...35.50:
            self.introDisplay.text = "Unfortunately, there is no much ammo left,"
            self.progressRec.progress = 13/17
        case 35.50...38.00:
            self.introDisplay.text = "but who has it nowadays?"
            self.progressRec.progress = 14/17
        case 38.00...41.00:
            self.introDisplay.text = "Don't get caught and above all, don’t get bitten."
            self.progressRec.progress = 15/17
        case 41.00...45.00:
            self.introDisplay.text = "I heard that worlds' governments are making..."
            self.progressRec.progress = 16/17
        case 45.00...51.00:
            self.introDisplay.text = ""
        case 51.00...52.00:
            self.progressRec.progress = 17/17
        default:
            /* print("SUBTITLES EXCEED AUDIO") */
            timer.invalidate()
            skipButton.titleLabel?.textColor = UIColor.white
            skipButton.setTitle("Next", for: .normal)
        }
    }
    
    /* ACTIONS */
    
    @IBAction func playAndDisplay(_ sender: Any)
    {
        player().playClick()
        if intro == true
        {
           introPlayer.play()
        }
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:#selector(Intro2ViewController.subtitles), userInfo: nil, repeats: true)
        (sender as AnyObject).setImage(#imageLiteral(resourceName: "cassette.png") /* cassette image */ , for: .normal)
        playAndDisplayButton.isUserInteractionEnabled = false
        progressRec.alpha = 1
    }
    
    @IBAction func pause(_ sender: Any)
    {
        player().playClick()
        if intro == true
        {
            introPlayer.pause()
            time = introPlayer.currentTime
        }
        timer.invalidate()
        playAndDisplayButton.setImage(#imageLiteral(resourceName: "PlayRecord.png") /* playRecord image*/ , for: .normal)
        playAndDisplayButton.isUserInteractionEnabled = true
        progressRec.alpha = 0
    }
    
    @IBAction func stop(_ sender: Any)
    {
        player().playClick()
        if intro == true
        {
            introPlayer.stop()
            introPlayer.currentTime = 0
        }
        timer.invalidate()
        time = 0
        playAndDisplayButton.setImage(#imageLiteral(resourceName: "PlayRecord.png") /* playRecord image*/ , for: .normal)
        playAndDisplayButton.isUserInteractionEnabled = true
        progressRec.alpha = 0
        self.progressRec.progress = 0
        self.introDisplay.text = ""
    }
    
    @IBAction func skip(_ sender: Any)
    {
        player().playClick()
        if intro == true
        {
            introPlayer.stop()
            introPlayer.currentTime = 0
        }
        timer.invalidate()
        time = 0
        performSegue(withIdentifier: "introToGame", sender: self)
        skipButton.titleLabel?.textColor = UIColor.red
        skipButton.setTitle("Skip", for: .normal)
    }
    
    @IBAction func back(_ sender: Any)
    {
        player().playClick()
        introPlayer.stop()
        introPlayer.currentTime = 0
        timer.invalidate()
        time = 0
        skipButton.titleLabel?.textColor = UIColor.red
        skipButton.setTitle("Skip", for: .normal)
    }
    
    /* OUTLETS */
   
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var playAndDisplayButton: UIButton!
    @IBOutlet weak var progressRec: UIProgressView!
    @IBOutlet weak var introDisplay: UILabel!
}
