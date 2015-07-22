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


class Money: NSManagedObject {

    @NSManaged var value: NSNumber

    static func getClassName() -> String{
        return "Money"
    }
    
    static func createMoneyWithValue(inValue: Float) -> Money
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext! = appDelegate.managedObjectContext
        
        var newMoney: Money = NSEntityDescription.insertNewObjectForEntityForName(self.getClassName(), inManagedObjectContext: managedObjectContext) as! Money
        
        newMoney.value = inValue
        
        return newMoney
    }
    
    
    static func loadMoney()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext: NSManagedObjectContext! = appDelegate.managedObjectContext
        
        // Create the error pointer
        var err: NSErrorPointer = nil
        
        var fetchRequest = NSFetchRequest(entityName: self.getClassName())
        
        var moneys:NSArray! = managedObjectContext.executeFetchRequest(fetchRequest, error: err)
        
        if(moneys.count == 0){
            
            println("array Vazio")
            
        }else{
            
            for index in 0...moneys.count-1
            {
                let debt = moneys[index] as! Money
                println(debt)
            }
        }
    }
}
