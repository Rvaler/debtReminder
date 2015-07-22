//
//  Item.swift
//  
//
//  Created by Rafael Valer on 7/21/15.
//
//

import Foundation
import CoreData
import UIKit


class Item: NSManagedObject {

    @NSManaged var itemImage: NSData
    @NSManaged var itemName: String

    static func getClassName() -> String{
        return "Item"
    }
    
    static func createItemWithName(inName: String, inImage: NSData?) -> Item
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext! = appDelegate.managedObjectContext
        
        var newItem: Item = NSEntityDescription.insertNewObjectForEntityForName(self.getClassName(), inManagedObjectContext: managedObjectContext) as! Item
        
        newItem.itemName = inName
        if let newItemImage = inImage{
            newItem.itemImage = newItemImage
        }
    
        return newItem
//        var err:NSErrorPointer = nil
//        let fetchRequest = NSFetchRequest(entityName: self.getClassName())
//        managedObjectContext.save(err)
    }
    
}
