//
//  Category.swift
//  Todoey
//
//  Created by user on 8/24/18.
//  Copyright © 2018 Bradley Carter. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    
}
