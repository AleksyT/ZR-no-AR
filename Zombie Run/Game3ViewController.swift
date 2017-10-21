//
//  Game3ViewController.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 02.08.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AVFoundation

/* IMAGE ROTATION EXTENSION */

extension UIImage
{
    struct RotationOptions: OptionSet
    {
        let rawValue: Int
        
        static let flipOnVerticalAxis = RotationOptions(rawValue: 1)
        static let flipOnHorizontalAxis = RotationOptions(rawValue: 2)
    }
    
    func rotated(by rotationAngle: Measurement<UnitAngle>, options: RotationOptions = []) -> UIImage?
    {
        guard let cgImage = self.cgImage
        
        else
        {
            return nil
        }
        
        let rotationInRadians = CGFloat(rotationAngle.converted(to: .radians).value)
        let transform = CGAffineTransform(rotationAngle: rotationInRadians)
        var rect = CGRect(origin: .zero, size: self.size).applying(transform)
        rect.origin = .zero
        
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        return renderer.image { renderContext in
            renderContext.cgContext.translateBy(x: rect.midX, y: rect.midY)
            renderContext.cgContext.rotate(by: rotationInRadians)
            
            let x = options.contains(.flipOnVerticalAxis) ? -1.0 : 1.0
            let y = options.contains(.flipOnHorizontalAxis) ? 1.0 : -1.0
            renderContext.cgContext.scaleBy(x: CGFloat(x), y: CGFloat(y))
            
            let drawRect = CGRect(origin: CGPoint(x: -self.size.width/2, y: -self.size.height/2), size: self.size)
            renderContext.cgContext.draw(cgImage, in: drawRect)
        }
    }
}

class Game3ViewController: UIViewController, CLLocationManagerDelegate
{
    /* VARIABLES */
    
    var timer = Timer()
    
    var range = Int()
    
    var speed:Int = 4
    var number:Int = 10
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocation()
    
    var START:Int = 1
    
    /* 2D Array [number][3]
     
     10 -> number of zombies
     3 -> [0] - ZOMBIE'S COORDINATES, [1] - ANGLE THETA, [2] - ZOMBIE'S HEALTH */
    var zombies = [[AnyObject]]()
    
    /* coordinates of zombies[i][0] change according to zombies[i][2] angle */
    var markers = [UIButton]()
    
    var equipment: [[Int]] = Array(repeating:Array(repeating:0, count:2), count:5)
    var slots: [[Int]] = Array(repeating:Array(repeating:0, count:2), count:10)
    var L:Int = 0
    var box = UIView()
    
    var HP:Int = 100
    
    var showText:String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /* INITIALIZE SPEED AND NUMBER OF ZOMBIES */
                
        if let UDspeed = UserDefaults.standard.object(forKey: "UDspeed"), let UDnumber = UserDefaults.standard.object(forKey: "UDnumber")
        {
            speed = UDspeed as! Int
            number = UDnumber as! Int
        }
        
        /* SET MAXIMUM VISIBILITY */
        
        setRadar()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        /* SET MAXIMUM SHOOTING RANGE */
        
        setRange(damage: equipment[0][1])
        
        /* UPDATE POINTS */
        
        var L:Int = 0
        
        for i in 0..<slots.count
        {
            if slots[i][0] == 9
            {
                L = L + slots[i][1]
            }
        }
        
        points.text = String(HP) + " HP | " + String(describing: equipment[0][1]) + " DG | " + String(describing: (equipment[1][1] + equipment[2][1] + equipment[3][1] + equipment[4][1])) + " D | " + String(L) + " L"
        
        /* DO GAME'S FUNDAMENTALS */
        
