//
//  LendBorrow.swift
//  debtReminder
//
//  Created by Rafael Valer on 7/22/15.
//  Copyright (c) 2015 RafaelValer. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class LendBorrow: NSManagedObject {

    @NSManaged var reminder: NSDate
    @NSManaged var toFromWho: String
    @NSManaged var debtFlag: NSNumber // TRUE = borrowing, FALSE = lending
    @NSManaged var relationItem: Item
    @NSManaged var relationMoney: Money

    static func getClassName() -> String{
        return "LendBorrow"
    }
    
    static func createDebtWithItem(item: Item?, money: Money?, inToFromWho: String, inReminder: NSDate?, inDebt: Bool){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext! = appDelegate.managedObjectContext
        
        var newDebt: LendBorrow = NSEntityDescription.insertNewObjectForEntityForName(self.getClassName(), inManagedObjectContext: managedObjectContext) as! LendBorrow
        
        newDebt.debtFlag = inDebt
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
    
    static func loadDebts() -> NSArray?
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext! = appDelegate.managedObjectContext
        
        // Create the error pointer
        var err: NSErrorPointer = nil
        
        var fetchRequest = NSFetchRequest(entityName: self.getClassName())
        var debtsArray:NSArray? = managedObjectContext.executeFetchRequest(fetchRequest, error: err)
        
        if let debts = debtsArray
        {
            return debts
        }else{
            println("array vazio")
            return nil
        }
    }
}
