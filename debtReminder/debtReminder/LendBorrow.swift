//
//  LendBorrow.swift
//  
//
//  Created by Rafael Valer on 7/21/15.
//
//

import Foundation
import CoreData

@objc(LendBorrow)

class LendBorrow: NSManagedObject {

    @NSManaged var toFromWho: String
    @NSManaged var reminder: NSDate
    @NSManaged var relationItem: Item
    @NSManaged var relationMoney: Money

}
