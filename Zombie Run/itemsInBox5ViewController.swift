//
//  itemsInBox5ViewController.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 11.09.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit

class itemsInBox5ViewController: UIViewController, UITableViewDataSource,
UITableViewDelegate
{
    var zombies = [[AnyObject]]()
    
    var slots: [[Int]] = Array(repeating:Array(repeating:0, count:2), count:10)
    var equipment: [[Int]] = Array(repeating:Array(repeating:0, count:2), count:5)

    var START:Int = 1

    var temp: [Int] = [0, 0]
    var luck = 0
        
    let sections: [String] = ["Box", "Inventory"]
    var s1Data: [UIImage] = []
    var s2Data: [UIImage] = []
    
    let highChance:[[Int]] = [[1,20], [2,2], [3,10], [4,2], [4,6], [5,2], [6,2], [6,20], [7,1], [7,2], [7,3], [7,8], [8,1], [8,2], [8,3], [8,5]]
    let mediumChance:[[Int]] = [[1,40], [1,60], [1,80], [2,10], [3,20], [3,30], [3,40], [4,8], [4,10], [5,15], [6,30], [6,60], [8,4], [8,10], [7,4], [7,8], [7,16], [7,24], [9,3], [9,5]]
    let smallChance:[[Int]] = [[1,100], [1,150], [1,200], [2,20], [3,50], [4,20], [5,20], [6,100], [7,4], [7,32]]
    
    let sectionsImages: [UIImage] = [#imageLiteral(resourceName: "blackBox"), #imageLiteral(resourceName: "blackBag")]
    
    var sectionData: [[UIImage]] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        (slots, START) = backpackMemory().loadBackpack(from: "Slots", load: slots, isSTART: START)
        
        if START == 1
        {
            /* BACKPACK HASN'T BEEN OPENED YET */
            
            slots[0][0] = 1
            slots[0][1] = 20
            /* slot1, type gun, 20 HP damage */

            slots[1][0] = 6
            slots[1][1] = 30
            /* slot2, type painkiller, 30 HP recovery*/

            slots[2][0] = 6
            slots[2][1] = 30
            /* slot3, type painkiller, 30 HP recovery*/

            slots[3][0] = 7
            slots[3][1] = 4
            /* slot4, type ammo, 4 small bullets */
            
            /* FOR TEST REASONS ONLY */

            slots[4][0] = 1
            slots[4][1] = 200
            /* slot5, type gun, 200 HP damage, wide range */

            slots[5][0] = 1
            slots[5][1] = 100
            /* slot6, type gun, 100 HP damage, wide range */

            slots[6][0] = 1
            slots[6][1] = 60
            /* slot7, type gun, 60HP damage */
            
            slots[7][0] = 7
            slots[7][1] = 32
            /* slot8, type ammo, 32 big bullets */
            
            slots[8][0] = 7
            slots[8][1] = 4
            /* slot9, type ammo, 4 small bullets */
            
            backpackMemory().saveBackpack(to: "Slots", save: slots)
            backpackMemory().saveBackpack(to: "Equipment", save: equipment)
        }
            /* print("slots: ", slots)
            print("") */
        
            for i in 0..<slots.count
            {
                if itemRecognise().setUIImage(type: slots[i][0], value: slots[i][1]) != #imageLiteral(resourceName: "grid")
                {
                    s2Data.append(itemRecognise().setUIImage(type: slots[i][0], value: slots[i][1]))
                    print(slots[i][0], slots[i][0])
                }
                
                if slots[i][0] == 9
                {
                    luck = luck + slots[i][1]
                }
            }
        
        randomizeItem()
        
        tableView.isEditing = true
        tableView.delegate = self
        tableView.dataSource = self
        
        sectionData = [s1Data, s2Data]
    }
    
    /* TABLE FUNCTIONS */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
            return (sectionData[section].count)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let view = UIView()
        view.backgroundColor = UIColor.red
        let image = UIImageView(image: sectionsImages[section])
        image.frame = CGRect(x: 5, y: 7.5, width: 30, height: 30)
        view.addSubview(image)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            
            if cell == nil
            {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
            }
        
            cell?.imageView?.image = sectionData[indexPath.section][indexPath.row]
        
            return cell!
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath:IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        if sourceIndexPath.section == 0 && destinationIndexPath.section == 0
        {
            let item = sectionData[0][sourceIndexPath.row]
            sectionData[0].remove(at: sourceIndexPath.row)
            sectionData[0].insert(item, at: destinationIndexPath.row)
        }
        
        else if sourceIndexPath.section == 0 && destinationIndexPath.section == 1
        {
            let item = sectionData[0][sourceIndexPath.row]
            sectionData[0].remove(at: sourceIndexPath.row)
            sectionData[1].insert(item, at: destinationIndexPath.row)
        }
        
        else if sourceIndexPath.section == 1 && destinationIndexPath.section == 0
        {
            let item = sectionData[1][sourceIndexPath.row]
            sectionData[1].remove(at: sourceIndexPath.row)
            sectionData[0].insert(item, at: destinationIndexPath.row)
        }
        
        else if sourceIndexPath.section == 1 && destinationIndexPath.section == 1
        {
            let item = sectionData[1][sourceIndexPath.row]
            sectionData[1].remove(at: sourceIndexPath.row)
            sectionData[1].insert(item, at: destinationIndexPath.row)
        }
        
        else
        {
            print("ERROR - SWAP MALFUNCTION")
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        return .none
    }
    
    /* PICK-A-RANDOM-ITEM FUNCTION */
    
    func randomizeItem()
    {
        let percent = Int(arc4random_uniform(100))
        
        /* switch percent
        {
        case 0...(60-luck):
            var i = Int(arc4random_uniform(UInt32(highChance.count)))
            if i == 0
            {
                i = 1
            }
            s1Data.append(itemRecognise().imageItem(type: highChance[i-1][0], value: highChance[i-1][1]))
            
        case (61-luck)...(94-luck):
            var i = Int(arc4random_uniform(UInt32(mediumChance.count)))
            if i == 0
            {
                i = 1
            }
            s1Data.append(itemRecognise().imageItem(type: mediumChance[i-1][0], value: mediumChance[i-1][1]))
 
        case (95-luck)...100:
            var i = Int(arc4random_uniform(UInt32(highChance.count)))
            if i == 0
            {
                i = 1
            }
            s1Data.append(itemRecognise().imageItem(type: smallChance[i-1][0], value: smallChance[i-1][1]))

        default:
            break
        } */
        
        if percent > 0 && percent <= (60-luck)
        {
            let i = Int(arc4random_uniform(17))
            s1Data.append(itemRecognise().setUIImage(type: highChance[i][0], value: highChance[i][1]))
        }
        else if percent > (60-luck) && percent <= (94-luck)
        {
            let i = Int(arc4random_uniform(19))
            s1Data.append(itemRecognise().setUIImage(type: mediumChance[i][0], value: mediumChance[i][1]))
        }
        else if percent > (94-luck) && percent <= 100
        {
            let i = Int(arc4random_uniform(10))
            s1Data.append(itemRecognise().setUIImage(type: smallChance[i][0], value: smallChance[i][1]))
        }
    }
    
    /* ALERT FUNCTION */
    
    func createAlert(title: String, message: String)
    {
        let alert = UIAlertController(title:title, message:message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil) } ))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /* ACTIONS */
    
    @IBAction func collectAndPlay(_ sender: Any)
    {
        /* print(sectionData[0].count)
        print(sectionData[1].count) */
        
        if sectionData[1].count <= 10
        {
            for i in 0..<sectionData[1].count
            {
                temp = itemRecognise().setSlot(item: sectionData[1][i])
                slots[i] = temp
            }
            if (sectionData[1].count) <= slots.count
            {
                for i in (sectionData[1].count)..<slots.count
                {
                    slots[i] = [0,0]
                }
            }
            if sectionData[1].count == 0
            {
                slots[0] = [0,0]
            }
            for i in 0..<slots.count
            {
                backpackMemory().reloadBackpack(what: "Slots", reload: slots, I: i)
            }
            performSegue(withIdentifier: "unwindItems", sender: self)
        }
        else if sectionData[1].count > slots.count
        {
            createAlert(title: "You can't carry more items!", message: "Your inventory is full. If you want to get rid of uneccessary items, put them in the box")
        }
    }
    
    /* OUTLETS */
    
    @IBOutlet weak var tableView: UITableView!
}

