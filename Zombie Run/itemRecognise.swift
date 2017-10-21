//
//  itemRecognise.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 27.08.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit

class itemRecognise
{
    func setUIButton(type: Int, value: Int, item: UIButton) -> UIButton
    {
        if type == 1 && value == 20 /* WEAPONS */
        {
            item.setImage(#imageLiteral(resourceName: "pistol"), for: .normal)
            item.tag = type
        }
        else if type == 1 && value == 40
        {
            item.setImage(#imageLiteral(resourceName: "machineGun"), for: .normal)
            item.tag = type
        }
        else if type == 1 && value == 60
        {
            item.setImage(#imageLiteral(resourceName: "rifle"), for: .normal)
            item.tag = type
        }
        else if type == 1 && value == 80
        {
            item.setImage(#imageLiteral(resourceName: "sniperRifle"), for: .normal)
            item.tag = type
        }
        else if type == 1 && value == 100
        {
            item.setImage(#imageLiteral(resourceName: "grenade"), for: .normal)
            item.tag = type
        }
        else if type == 1 && value == 150
        {
            item.setImage(#imageLiteral(resourceName: "gatlingGun"), for: .normal)
            item.tag = type
        }
        else if type == 1 && value == 200
        {
            item.setImage(#imageLiteral(resourceName: "rpg"), for: .normal)
            item.tag = type
        }
        else if type == 2 && value == 2 /* HELMETS */
        {
            item.setImage(#imageLiteral(resourceName: "beanie"), for: .normal)
            item.tag = type
        }
        else if type == 2 && value == 10
        {
            item.setImage(#imageLiteral(resourceName: "motorbikeHelmet"), for: .normal)
            item.tag = type
        }
        else if type == 2 && value == 20
        {
            item.setImage(#imageLiteral(resourceName: "armoredHelmet"), for: .normal)
            item.tag = type
        }
        else if type == 3 && value == 10 /* ARMORS */
        {
            item.setImage(#imageLiteral(resourceName: "fabricClothing"), for: .normal)
            item.tag = type
        }
        else if type == 3 && value == 20
        {
            item.setImage(#imageLiteral(resourceName: "reinforcedFabricClothing"), for: .normal)
            item.tag = type
        }
        else if type == 3 && value == 30
        {
            item.setImage(#imageLiteral(resourceName: "stealthSuit"), for: .normal)
            item.tag = type
        }
        else if type == 3 && value == 40
        {
            item.setImage(#imageLiteral(resourceName: "tacticalSuit"), for: .normal)
            item.tag = type
        }
        else if type == 3 && value == 50
        {
            item.setImage(#imageLiteral(resourceName: "armoredTacticalSuit"), for: .normal)
            item.tag = type
        }
        else if type == 4 && value == 2 /* FOOTWEAR */
        {
            item.setImage(#imageLiteral(resourceName: "flipFlops"), for: .normal)
            item.tag = type
        }
        else if type == 4 && value == 6
        {
            item.setImage(#imageLiteral(resourceName: "shoes"), for: .normal)
            item.tag = type
        }
        else if type == 4 && value == 8
        {
            item.setImage(#imageLiteral(resourceName: "trainers"), for: .normal)
            item.tag = type
        }
        else if type == 4 && value == 10
        {
            item.setImage(#imageLiteral(resourceName: "boots"), for: .normal)
            item.tag = type
        }
        else if type == 4 && value == 20
        {
            item.setImage(#imageLiteral(resourceName: "armoredBoots"), for: .normal)
            item.tag = type
        }
        else if type == 5 && value == 2 /* GLOVES */
        {
            item.setImage(#imageLiteral(resourceName: "mittens"), for: .normal)
            item.tag = type
        }
        else if type == 5 && value == 15
        {
            item.setImage(#imageLiteral(resourceName: "gauntletGloves"), for: .normal)
            item.tag = type
        }
        else if type == 5 && value == 20
        {
            item.setImage(#imageLiteral(resourceName: "armoredGauntletGloves"), for: .normal)
            item.tag = type
        }
        else if type == 6 && value == 2 /* PAINKILLER */
        {
            item.setImage(#imageLiteral(resourceName: "plaster"), for: .normal)
            item.tag = type
        }
        else if type == 6 && value == 20
        {
            item.setImage(#imageLiteral(resourceName: "pill"), for: .normal)
            item.tag = type
        }
        else if type == 6 && value == 30
        {
            item.setImage(#imageLiteral(resourceName: "painkiller"), for: .normal)
            item.tag = type
        }
        else if type == 6 && value == 60
        {
            item.setImage(#imageLiteral(resourceName: "megaPainkiller"), for: .normal)
            item.tag = type
        }
        else if type == 6 && value == 100
        {
            item.setImage(#imageLiteral(resourceName: "medicalBag"), for: .normal)
            item.tag = type
        }
        else if type == 7 && value == 1 /* AMMO - SMALL BULLETS (LIGHT GUNS) */
        {
            item.setImage(#imageLiteral(resourceName: "pistolAmmo"), for: .normal)
            item.tag = type
        }
        else if type == 7 && value == 2
        {
            item.setImage(#imageLiteral(resourceName: "pistolAmmo2"), for: .normal)
            item.tag = type
        }
        else if type == 7 && value == 3
        {
            item.setImage(#imageLiteral(resourceName: "pistolAmmo3"), for: .normal)
            item.tag = type
        }
        else if type == 7 && value == 4
        {
            item.setImage(#imageLiteral(resourceName: "pistolAmmo4"), for: .normal)
            item.tag = type
        }
        else if type == 7 && value == 8 /* AMMO - BIG BULLETS (HEAVY GUNS) */
        {
            item.setImage(#imageLiteral(resourceName: "rifleAmmo"), for: .normal)
            item.tag = type
        }
        else if type == 7 && value == 16
        {
            item.setImage(#imageLiteral(resourceName: "rifleAmmo2"), for: .normal)
            item.tag = type
        }
        else if type == 7 && value == 24
        {
            item.setImage(#imageLiteral(resourceName: "rifleAmmo3"), for: .normal)
            item.tag = type
        }
        else if type == 7 && value == 32
        {
            item.setImage(#imageLiteral(resourceName: "rifleAmmo4"), for: .normal)
            item.tag = type
        }
        else if type == 8 && value == 1 /* FOOD */
        {
            item.setImage(#imageLiteral(resourceName: "coke"), for: .normal)
            item.tag = type
        }
        else if type == 8 && value == 2
        {
            item.setImage(#imageLiteral(resourceName: "beer"), for: .normal)
            item.tag = type
        }
        else if type == 8 && value == 3
        {
            item.setImage(#imageLiteral(resourceName: "cherries"), for: .normal)
            item.tag = type
        }
        else if type == 8 && value == 4
        {
            item.setImage(#imageLiteral(resourceName: "cheese"), for: .normal)
            item.tag = type
        }
        else if type == 8 && value == 5
        {
            item.setImage(#imageLiteral(resourceName: "soda"), for: .normal)
            item.tag = type
        }
        else if type == 8 && value == 10
        {
            item.setImage(#imageLiteral(resourceName: "baguette"), for: .normal)
            item.tag = type
        }
        else if type == 9 && value == 3 /* TALISMAN */
        {
            item.setImage(#imageLiteral(resourceName: "maneki"), for: .normal)
            item.tag = type
        }
        else if type == 9 && value == 5
        {
            item.setImage(#imageLiteral(resourceName: "dreamcatcher"), for: .normal)
            item.tag = type
        }
        /* else if type == 0 && value == 0 /* EMPTY SLOT */
        {
            item.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
            item.tag = type
        } */
        return item
    }
    
    func setUIImage(type: Int, value: Int) -> UIImage
    {
        var image = UIImage()
        
        if type == 1 && value == 20 /* WEAPONS */
        {
            image = #imageLiteral(resourceName: "pistol")
        }
        else if type == 1 && value == 40
        {
            image = #imageLiteral(resourceName: "machineGun")
        }
        else if type == 1 && value == 60
        {
            image = #imageLiteral(resourceName: "rifle")
        }
        else if type == 1 && value == 80
        {
            image = #imageLiteral(resourceName: "sniperRifle")
        }
        else if type == 1 && value == 100
        {
            image = #imageLiteral(resourceName: "grenade")
        }
        else if type == 1 && value == 150
        {
            image = #imageLiteral(resourceName: "gatlingGun")
        }
        else if type == 1 && value == 200
        {
            image = #imageLiteral(resourceName: "rpg")
        }
        else if type == 2 && value == 2 /* HELMETS */
        {
            image = #imageLiteral(resourceName: "beanie")
        }
        else if type == 2 && value == 10
        {
            image = #imageLiteral(resourceName: "motorbikeHelmet")
        }
        else if type == 2 && value == 20
        {
            image = #imageLiteral(resourceName: "armoredHelmet")
        }
        else if type == 3 && value == 10 /* ARMORS */
        {
            image = #imageLiteral(resourceName: "fabricClothing")
        }
        else if type == 3 && value == 20
        {
            image = #imageLiteral(resourceName: "reinforcedFabricClothing")
        }
        else if type == 3 && value == 30
        {
            image = #imageLiteral(resourceName: "stealthSuit")
        }
        else if type == 3 && value == 40
        {
            image = #imageLiteral(resourceName: "tacticalSuit")
        }
        else if type == 3 && value == 50
        {
            image = #imageLiteral(resourceName: "armoredTacticalSuit")
        }
        else if type == 4 && value == 2 /* FOOTWEAR */
        {
            image = #imageLiteral(resourceName: "flipFlops")
        }
        else if type == 4 && value == 6
        {
            image = #imageLiteral(resourceName: "shoes")
        }
        else if type == 4 && value == 8
        {
            image = #imageLiteral(resourceName: "trainers")
        }
        else if type == 4 && value == 10
        {
            image = #imageLiteral(resourceName: "boots")
        }
        else if type == 4 && value == 20
        {
            image = #imageLiteral(resourceName: "armoredBoots")
        }
        else if type == 5 && value == 2 /* GLOVES */
        {
            image = #imageLiteral(resourceName: "mittens")
        }
        else if type == 5 && value == 15
        {
            image = #imageLiteral(resourceName: "gauntletGloves")
        }
        else if type == 5 && value == 20
        {
            image = #imageLiteral(resourceName: "armoredGauntletGloves")
        }
        else if type == 6 && value == 2 /* PAINKILLER */
        {
            image = #imageLiteral(resourceName: "plaster")
        }
        else if type == 6 && value == 20
        {
            image = #imageLiteral(resourceName: "pill")
        }
        else if type == 6 && value == 30
        {
            image = #imageLiteral(resourceName: "painkiller")
        }
        else if type == 6 && value == 60
        {
            image = #imageLiteral(resourceName: "megaPainkiller")
        }
        else if type == 6 && value == 100
        {
            image = #imageLiteral(resourceName: "medicalBag")
        }
        else if type == 7 && value == 1 /* AMMO - SMALL BULLETS (LIGHT GUNS) */
        {
            image = #imageLiteral(resourceName: "pistolAmmo")
        }
        else if type == 7 && value == 2
        {
            image = #imageLiteral(resourceName: "pistolAmmo2")
        }
        else if type == 7 && value == 3
        {
            image = #imageLiteral(resourceName: "pistolAmmo3")
        }
        else if type == 7 && value == 4
        {
            image = #imageLiteral(resourceName: "pistolAmmo4")
        }
        else if type == 7 && value == 8 /* AMMO - BIG BULLETS (HEAVY GUNS) */
        {
            image = #imageLiteral(resourceName: "rifleAmmo")
        }
        else if type == 7 && value == 16
        {
            image = #imageLiteral(resourceName: "rifleAmmo2")
        }
        else if type == 7 && value == 24
        {
            image = #imageLiteral(resourceName: "rifleAmmo3")
        }
        else if type == 7 && value == 32
        {
            image = #imageLiteral(resourceName: "rifleAmmo4")
        }
        else if type == 8 && value == 1 /* FOOD */
        {
            image = #imageLiteral(resourceName: "coke")
        }
        else if type == 8 && value == 2
        {
            image = #imageLiteral(resourceName: "beer")
        }
        else if type == 8 && value == 3
        {
            image = #imageLiteral(resourceName: "cherries")
        }
        else if type == 8 && value == 4
        {
            image = #imageLiteral(resourceName: "cheese")
        }
        else if type == 8 && value == 5
        {
            image = #imageLiteral(resourceName: "soda")
        }
        else if type == 8 && value == 10
        {
            image = #imageLiteral(resourceName: "baguette")
        }
        else if type == 9 && value == 3 /* TALISMAN */
        {
            image = #imageLiteral(resourceName: "maneki")
        }
        else if type == 9 && value == 5
        {
            image = #imageLiteral(resourceName: "dreamcatcher")
        }
        else if type == 0 && value == 0
        {
            image = #imageLiteral(resourceName: "grid")
        }
        return image
    }
   
    func setSlot(item: UIImage) -> [Int]
    {
        var typeAndValue: [Int] = [0, 0]
        
        if item == UIImage(named: "pistol.png") /* WEAPONS */
        {
            typeAndValue = [1, 20]
        }
        else if item == UIImage(named: "machingeGun.png")
        {
            typeAndValue = [1, 40]
        }
        else if item == UIImage(named: "rifle.png")
        {
            typeAndValue = [1, 60]
        }
        else if item == UIImage(named: "sniperRifle.png")
        {
            typeAndValue = [1, 80]
        }
        else if item == UIImage(named: "grenade.png")
        {
            typeAndValue = [1, 100]
        }
        else if item == UIImage(named: "gatlingGun.png")
        {
            typeAndValue = [1, 150]
        }
        else if item == UIImage(named: "rpg.png")
        {
            typeAndValue = [1, 200]
        }
        else if item == UIImage(named: "beanie.png") /* HELMETS */
        {
            typeAndValue = [2, 2]
        }
        else if item == UIImage(named: "motorbikeHelmet.png")
        {
            typeAndValue = [2, 10]
        }
        else if item == UIImage(named: "armoredHelmet.png")
        {
            typeAndValue = [2, 20]
        }
        else if item == UIImage(named: "fabricClothing.png") /* ARMOR */
        {
            typeAndValue = [3, 10]
        }
        else if item == UIImage(named: "reinforcedFabricClothing.png")
        {
            typeAndValue = [3, 20]
        }
        else if item == UIImage(named: "stealthSuit.png")
        {
            typeAndValue = [3, 30]
        }
        else if item == UIImage(named: "tacticalSuit.png")
        {
            typeAndValue = [3, 40]
        }
        else if item == UIImage(named: "armoredTacticalSuit.png")
        {
            typeAndValue = [3, 50]
        }
        else if item == UIImage(named: "flipFlops.png") /* FOOTWEAR */
        {
            typeAndValue = [4, 2]
        }
        else if item == UIImage(named: "shoes.png")
        {
            typeAndValue = [4, 6]
        }
        else if item == UIImage(named: "trainers.png")
        {
            typeAndValue = [4, 8]
        }
        else if item == UIImage(named: "boots.png")
        {
            typeAndValue = [4, 10]
        }
        else if item == UIImage(named: "armoredBoots.png")
        {
            typeAndValue = [4, 20]
        }
        else if item == UIImage(named: "mittens.png") /* GLOVES */
        {
            typeAndValue = [5, 2]
        }
        else if item == UIImage(named: "gauntletGloves.png")
        {
            typeAndValue = [5, 15]
        }
        else if item == UIImage(named: "armoredGauntletGloves.png")
        {
            typeAndValue = [5, 20]
        }
        else if item == UIImage(named: "plaster.png") /* PAINKILLER */
        {
            typeAndValue = [6, 2]
        }
        else if item == UIImage(named: "pill.png")
        {
            typeAndValue = [6, 20]
        }
        else if item == UIImage(named: "painkiller.png")
        {
            typeAndValue = [6, 30]
        }
        else if item == UIImage(named: "megaPainkiller.png")
        {
            typeAndValue = [6, 60]
        }
        else if item == UIImage(named: "medicalBag.png")
        {
            typeAndValue = [6, 100]
        }
        else if item == UIImage(named: "pistolAmmo.png") /* AMMO - SMALL BULLETS (LIGHT GUNS) */
        {
            typeAndValue = [7, 1]
        }
        else if item == UIImage(named: "pistolAmmo2.png")
        {
            typeAndValue = [7, 2]
        }
        else if item == UIImage(named: "pistolAmmo3.png")
        {
            typeAndValue = [7, 3]
        }
        else if item == UIImage(named: "pistolAmmo4.png")
        {
            typeAndValue = [7, 4]
        }
        else if item == UIImage(named: "rifleAmmo.png") /* AMMO - BIG BULLETS (HEAVY GUNS) */
        {
            typeAndValue = [7, 8]
        }
        else if item == UIImage(named: "rifleAmmo2.png")
        {
            typeAndValue = [7, 16]
        }
        else if item == UIImage(named: "rifleAmmo3.png")
        {
            typeAndValue = [7, 24]
        }
        else if item == UIImage(named: "rifleAmmo4.png")
        {
            typeAndValue = [7, 32]
        }
        else if item == UIImage(named: "coke.png") /* FOOD */
        {
            typeAndValue = [8, 1]
        }
        else if item == UIImage(named: "beer.png")
        {
            typeAndValue = [8, 2]
        }
        else if item == UIImage(named: "cherries.png")
        {
            typeAndValue = [8, 3]
        }
        else if item == UIImage(named: "cheese.png")
        {
            typeAndValue = [8, 4]
        }
        else if item == UIImage(named: "soda.png")
        {
            typeAndValue = [8, 5]
        }
        else if item == UIImage(named: "baguette.png")
        {
            typeAndValue = [8, 10]
        }
        else if item == UIImage(named: "maneki.png") /* TALISMAN */
        {
            typeAndValue = [9, 3]
        }
        else if item == UIImage(named: "dreamcatcher.png")
        {
            typeAndValue = [9, 5]
        }
        
        return typeAndValue
    }
}
