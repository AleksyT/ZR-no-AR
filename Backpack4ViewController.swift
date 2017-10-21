//
//  Backpack4ViewController.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 08.08.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class Backpack4ViewController: UIViewController
{
    /* VARIABLES */
    
    var START:Int = 1
    
    /* 2D Array [10][2]
     
     10 -> positions of slots; (0-9 indices)
     2 -> [0] - TYPE , [1] - VALUE; (0-1 indices)
     */
    
    /* TYPE would mean that 1 holds a gun,
     ...2 - helmet
     ...3 - armor
     ...4 - footwear
     ...5 - gloves
     ...6 - painkiller
     ...7 - ammo
     ...8 - food
     ...9 - talisman
     
     ...0 - nothing (empty slot/grid)
     */
    
    /* VALUE being the number of damage/healing/protection/luck points or amount of ammo
     
     */
    var slots: [[Int]] = Array(repeating:Array(repeating:0, count:2), count:10)
    
    /* 2D Array [5][2]
     
     5 -> positions of equipment; (0-4 indices)
     2 -> [0] - 0/1 TYPE , [1] - DAMAGE/PROTECTION POINTS; (0-1 indices) */
    var equipment: [[Int]] = Array(repeating:Array(repeating:0, count:2), count:5)
    
    var zombies = [[AnyObject]]()
    
    var HOLD = Int() /* No. of slot that is held/being moved */
    var originPointSlot = CGPoint()
    var originPointEquipment = CGPoint()
    
    var isSlot = Int()
    var isEquipment = Int()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        (equipment, START) = backpackMemory().loadBackpack(from: "Equipment", load: equipment, isSTART: START)
        for i in 0..<UIEquipment.count
        {
            UIEquipment[i] = itemRecognise().setUIButton(type: equipment[i][0], value: equipment[i][1], item: UIEquipment[i])
        }
        
        (slots, START) = backpackMemory().loadBackpack(from: "Slots", load: slots, isSTART: START)
        for i in 0..<UISlots.count
        {
            UISlots[i] = itemRecognise().setUIButton(type: slots[i][0], value: slots[i][1], item: UISlots[i])
        }

        if START == 1
        {
            firstStart()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    /* START FUNCTION */
 
    func firstStart()
    {
        UISlots[0].setImage(#imageLiteral(resourceName: "pistol"), for: .normal)
        UISlots[0].tag = 1 /* tag = type for UI */
        slots[0][0] = 1
        slots[0][1] = 20
        /* slot1, type gun, 20 HP damage */
        
        UISlots[1].setImage(#imageLiteral(resourceName: "painkiller"), for: .normal)
        UISlots[1].tag = 6 /* tag = type for UI */
        slots[1][0] = 6
        slots[1][1] = 30
        /* slot2, type painkiller, 30 HP recovery*/
        
        UISlots[2].setImage(#imageLiteral(resourceName: "painkiller"), for: .normal)
        UISlots[2].tag = 6 /* tag = type for UI */
        slots[2][0] = 6
        slots[2][1] = 30
        /* slot3, type painkiller, 30 HP recovery*/
        
        UISlots[3].setImage(#imageLiteral(resourceName: "pistolAmmo4"), for: .normal)
        UISlots[3].tag = 7 /* tag = type for UI */
        slots[3][0] = 7
        slots[3][1] = 4
        /* slot4, type ammo, 4 small bullets */
        
        /* FOR TEST REASONS ONLY */
        
        UISlots[4].setImage(#imageLiteral(resourceName: "rpg"), for: .normal)
        UISlots[4].tag = 1 /* tag = type for UI */
        slots[4][0] = 1
        slots[4][1] = 200
        /* slot5, type gun, 200 HP damage, wide range */
        
        UISlots[5].setImage(#imageLiteral(resourceName: "grenade"), for: .normal)
        UISlots[5].tag = 1 /* tag = type for UI */
        slots[5][0] = 1
        slots[5][1] = 100
        /* slot6, type gun, 100 HP damage, wide range */
        
        UISlots[6].setImage(#imageLiteral(resourceName: "rifle"), for: .normal)
        UISlots[6].tag = 1 /* tag = type for UI */
        slots[6][0] = 1
        slots[6][1] = 60
        /* slot7, type gun, 60HP damage */
        
        UISlots[7].setImage(#imageLiteral(resourceName: "rifleAmmo4"), for: .normal)
        UISlots[7].tag = 7 /* tag = type for UI */
        slots[7][0] = 7
        slots[7][1] = 32
        /* slot8, type ammo, 32 big bullets */
        
        UISlots[8].setImage(#imageLiteral(resourceName: "pistolAmmo4"), for: .normal)
        UISlots[8].tag = 7 /* tag = type for UI */
        slots[8][0] = 7
        slots[8][1] = 4
        /* slot9, type ammo, 4 small bullets */
        
        backpackMemory().saveBackpack(to: "Slots", save: slots)
        backpackMemory().saveBackpack(to: "Equipment", save: equipment)
    }
    
    /* ITEM MOVEMENT */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        let position = touch?.location(in: self.view)
        
        for i in 0..<UISlots.count /* item in slots is touched */
        {
            if (UISlots[i].frame.contains(position!) == true && UISlots[i].tag != 0)
            {
                UISlots[i].alpha = 0.7
                HOLD = i
                originPointSlot = UISlots[i].center
                isSlot = 1
                isEquipment = 0
                
                showItemValue(type: slots[HOLD][0], value: slots[HOLD][1])
            }
        }
        
        for i in 0..<UIEquipment.count /* item in equipment is touched */
        {
            if (UIEquipment[i].frame.contains(position!) == true && UIEquipment[i].tag != 0)
            {
                UIEquipment[i].alpha = 0.7
                HOLD = i
                originPointEquipment = UIEquipment[i].center
                isSlot = 0
                isEquipment = 1
                
                showItemValue(type: equipment[HOLD][0], value: equipment[HOLD][1])
            }
        }
        
        if isSlot == 0 && isEquipment == 0
        {
            /* print("ERROR - NEITHER SLOT NOR EQUIPMENT WAS TOUCHED DOWN") */
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        let position = touch?.location(in: self.view)
        
        if isSlot == 1 && isEquipment == 0
        {
            if (UISlots[HOLD].frame.contains(position!) == true && UISlots[HOLD].tag != 0)
            {
                UISlots[HOLD].center = position!
            }
        }
        
        else if isSlot == 0 && isEquipment == 1
        {
            if (UIEquipment[HOLD].frame.contains(position!) == true && UIEquipment[HOLD].tag != 0)
            {
                UIEquipment[HOLD].center = position!
            }
        }
            
        else
        {
            /* print("ERROR - NEITHER SLOT NOR EQUIPMENT WAS MOVED") */
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        var DRAG_BACK:Int = 1
        
        itemValue.text = ""
        
        if isSlot == 1 && isEquipment == 0
        {
            /* EQUIP */
            
            for i in 0..<UIEquipment.count /* if situation */
                /* slot's item is dragged to it's corresponding equipment */
            {
                if (UISlots[HOLD].frame.intersects(UIEquipment[i].frame) && UISlots[HOLD].tag == i+1)
                    /* item i (UIEquipment[i]) must be type no. i+1/tag no. i+1.  For example: gun (so UIEquipment[0]) must be type no. 1/tag no. 1 (see types) */
                {
                    UISlots[HOLD].alpha = 1
                    fromSlotToEquipment(slotNo: HOLD, equipmentNo: i)
                    DRAG_BACK = 0
                }
            }
            /* CHANGE SLOT */

            for i in 0..<UISlots.count /* else if situation */
                /* slot's item is dragged to another empty slot */
            {
                if UISlots[HOLD].frame.intersects(UISlots[i].frame) && UISlots[HOLD].tag != 0 && UISlots[i].tag == 0 &&
                    !(UISlots[HOLD].frame==UISlots[i].frame)
                {
                    UISlots[HOLD].alpha = 1
                    fromSlotToSlot(slotNo: HOLD, newSlotNo: i)
                    DRAG_BACK = 0
                }
            }
            /* EQUIP/CHANGE SLOT IS NOT FULFILLED - DRAG BACK TO SLOT */
            
                if DRAG_BACK == 1 /* else situation */
                {
                    UISlots[HOLD].alpha = 1
                    UIView.animate(withDuration: 0.3, animations: {
                        self.UISlots[self.HOLD].center = self.originPointSlot
                    })
                }
        }
        
        else if isSlot == 0 && isEquipment == 1
        {
            /* UNEQUIP */
            
            for i in 0..<UISlots.count /* if situation */
            {
                if (UIEquipment[HOLD].frame.intersects(UISlots[i].frame) && UISlots[i].tag == 0)
                    /* equipped item can be dragged back only to empty slot */
                {
                    UIEquipment[HOLD].alpha = 1
                    fromEquipmentToSlot(slotNo: i, equipmentNo: HOLD)
                }
            }
            /* UNEQUIP IS NOT FULFILLED - DRAG BACK TO EQUIPMENT */
            
            for i in 0..<UISlots.count /* else situation */
            {
                if !(UIEquipment[HOLD].frame.intersects(UISlots[i].frame) && UISlots[i].tag == 0)
                {
                    UIEquipment[HOLD].alpha = 1
                    UIView.animate(withDuration: 0.3, animations: {
                        self.UIEquipment[self.HOLD].center = self.originPointEquipment
                    })
                }
            }
        }
            
        else
        {
            /* print("ERROR - NEITHER SLOT NOR EQUIPMENT WAS BOTH TOUCHED DOWN AND/OR MOVED AND RELEASED") */
        }
    }
    
    /* ITEM DISPLACEMENT */
    
    func fromSlotToEquipment(slotNo: Int, equipmentNo: Int)
    {
        UIEquipment[equipmentNo].setImage(UISlots[slotNo].currentImage, for: .normal)
        UIEquipment[equipmentNo].tag = UISlots[slotNo].tag
        
        equipment[equipmentNo][0] = slots[slotNo][0] /* type */
        equipment[equipmentNo][1] = slots[slotNo][1] /* value */
        
        UISlots[slotNo].alpha = 0
        originPointEquipment = UIEquipment[equipmentNo].center
        UISlots[slotNo].center = self.originPointSlot
        UISlots[slotNo].setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        UISlots[slotNo].alpha = 1
        UISlots[slotNo].tag = 0
        
        slots[slotNo][0] = 0
        slots[slotNo][1] = 0
        
        /* print("slots: ", slots)
        print("equipment: ", equipment)
        print("") */
        
        backpackMemory().reloadBackpack(what: "Equipment", reload: equipment, I: equipmentNo)
        backpackMemory().reloadBackpack(what: "Slots", reload: slots, I: slotNo)
        player().playSound(title: "itemDrop", format: "wav")
    }
    
    func fromSlotToSlot(slotNo: Int, newSlotNo: Int)
    {
        UISlots[newSlotNo].setImage(UISlots[slotNo].currentImage, for: .normal)
        UISlots[newSlotNo].tag = UISlots[slotNo].tag
        
        slots[newSlotNo][0] = slots[slotNo][0]
        slots[newSlotNo][1] = slots[slotNo][1]
        
        UISlots[slotNo].alpha = 0
        UISlots[slotNo].center = self.originPointSlot
        UISlots[slotNo].setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        UISlots[slotNo].alpha = 1
        UISlots[slotNo].tag = 0
        
        slots[slotNo][0] = 0
        slots[slotNo][1] = 0
        
        /* print("slots: ", slots)
        print("equipment: ", equipment)
        print("") */
        
        backpackMemory().reloadBackpack(what: "Slots", reload: slots, I: newSlotNo)
        backpackMemory().reloadBackpack(what: "Slots", reload: slots, I: slotNo)
        player().playSound(title: "itemDrop", format: "wav")    }
    
    func fromEquipmentToSlot(slotNo: Int, equipmentNo: Int)
    {
        UISlots[slotNo].setImage(UIEquipment[equipmentNo].currentImage, for: .normal)
        /* (slotNo: i, equipmentNo: HOLD) */
        UISlots[slotNo].tag = UIEquipment[equipmentNo].tag
        
        slots[slotNo][0] = UIEquipment[equipmentNo].tag /* type */
        slots[slotNo][1] = equipment[equipmentNo][1] /* value */
        
        UIEquipment[equipmentNo].alpha = 0
        UIEquipment[equipmentNo].center = self.originPointEquipment
        
        switch equipmentNo
        {
        case 0:
            UIEquipment[equipmentNo].setImage(#imageLiteral(resourceName: "weapon"), for: .normal)
        case 1:
            UIEquipment[equipmentNo].setImage(#imageLiteral(resourceName: "hat"), for: .normal)

        case 2:
            UIEquipment[equipmentNo].setImage(#imageLiteral(resourceName: "torso"), for: .normal)

        case 3:
            UIEquipment[equipmentNo].setImage(#imageLiteral(resourceName: "feet"), for: .normal)

        case 4:
            UIEquipment[equipmentNo].setImage(#imageLiteral(resourceName: "hands"), for: .normal)
        default:
            break
        }
        
        UIEquipment[equipmentNo].alpha = 1
        UIEquipment[equipmentNo].tag = 0
        
        equipment[equipmentNo][0] = 0
        equipment[equipmentNo][1] = 0
        
        /* print("slots: ", slots)
        print("equipment: ", equipment)
        print("") */
        
        backpackMemory().reloadBackpack(what: "Equipment", reload: equipment, I: equipmentNo)
        backpackMemory().reloadBackpack(what: "Slots", reload: slots, I: slotNo)
        player().playSound(title: "itemDrop", format: "wav")
    }
    
    func showItemValue(type: Int, value: Int)
    {
        var smallBullets:Int = 0
        var bigBullets:Int = 0
        
        for i in 0..<slots.count
        {
            if slots[i][0] == 7
            {
                if slots[i][1] > 0 && slots[i][1] <= 4
                {
                    smallBullets = smallBullets + slots[i][1]
                }
                if slots[i][1] > 8 && slots[i][1] <= 32
                {
                    bigBullets = bigBullets + slots[i][1]
                }
            }
        }
        switch type
        {
        case 1:
            if value == 20 || value == 80
            {
                itemValue.text = "Damage: " + String(value) + " points. " + "Bullets: " + String(smallBullets) + "/1"
            }
            else if value == 40 || value == 60 || value == 150
            {
                itemValue.text = "Damage: " + String(value) + " points. " + "Bullets: " + String(bigBullets) + "/8"
            }
            else
            {
                itemValue.text = "Damage: " + String(value) + " points"
            }
        case 2...5:
            itemValue.text = "Defense: " + String(value) + " points"
        case 6:
            itemValue.text = "Healing: " + String(value) + " points"
        case 7:
            itemValue.text = "Ammo: " + String(value) + " bullets"
        case 8:
            itemValue.text = "Healing: " + String(value) + " points"
        case 9:
            itemValue.text = "Luck: " + String(value) + " points"
        default:
            break
        }
    }
    
    /* ACTIONS */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "unwindToGame"
        {
            let Game3 = segue.destination as! Game3ViewController
            Game3.zombies = zombies
            Game3.slots = slots
            Game3.equipment = equipment
        }
    }
    
    /* OUTLETS */

    @IBOutlet var UIEquipment: [UIButton]!
    @IBOutlet var UISlots: [UIButton]!
    @IBOutlet weak var itemValue: UILabel!
}
