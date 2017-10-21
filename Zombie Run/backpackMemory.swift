//
//  backpackMemory.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 28.09.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit
import CoreData

class backpackMemory
{
    func loadBackpack(from: String, load: [[Int]], isSTART: Int) -> ([[Int]], Int)
    {
        var items:[[Int]] = load
        var START:Int = isSTART

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
    
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: from)
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request)
    
            if results.count > 0
            {
                for results in results as! [NSManagedObject]
                {
                    if let i = results.value(forKey: "i"), let type = results.value(forKey: "type") as? Int16, let value = results.value(forKey: "value") as? Int16
                    {
                        items[i as! Int][0] = Int(type)
                        items[i as! Int][1] = Int(value)
                    }
                }
                print(from, " WAS FETCHED: ")
                START = 0
                print(items)
            }
        }
        catch
        {
            print("ERROR - COULDN'T FETCH DATA")
        }
        
        return (items, START)
    }
    
    func reloadBackpack(what: String, reload: [[Int]], I:Int)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: what)
        request.returnsObjectsAsFaults = false
                
        do
        {
            let results = try context.fetch(request)
            
            if results.count > 0
            {
                for results in results as! [NSManagedObject]
                {
                    if let i = results.value(forKey: "i")
                    {
                        if i as! Int == I
                        {
                            results.setValue(reload[I][0], forKey: "type")
                            results.setValue(reload[I][1], forKey: "value")
                            
                            do
                            {
                                try context.save()
                            }
                                
                            catch
                            {
                                print("ERROR - COULDN'T SAVE ", what)
                            }
                        }
                    }
                }
                print(what, " HAS CHANGED:")
                print(reload)
            }
        }
        catch
        {
            print("ERROR - COULDN'T FETCH DATA")
        }
    }
    
    func saveBackpack(to: String, save: [[Int]])
    {
        for i in 0..<save.count
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let saved = NSEntityDescription.insertNewObject(forEntityName: to, into: context)
            
            saved.setValue(i, forKey: "i")
            saved.setValue(save[i][0], forKey: "type")
            saved.setValue(save[i][1], forKey: "value")
            
            do
            {
                try context.save()
            }
                
            catch
            {
                print("ERROR - COULDN'T SAVE ", to)
            }
        }
        
        print("NEW ", to, ": ")
        print(save)
    }
}
