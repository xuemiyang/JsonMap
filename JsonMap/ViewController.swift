//
//  ViewController.swift
//  JsonMap
//
//  Created by TCLios2 on 2018/2/26.
//  Copyright © 2018年 TCLios2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var dict : [String : Any] = ["name":"jack", "age": 10]
        if let person = Person.mapToObj(dict: dict) {
            print("--dict mapToObj--")
            print("dict = %@", dict)
            print(person)
            print()
        }
        
        var arr : [[String : Any]] = [["name":"tom", "age":19], ["name":"rose", "age": 17]]
        if let persons = Person.mapToObjs(arr: arr) {
            print("--arr mapToObjs--")
            print("arr = %@", arr)
            print(persons)
            print()
        }
        
        var person = Person()
        person.name = "myName"
        person.age = 35
        let keyValue = person.keyValues()
        print("--keyValues--")
        print(person)
        print("keyValue = %@", keyValue)
        print()
        
        dict = ["name":"111", "age": 100]
        person = Person()
        person.setMapValuesForKeys(dict)
        print("--setMapValuesForKeys--")
        print("dict = %@", dict)
        print(person)
        print()
        
        dict = ["name2":"222", "age2":5];
        if let person = CustomMapPerson.mapToObj(dict: dict) {
            print("--CustomMapPerson--")
            print("dict = %@", dict)
            print(person)
            print()
        }
        
        dict = ["name":"333", "age":90]
        if let person = BlacklistPerson.mapToObj(dict: dict) {
            print("--BlacklistPerson--")
            print("dict = %@", dict)
            print(person)
            print()
        }
        
        dict = ["name":"888", "age":467]
        if let person = WhitelistPerson.mapToObj(dict: dict) {
            print("--WhitelistPerson--")
            print("dict = %@", dict)
            print(person)
            print()
        }
        
        arr = [["address":"xxx", "area":100], ["address":"yyy", "area":200]]
        dict = ["name":"ming", "age":13, "houses":arr]
        if let person = ArrayHousePerson.mapToObj(dict: dict) {
            print("--ArrayHousePerson--")
            print("dict = %@", dict)
            print(person)
            print()
        }
        
        dict = ["name":"ling", "age":11, "numbers":[1,2,3]]
        if let person = ArrayPerson.mapToObj(dict: dict) {
            print("--ArrayPerson--")
            print("dict = %@", dict)
            print(person)
            print()
        }
        
        dict = ["name":"ying", "age":19, "house":["address":"nnb", "area":170]]
        if let person = HousePerson.mapToObj(dict: dict) {
            print("--HousePerson--")
            print("dict = %@", dict)
            print(person)
            print()
        }
        
        dict = ["name":"ping", "age":27, "info":["string":"bbbb", "double":19.7]]
        if let person = DictionaryPerson.mapToObj(dict: dict) {
            print("--DictionaryPerson--")
            print("dict = %@", dict)
            print(person)
            print()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

