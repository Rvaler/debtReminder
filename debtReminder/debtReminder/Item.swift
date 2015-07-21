//
//  Item.swift
//  
//
//  Created by Rafael Valer on 7/21/15.
//
//

import Foundation
import CoreData

@objc(Item)

class Item: NSManagedObject {

    @NSManaged var itemImage: NSData
    @NSManaged var itemName: String

}
