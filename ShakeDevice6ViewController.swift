//
//  ShakeDevice6ViewController.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 14.09.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ShakeDevice6ViewController: UIViewController
{
    /* VARIABLES */
    
    var sounds:Bool = true
    
    var zombies = [[AnyObject]]()
    var markers = [UIButton]()
    
    var movesCount = 0
    
    var focalPoint = CGPoint()
    var equipment: [[Int]] = Array(repeating:Array(repeating:0, count:2), count:5)
    var HP = Int()
    
    var soundPlayer: AVAudioPlayer?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let UDsounds = UserDefaults.standard.object(forKey: "UDsounds")
        {
            sounds = UDsounds as! Bool
        }
        
        let D = (equipment[1][1] + equipment[2][1] + equipment[3][1] + equipment[4][1])
        HP = HP - 55 + Int(0.2 * Double(D)) /* ZOMBIE'S DG: 55 (MINUS DEFENCE) */
        
        for i in 0..<zombies.count
        {
            let theta = atan2((markers[i].center.y - focalPoint.y), (markers[i].center.x - focalPoint.x))
            var radius = sqrt((markers[i].center.x - focalPoint.x) * (markers[i].center.x - focalPoint.x) + (markers[i].center.y - focalPoint.y) * (markers[i].center.y - focalPoint.y))
            
            radius = radius + 20
            
            let x = Float(radius) * Float(cos(theta))
            let y = Float(radius) * Float(sin(theta))
            
            markers[i].center = CGPoint(x: CGFloat(x) + focalPoint.x, y: CGFloat(y) + focalPoint.y)
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        playSound(title: "zombieAttacks", format: "wav")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    /* FUNCTIONS */
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        if event?.subtype == UIEventSubtype.motionShake
        {
            movesCount += 1
        }
        
        if movesCount >= 1 && HP > 0
        {
            performSegue(withIdentifier: "unwindShake", sender: self)
        }
        
        else if movesCount >= 1 && HP <= 0 /* LOSS */
        {
            performSegue(withIdentifier: "gameToKilled", sender: self)
        }
    }
    
    func playSound(title: String, format: String)
    {
        if sounds == true
        {
            guard let url = Bundle.main.url(forResource: title, withExtension: format)
                
                else { return }
            
            do
            {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                
                soundPlayer = try AVAudioPlayer(contentsOf: url)
                
                soundPlayer?.play()
            }
            catch let error
            {
                print(error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "unwindShake"
        {
            let Game3 = segue.destination as! Game3ViewController
            
            Game3.HP = HP
            Game3.zombies = zombies
            Game3.markers = markers
        }
    }
}
