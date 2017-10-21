//
//  player.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 16.10.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit
import AVFoundation

class player: UIViewController
{
    var music:Bool = true
    var sound:Bool = true
    var intro:Bool = true
    
    var soundPlayer: AVAudioPlayer?
        {
        get
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.soundPlayer
        }
        set
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.soundPlayer = newValue
        }
    }
    
    var musicPlayer: AVAudioPlayer?
        {
        get
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.musicPlayer
        }
        set
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.musicPlayer = newValue
        }
    }
    
    var clickPlayer: AVAudioPlayer?
    {
        get
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.clickPlayer
        }
        set
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.clickPlayer = newValue
        }
    }
    
    func playSound(title: String, format: String)
    {
        if let UDsound = UserDefaults.standard.object(forKey: "UDsound")
        {
            sound = UDsound as! Bool
        }
        
        if sound == true
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
    
    func playMusic()
    {
        if let UDmusic = UserDefaults.standard.object(forKey: "UDmusic")
        {
            music = UDmusic as! Bool
        }
        
        if music == true
        {
            guard let url = Bundle.main.url(forResource: "ambientMusic", withExtension: "mp3")
                
                else { return }
            
            do
            {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                
                musicPlayer = try AVAudioPlayer(contentsOf: url)
                
                musicPlayer?.play()
                musicPlayer?.numberOfLoops = -1
            }
            catch let error
            {
                print(error.localizedDescription)
            }
        }
    }
    
    func playClick()
    {
        if let UDsound = UserDefaults.standard.object(forKey: "UDsound")
        {
            sound = UDsound as! Bool
        }
        
        if sound == true
        {
            guard let url = Bundle.main.url(forResource: "click", withExtension: "mp3")
                
                else { return }
            
            do
            {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                
                clickPlayer = try AVAudioPlayer(contentsOf: url)
                
                clickPlayer?.play()
            }
            catch let error
            {
                print(error.localizedDescription)
            }
        }
    }
    
    func stop()
    {
        musicPlayer?.stop()
    }
}
