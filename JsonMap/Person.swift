//
//  Person.swift
//  JsonMap
//
//  Created by TCLios2 on 2018/2/26.
//  Copyright © 2018年 TCLios2. All rights reserved.
//

import UIKit

class Person: JsonMap {
    @objc var name = ""
    @objc var age = 0
    
    override var description: String {
        return super.description + " name=" + name + " age=" + "\(age)"
    }
}

class CustomMapPerson: Person {
    override class func map(dict: Any?) -> [String:Any]? {
        if var dict = super.map(dict: dict) {
            if let name = dict["name"] as? String {
                dict["name"] = "my name is " + name
            }
            if let age = dict["age"] as? Int {
                dict["age"] = 10 + age
            }
            return dict
        }
        return nil
    }
}

class MapKeysPerson: Person {
    override class var mapKeys: [String:String] {
        return ["name":"myName", "age":"myAge"]
    }
}

class BlacklistPerson: Person {
    override class var blacklist: [String] {
        return ["age"]
    }
}

class WhitelistPerson: Person {
    override class var whitelist: [String] {
        return ["age"]
    }
}

class House: JsonMap {
    @objc var address = ""
    @objc var area = 0
    override var description: String {
        return super.description + " address=" + address + " area=" + "\(area)"
    }
}

class ArrayHousePerson: Person {
    @objc var houses: [House] = []
    override class var arrClasses: [String : AnyClass] {
        return ["houses":House.classForCoder()]
    }
    override var description: String {
        return super.description + " houses=" + "\(houses)"
    }
}

class ArrayPerson: Person {
    @objc var numbers: [Int] = []
    override var description: String {
        return super.description + " numbers=" + "\(numbers)"
    }
}

class HousePerson: Person {
    @objc var house: House?
    override var description: String {
        return super.description + " house=" + String.init(describing: house)
    }
}

class DictionaryPerson: Person {
    @objc var info: [String:Any] = [:]
    override var description: String {
        return super.description + " info=" + "\(info)"
    }
}