        doPulses()
        getUserLocationAndHeader()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(Game3ViewController.updatePositions)), userInfo: nil, repeats: true)
    }
    
    /* MAIN FUNCTIONS */
    
    func doPulses()
    {
        let pulse = Pulsing(radius: map.frame.height/2, position: CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2))
        pulse.animationDuration = 2
        pulse.backgroundColor = UIColor.red.cgColor
        
        self.view.layer.insertSublayer(pulse, below: aim.layer)
    }
    
    func getUserLocationAndHeader()
    {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.headingOrientation = .portrait
        locationManager.headingFilter = kCLHeadingFilterNone
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
    }
    
    /* LOCATION */
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        userLocation = locations[0] as CLLocation
        
        if(userLocation.speed < 0)
        {
            info.text = "Waiting for GPS..."
        }
        else if userLocation.speed >= 0
        {
            info.text = ("\(Int(userLocation.speed))" + " mps")
        }
        
        if START == 1
        {
            /* CREATE ZOMBIES AND THEIR RESPECTIVE MARKERS */
                
            zombies = drawMap().createZombies(counter: number, location: userLocation, focalPoint: aim.center)
            markers = drawMap().createMarkers(counter: number, from: zombies, place: map)
            player().playSound(title: "zombieBorn", format: "wav")
            player().playMusic()
            
            /* CREATE BOX, THE PICK-A-RANDOM-ITEM AREA */
            
            box = drawMap().placeBox(focalPoint: aim.center, place: map)
            for i in 0..<number
            {
                map.bringSubview(toFront: markers[i])
            }
            /* FETCH INVENTORY */
                
            (equipment, START) = backpackMemory().loadBackpack(from: "Equipment", load: equipment, isSTART: START)
            (slots, START) = backpackMemory().loadBackpack(from: "Slots", load: slots, isSTART: START)
                
            /* FETCH POINTS */
            
            for i in 0..<slots.count
            {
                if slots[i][0] == 9
                {
                    L = L + slots[i][1]
                }
            }
            points.text = String(HP) + " HP | " + String(describing: equipment[0][1]) + " DG | " + String(describing: (equipment[1][1] + equipment[2][1] + equipment[3][1] + equipment[4][1])) + " D | " + String(L) + " L"
        }
        START = 0
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        info.text = "Waiting for GPS..."
        print("\(error)")
    }

    /* HEADER */
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading userHeading: CLHeading)
    {
        let theta:Double = userHeading.magneticHeading /* * Double.pi/180 */
        /* theta = Double(String(format: "%.1f", userHeading.magneticHeading * Double.pi/180))! */
        aim.image = #imageLiteral(resourceName: "aimWithTarget").rotated(by: Measurement(value: theta, unit: .degrees))
        
        /* for i in 0..<number
        {
         
         /* MAP ROTATION */
         
         /* IF-CLAUSE IS NECCESSARY HERE */
         
            let zombieTheta = atan2((markers[i].center.y - aim.center.y), (markers[i].center.x - aim.center.x))
            let rotationTheta = zombieTheta - CGFloat(theta)
         
            let x = (markers[i].center.x - aim.center.x)
            let y = (markers[i].center.y - aim.center.y)
         
            let radius = sqrt((x * x) + (y * y))
         
         
            markers[i].center.x = CGFloat(radius * cos(rotationTheta)) + aim.center.x
            markers[i].center.y = CGFloat(radius * sin(rotationTheta)) + aim.center.y
         } */
    }
    
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool
    {
        return true
    }
    
    /* MOVEMENT & SHOOTING */
    
    func updatePositions()
    {
        var zombiesKilled = 0
        
        for i in 0..<number
        {
            if Int(userLocation.speed) >= 0
            {
                /* USER MOVES */
                
                let userTheta = userLocation.course * Double.pi/180
                let userSpeed = userLocation.speed/5 /* s = vt */
                let userMoves = CGPoint(x: CGFloat(userSpeed * cos(userTheta)), y: CGFloat(userSpeed * sin(userTheta)))
                
                markers[i].center = CGPoint(x: markers[i].center.x - userMoves.x, y: markers[i].center.y - userMoves.y)
                box.center = CGPoint(x: box.center.x - userMoves.x/CGFloat(number), y: box.center.y - userMoves.y/CGFloat(number))
                
                /* ZOMBIES MOVE */
                
                let zombieTheta = atan2((markers[i].center.y - aim.center.y), (markers[i].center.x - aim.center.x))
                let zombieSpeed = Double(speed)/5
                let zombieMoves = CGPoint(x: CGFloat(zombieSpeed) * cos(zombieTheta), y: CGFloat(zombieSpeed) * sin(zombieTheta))
                
                markers[i].center = CGPoint(x: markers[i].center.x - zombieMoves.x, y: markers[i].center.y - zombieMoves.y)
                
                /* USER SHOOTS A ZOMBIE */
                
                let canShoot = CGPoint(x: markers[i].center.x - aim.center.x, y: markers[i].center.y - aim.center.y)
                
                let distance = 5 * sqrt(Double((canShoot.x * canShoot.x) + (canShoot.y * canShoot.y)))
                
                if Int(distance) <= range
                {
                    markers[i].setImage(#imageLiteral(resourceName: "cross"), for: .normal)
                }
                else if Int(distance) > range
                {
                    markers[i].setImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
                }
                
                /* USER STEPS INTO BOX */
                
                if box.frame.contains(aim.center)
                {
                    timer.invalidate()
                    for i in 0..<number
                    {
                        markers[i].setImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
                        zombies[i][0] = markers[i].center as AnyObject
                    }
                    /* SET NEW BOX LOCATION */
                    
                    box.removeFromSuperview()
                    box = drawMap().placeBox(focalPoint: aim.center, place: map)
                    for i in 0..<number
                    {
                        map.bringSubview(toFront: markers[i])
                    }
                    performSegue(withIdentifier: "gameToItems", sender: self)
                }
                
                /* ZOMBIE CATCHES USER */
                
                if markers[i].frame.contains(aim.center) && markers[i].alpha == 1
                {
                    timer.invalidate()
                    for i in 0..<number
                    {
                        markers[i].setImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
                        zombies[i][0] = markers[i].center as AnyObject
                    }
                    performSegue(withIdentifier: "gameToShake", sender: self)
                }
                
                /* WIN */
                
                if markers[i].alpha == 0
                {
                    zombiesKilled = zombiesKilled + 1
                }
                
                if zombiesKilled == number
                {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
                    {
                        self.timer.invalidate()
                        self.performSegue(withIdentifier: "gameToVictory", sender: self)
                    }
                }
            }
        }
    }
    
    /* OTHER FUNCTIONS */
    
    func setRadar()
    {
        map.frame = CGRect(x: -0.5 * (map.frame.height - self.view.frame.size.width), y: map.frame.origin.y, width: map.frame.height, height: map.frame.height)
        map.layer.cornerRadius = map.frame.size.width/2
        map.clipsToBounds = true
        map.backgroundColor = UIColor.clear
    }
    
    func setRange(damage: Int)
    {
        switch damage
        {
        case 20:
            range = 150
        case 40:
            range = 600
        case 60:
            range = 600
        case 80:
            range = 1000
        case 100:
            range = 100
        case 150:
            range = 400
        case 200:
            range = 900
        default:
            range = 0
        }
    }
    
    func shoot(sender: UIButton!)
    {
        if sender.currentImage == #imageLiteral(resourceName: "cross")
        {
            var shoot:Bool = false
            var blowUp:Bool = false
            var explosion = Float()
            
            switch equipment[0][1]
            {
            case 20, 80: /* LIGHT GUNS & SNIPER RIFLE - SMALL BULLETS; SINGLE SHOT  */
                searchForAmmo: for i in 0..<slots.count
                {
                    if slots[i][0] == 7 && (slots[i][1] > 0 && slots[i][1] <= 4)
                    {
                        slots[i][1] = slots[i][1] - 1
                        
                        if slots[i][1] <= 0
                        {
                            slots[i][0] = 0
                            slots[i][1] = 0
                        }
                        backpackMemory().reloadBackpack(what: "Slots", reload: slots, I: i)
                        shoot = true
                        player().playSound(title: "lightGun", format: "mp3")
                        
                        break searchForAmmo
                    }
                    else
                    {
                        player().playSound(title: "emptyGun", format: "wav")
                    }
                }
            case 40, 60, 150: /* HEAVY GUNS - BIG BULLETS; SERIAL SHOT */
                searchForAmmo: for i in 0..<slots.count
                {
                    if slots[i][0] == 7 && (slots[i][1] >= 8 && slots[i][1] <= 32)
                    {
                        slots[i][1] = slots[i][1] - 8
                        
                        if slots[i][1] <= 0
                        {
                            slots[i][0] = 0
                            slots[i][1] = 0
                        }
                        backpackMemory().reloadBackpack(what: "Slots", reload: slots, I: i)
                        shoot = true
                        player().playSound(title: "heavyGun", format: "wav")
                        
                        break searchForAmmo
                    }
                    else
                    {
                        player().playSound(title: "emptyGun", format: "wav")
                    }
                }
            case 100:
                blowUp = true
                explosion = 7.5
                player().playSound(title: "grenade", format: "wav")
            case 200:
                blowUp = true
                explosion = 40
                player().playSound(title: "rocketLauncher", format: "wav")
            default: 
                break
            }
            
            if shoot == true /* GUN IS USED */
            {
                zombies[sender.tag][2] = (Int(zombies[sender.tag][2] as! NSNumber) - equipment[0][1]) as AnyObject
                
                if Int(zombies[sender.tag][2] as! NSNumber) <= 0
                {
                    self.markers[sender.tag].alpha = 0
                }
                for i in 0..<number
                {
                    markers[i].setImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
                }
            }
            
            if blowUp == true /* RPG OR GRENADE IS USED */
            {
                let explosion = UIView(frame: CGRect(x: sender.center.x - CGFloat(explosion), y: sender.center.y - CGFloat(explosion), width: CGFloat(explosion * 2), height: CGFloat(explosion * 2)))
                explosion.layer.cornerRadius = explosion.frame.size.width/2
                explosion.clipsToBounds = true
                
                for i in 0..<number
                {
                    if explosion.frame.contains(markers[i].center)
                    {
                        markers[i].alpha = 0
                        zombies[i][2] = 0 as AnyObject
                    }
                }
                equipment[0][0] = 0
                equipment[0][1] = 0
                backpackMemory().reloadBackpack(what: "Equipment", reload: equipment, I: 0)
                range = 0
                
                for i in 0..<slots.count
                {
                    if slots[i][0] == 9
                    {
                        L = L + slots[i][1]
                    }
                }
                
                points.text = String(HP) + " HP | " + "0 DG | " + String(describing: (equipment[1][1] + equipment[2][1] + equipment[3][1] + equipment[4][1])) + " D | " + String(L) + " L"
                
                for i in 0..<number
                {
                    markers[i].setImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
                }
            }
        }
    }
    /* ACTIONS */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "gameToBackpack"
        {
            if let Backpack4 = segue.destination as? Backpack4ViewController
            {
                Backpack4.zombies = zombies
            }
        }
            
        else if segue.identifier == "gameToItems"
        {
            if let Box5 = segue.destination as? itemsInBox5ViewController
            {
                Box5.zombies = zombies
            }
        }
            
        else if segue.identifier == "gameToShake"
        {
            if let Shake6 = segue.destination as? ShakeDevice6ViewController
            {
                Shake6.focalPoint = aim.center
                Shake6.equipment = equipment
                Shake6.zombies = zombies
                Shake6.markers = markers
                Shake6.HP = HP                
            }
        }
        
        else if segue.identifier == "unwindToMenu"
        {
            player().stop()
        }
    }
    
    @IBAction func moveToBackpack(_ sender: Any)
    {
        player().playClick()
        timer.invalidate()
        for i in 0..<number
        {
            markers[i].setImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
            zombies[i][0] = markers[i].center as AnyObject
        }
        performSegue(withIdentifier: "gameToBackpack", sender: self)
    }
    
    @IBAction func heal(_ sender: Any)
    {
        var max:[Int] = [0,0]
        
        for i in 0..<slots.count
        {
            if HP < 100 && slots[i][0] == 6 && slots[i][1] > max[1]
            {
                max[0] = i
                max[1] = slots[i][1]
            }
        }
        
        if max[1] != 0
        {
            slots[max[0]] = [0,0]
            backpackMemory().reloadBackpack(what: "Slots", reload: slots, I: max[0])
            HP = HP + max[1]
            if HP > 100
            {
                HP = 100
            }
            points.text = String(HP) + " HP | " + String(describing: equipment[0][1]) + " DG | " + String(describing: (equipment[1][1] + equipment[2][1] + equipment[3][1] + equipment[4][1])) + " D | " + String(L) + " L"
            player().playSound(title: "heal", format: "wav")
        }
        else
        {
            _ = Shake(view: health)
            player().playSound(title: "shake", format: "wav")
        }
        
        /* timer.invalidate()
        for i in 0..<number
        {
            markers[i].setImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
            zombies[i][0] = markers[i].center as AnyObject
        }
        performSegue(withIdentifier: "gameToItems", sender: self) */
    }
    
    @IBAction func unwindToGame(_ segue: UIStoryboardSegue)
    {
        print("Back in the Game3ViewController")
        player().playClick()
    }
    
    /* OUTLETS */
    
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var aim: UIImageView!
    @IBOutlet weak var backpack: UIButton!
    @IBOutlet weak var health: UIButton!
    @IBOutlet weak var unpackButton: UIButton!
}
