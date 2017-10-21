//
//  drawMap.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 27.08.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class drawMap
{
    func createZombies(counter: Int, location: CLLocation, focalPoint: CGPoint) -> [[AnyObject]]
    {
        let distanceLimit:Double = 200
        var zombieLocation = CLLocation()
        var theta = Double()
        var distance = CLLocationDistance()
        var zombies = Array(repeating:Array(repeating:0, count:3), count:counter) as [[AnyObject]] /* 0 - coordinates, 1 - theta, 2 - zombie's health */
        
        for i in 0..<counter
        {
            repeat
            {
                var roundedLatitude = String(format: "%.2f", location.coordinate.latitude)
                var roundedLongitude = String(format: "%.2f", location.coordinate.longitude)
                
                /* there are 2 digits after decimal point, so another 11 are needed (13 are required)  */
                
                for _ in 0..<11
                {
                    /* randomly create zombie's location */
                    
                    let randomLatitude = String(arc4random_uniform(9))
                    roundedLatitude = roundedLatitude + randomLatitude
                    
                    let randomLongitude = String(arc4random_uniform(9))
                    roundedLongitude = roundedLongitude + randomLongitude
                }
                
                zombieLocation = CLLocation(latitude: Double(roundedLatitude)!, longitude: Double(roundedLongitude)!)
                
                /* randomly create an angle to position zombie's marker */
                
                theta = Double(Float(arc4random_uniform(UInt32.max))/Float(UInt32.max-1) * Float.pi * 2.0)
                
                distance = location.distance(from: zombieLocation)
            }
            /* zombie's location cannot be too close to the player. If otherwise, create a new one */
                
            while distance <= distanceLimit
            
            /* create zombies' markers */
            
            let radius = distance/5
            
            let x = Float(radius) * Float(cos(theta))
            let y = Float(radius) * Float(sin(theta))
            
            zombies[i][0] = CGPoint(x: CGFloat(x) + focalPoint.x, y: CGFloat(y) + focalPoint.y) as AnyObject
            zombies[i][1] = theta as AnyObject
            zombies[i][2] = 100 as AnyObject
        }
        return zombies
    }
    
    func createMarkers(counter: Int, from: [[AnyObject]], place: UIView) -> [UIButton]
    {
        var markers = [UIButton]()
        
        for i in 0..<counter
        {
            markers.append(UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20)))
         
            markers[i].center = from[i][0] as! CGPoint
            markers[i].setImage(#imageLiteral(resourceName: "filledCircle"), for: .normal)
            markers[i].tag = i
            place.addSubview(markers[i])
            markers[i].addTarget(self, action: #selector(Game3ViewController.shoot),for: .touchUpInside)
        }
        return markers
    }
    
    func placeBox(focalPoint: CGPoint, place: UIView) -> UIView
    {
        let radius = UIScreen.main.bounds.width - focalPoint.x
        let theta = Double(Float(arc4random_uniform(UInt32.max))/Float(UInt32.max-1) * Float.pi * 2.0)
        
        let area = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        area.center = CGPoint(x: radius * CGFloat(cos(theta)) + focalPoint.x, y: radius * CGFloat(sin(theta)) + focalPoint.y)
        
        area.layer.cornerRadius = area.frame.size.width/2
        area.clipsToBounds = true
        area.backgroundColor = UIColor.blue
        area.alpha = 0.3
        place.addSubview(area)
        
        return area
    }
}
