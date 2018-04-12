//
//  Item.swift
//  Todo Tomorrow
//
//  Created by Ryan Vaught on 4/10/18.
//  Copyright © 2018 Ryan Vaught. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
//For a class to be encodable; all of its properties must be of standard data types.
    var title: String = ""
    var done: Bool = false
}
