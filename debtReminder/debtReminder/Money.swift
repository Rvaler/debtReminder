//
//  Money.swift
//  
//
//  Created by Rafael Valer on 7/21/15.
//
//

import Foundation
import CoreData
import UIKit

@objc(Money)

class Money: NSManagedObject {

    @NSManaged var value: NSNumber

    static func getClassName() -> String{
        return "Money"
    }
    
    static func createMoneyWithValue(inValue: Float)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext! = appDelegate.managedObjectContext
        
        var newMoney: Money = NSEntityDescription.insertNewObjectForEntityForName(self.getClassName(), inManagedObjectContext: managedObjectContext) as! Money
        
        newMoney.value = inValue
        var err:NSErrorPointer = nil
        let fetchRequest = NSFetchRequest(entityName: self.getClassName())
        managedObjectContext.save(err)
    }
}
