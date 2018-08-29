//
//  Item.swift
//  Todoey
//
//  Created by user on 8/24/18.
//  Copyright © 2018 Bradley Carter. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    //create Inverse Relationship
    var parentCateogry = LinkingObjects(fromType: Category.self, property: "items")
}
