//
//  LendBorrow.swift
//  
//
//  Created by Rafael Valer on 7/21/15.
//
//

import Foundation
import CoreData
import UIKit

@objc(LendBorrow)

class LendBorrow: NSManagedObject {

    @NSManaged var toFromWho: String
    @NSManaged var reminder: NSDate
    @NSManaged var relationItem: Item
    @NSManaged var relationMoney: Money
    
    static func getClassName() -> String{
        return "LendBorrow"
    }
    
    static func createDebtWithItem(item: Item?, money: Money?, inToFromWho: String, inReminder: NSDate?){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext! = appDelegate.managedObjectContext
        
        var newDebt: LendBorrow = NSEntityDescription.insertNewObjectForEntityForName(self.getClassName(), inManagedObjectContext: managedObjectContext) as! LendBorrow
        
        newDebt.toFromWho = inToFromWho
        if let newDebtReminder = inReminder {
            newDebt.reminder = newDebtReminder
        }
        
        if let newDebtItem = item {
            newDebt.relationItem = newDebtItem
        }
        else if let newDebtMoney = money {
            newDebt.relationMoney = newDebtMoney
        }
        
        var err:NSErrorPointer = nil
        let fetchRequest = NSFetchRequest(entityName: self.getClassName())
        managedObjectContext.save(err)
        
    }
    
}
