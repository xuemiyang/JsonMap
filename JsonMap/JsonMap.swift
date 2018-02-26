//
//  JsonMap.swift
//  yzyx
//
//  Created by TCLios2 on 2017/9/27.
//  Copyright © 2017年 TCLios2. All rights reserved.
//

import Foundation

private struct EncodingType:  OptionSet {
    var rawValue: UInt
    
    init() {
        self.init(rawValue: 0)
    }
    
    typealias RawValue = UInt
    
    init(rawValue: EncodingType.RawValue) {
        self.rawValue = rawValue
    }
    
    static func ==(lhs: EncodingType, rhs: EncodingType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    mutating func formUnion(_ other: EncodingType) {
        rawValue |= other.rawValue
    }
    
    mutating func formIntersection(_ other: EncodingType) {
        rawValue &= other.rawValue
    }
    
    mutating func formSymmetricDifference(_ other: EncodingType) {
        rawValue ^= other.rawValue
    }
    ///< unknown
    static var unknown: EncodingType {
        return .init(rawValue: 0)
    }
    ///< void
    static var void: EncodingType {
        return .init(rawValue: 1 << 0)
    }
    ///< bool
    static var bool: EncodingType {
        return .init(rawValue: 1 << 1)
    }
    ///< char / BOOL
    static var int8: EncodingType {
        return .init(rawValue: 1 << 2)
    }
    ///< unsigned char
    static var uint8: EncodingType {
        return .init(rawValue: 1 << 3)
    }
    ///< short
    static var int16: EncodingType {
        return .init(rawValue: 1 << 4)
    }
    ///< unsigned short
    static var uint16: EncodingType {
        return .init(rawValue: 1 << 5)
    }
    ///< int
    static var int32: EncodingType {
        return .init(rawValue: 1 << 6)
    }
    ///< unsigned int
    static var uint32: EncodingType {
        return .init(rawValue: 1 << 7)
    }
    ///< long long
    static var int64: EncodingType {
        return .init(rawValue: 1 << 8)
    }
    ///< unsigned long long
    static var uint64: EncodingType {
        return .init(rawValue: 1 << 9)
    }
    ///< float
    static var float: EncodingType {
        return .init(rawValue: 1 << 10)
    }
    ///< double
    static var double: EncodingType {
        return .init(rawValue: 1 << 11)
    }
    ///< long double
    static var longDouble: EncodingType {
        return .init(rawValue: 1 << 12)
    }
    ///< id
    static var object: EncodingType {
        return .init(rawValue: 1 << 13)
    }
    ///< Class
    static var Class: EncodingType {
        return .init(rawValue: 1 << 14)
    }
    ///< SEL
    static var sel: EncodingType {
        return .init(rawValue: 1 << 15)
    }
    ///< block
    static var block: EncodingType {
        return .init(rawValue: 1 << 16)
    }
    ///< void*
    static var pointer: EncodingType {
        return .init(rawValue: 1 << 17)
    }
    ///< struct
    static var Struct: EncodingType {
        return .init(rawValue: 1 << 18)
    }
    ///< union
    static var union: EncodingType {
        return .init(rawValue: 1 << 19)
    }
    ///< char*
    static var cString: EncodingType {
        return .init(rawValue: 1 << 20)
    }
    ///< char[10] (for example)
    static var cArray: EncodingType {
        return .init(rawValue: 1 << 21)
    }
    ///< const
    static var qualifierConst: EncodingType {
        return .init(rawValue: 1 << 22)
    }
    ///< in
    static var qualifierIn: EncodingType {
        return .init(rawValue: 1 << 23)
    }
    ///< inout
    static var qualifierInout: EncodingType {
        return .init(rawValue: 1 << 24)
    }
    ///< out
    static var qualifierOut: EncodingType {
        return .init(rawValue: 1 << 25)
    }
    ///< bycopy
    static var qualifierBycopy: EncodingType {
        return .init(rawValue: 1 << 26)
    }
    ///< byref
    static var qualifierByref: EncodingType {
        return .init(rawValue: 1 << 27)
    }
    ///< oneway
    static var qualifierOneway: EncodingType {
        return .init(rawValue: 1 << 28)
    }
    ///< readonly
    static var propertyReadonly: EncodingType {
        return .init(rawValue: 1 << 29)
    }
    ///< copy
    static var propertyCopy: EncodingType {
        return .init(rawValue: 1 << 30)
    }
    ///< retain
    static var propertyRetain: EncodingType {
        return .init(rawValue: 1 << 31)
    }
    ///< nonatomic
    static var propertyNonatomic: EncodingType {
        return .init(rawValue: 1 << 32)
    }
    ///< weak
    static var propertyWeak: EncodingType {
        return .init(rawValue: 1 << 33)
    }
    ///< getter=
    static var propertyCustomGetter: EncodingType {
        return .init(rawValue: 1 << 34)
    }
    ///< setter=
    static var propertyCustomSetter: EncodingType {
        return .init(rawValue: 1 << 35)
    }
    ///< @dynamic
    static var propertyDynamic: EncodingType {
        return .init(rawValue: 1 << 36)
    }
}

extension EncodingType {
    static func encodingType(value: String) -> EncodingType {
        var typeCharacters = Substring.init(value)
        var qualifier = EncodingType.unknown;
        var prefix = true
        while prefix {
            if let ch = typeCharacters.first {
                switch ch {
                case "r":
                    qualifier.formUnion(.qualifierConst)
                    let _ = typeCharacters.popFirst()
                case "n":
                    qualifier.formUnion(.qualifierIn)
                    let _ = typeCharacters.popFirst()
                case "N":
                    qualifier.formUnion(.qualifierInout)
                    let _ = typeCharacters.popFirst()
                case "o":
                    qualifier.formUnion(.qualifierOut)
                    let _ = typeCharacters.popFirst()
                case "O":
                    qualifier.formUnion(.qualifierBycopy)
                    let _ = typeCharacters.popFirst()
                case "R":
                    qualifier.formUnion(.qualifierByref)
                    let _ = typeCharacters.popFirst()
                case "V":
                    qualifier.formUnion(.qualifierOneway)
                    let _ = typeCharacters.popFirst()
                default:
                    prefix = false
                }
            }
        }
        if let ch = typeCharacters.popFirst() {
            switch ch {
            case "v":
                qualifier.formUnion(.void)
            case "B":
                qualifier.formUnion(.bool)
            case "c":
                qualifier.formUnion(.int8)
            case "C":
                qualifier.formUnion(.uint8)
            case "s":
                qualifier.formUnion(.int16)
            case "S":
                qualifier.formUnion(.uint16)
            case "i":
                qualifier.formUnion(.int32)
            case "I":
                qualifier.formUnion(.uint32)
            case "l":
                qualifier.formUnion(.int32)
            case "L":
                qualifier.formUnion(.uint32)
            case "q":
                qualifier.formUnion(.int64)
            case "Q":
                qualifier.formUnion(.uint64)
            case "f":
                qualifier.formUnion(.float)
            case "d":
                qualifier.formUnion(.double)
            case "D":
                qualifier.formUnion(.longDouble)
            case "#":
                qualifier.formUnion(.Class)
            case ":":
                qualifier.formUnion(.sel)
            case "*":
                qualifier.formUnion(.cString)
            case "^":
                qualifier.formUnion(.pointer)
            case "[":
                qualifier.formUnion(.cArray)
            case "(":
                qualifier.formUnion(.union)
            case "{":
                qualifier.formUnion(.Struct)
            case "@":
                if typeCharacters.count == 1 && typeCharacters.first! == "?" {
                    qualifier.formUnion(.block)
                } else {
                    qualifier.formUnion(.object)
                }
            default:
                qualifier.formUnion(.unknown)
            }
        } else {
            qualifier.formUnion(.unknown)
        }
        return qualifier
    }
}


private struct JsonProperty {
    var name = ""
    var type = EncodingType.unknown
    var cls: AnyClass?
    var protocols: [String] = []
    var ivarName = ""
    var isNSType: Bool {
        if type.contains(.object) {
            if let _cls = cls {
                if _cls.isSubclass(of: NSMutableString.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSString.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSDecimalNumber.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSNumber.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSValue.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSMutableData.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSData.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSDate.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSURL.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSMutableArray.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSArray.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSMutableDictionary.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSDictionary.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSMutableSet.classForCoder()) {
                    return true
                }
                if _cls.isSubclass(of: NSSet.classForCoder()) {
                    return true
                }
            }
        }
        return false
    }
    var arrClass: AnyClass?
    
    func canSetValue(_ value: Any?, forKey key: String, forObj obj: NSObject) -> (Bool, Any?) {
        if type.contains(.bool) {
            if let str = value as? String {
                if let b = Bool.init(str) {
                    return (true, b)
                }
            }
            if let intV = value as? Int {
                return (true, intV == 1)
            }
            return (value is Bool, value)
        }
        if type.contains(.int8) {
            if let str = value as? String {
                if let i = Int8.init(str) {
                    return (true, i)
                }
            }
            return (value is Int8, value)
        }
        if type.contains(.uint8) {
            if let str = value as? String {
                if let i = UInt8.init(str) {
                    return (true, i)
                }
            }
            return (value is UInt8, value)
        }
        if type.contains(.int16) {
            if let str = value as? String {
                if let i = Int16.init(str) {
                    return (true, i)
                }
            }
            return (value is Int16, value)
        }
        if type.contains(.uint16) {
            if let str = value as? String {
                if let i = UInt16.init(str) {
                    return (true, i)
                }
            }
            return (value is UInt16, value)
        }
        if type.contains(.int32) {
            if let str = value as? String {
                if let i = Int32.init(str) {
                    return (true, i)
                }
            }
            return (value is Int32, value)
        }
        if type.contains(.uint32) {
            if let str = value as? String {
                if let i = UInt32.init(str) {
                    return (true, i)
                }
            }
            return (value is UInt32, value)
        }
        if type.contains(.int64) {
            if let str = value as? String {
                if let i = Int64.init(str) {
                    return (true, i)
                } else if let i = Int.init(str) {
                    return (true, i)
                }
            }
            return (value is Int64 || value is Int, value)
        }
        if type.contains(.uint64) {
            if let str = value as? String {
                if let i = UInt64.init(str) {
                    return (true, i)
                }
            }
            return (value is UInt64, value)
        }
        if type.contains(.float) {
            if let str = value as? String {
                if let f = Float.init(str) {
                    return (true, f)
                }
            }
            return (value is Float, value)
        }
        if type.contains(.double) {
            if let str = value as? String {
                if let d = Double.init(str) {
                    return (true, d)
                }
            }
            return (value is Double, value)
        }
        if type.contains(.longDouble) {
            if let str = value as? String {
                if let f = Float64.init(str) {
                    return (true, f)
                }
            }
            return (value is Float64, value)
        }
        if type.contains(.object) && cls != nil {
            if isNSType {
                if cls!.isSubclass(of: NSString.classForCoder()) {
                    if let obj = value {
                        return (true, String.init(describing: obj))
                    }
                } else if cls!.isSubclass(of: NSArray.classForCoder()) {
                    if let arr = value as? [[String:Any]] {
                        if let cls = arrClass as? NSObject.Type {
                            var rArr: [NSObject] = []
                            for dict in arr {
                                let obj = cls.init()
                                if let obj = obj as? JsonMap {
                                    obj.setMapValuesForKeys(dict)
                                } else {
                                    obj.setValuesForKeys(dict)
                                }
                                rArr.append(obj)
                            }
                            return (true, rArr)
                        }
                    }
                } else if let obj = value as? NSObject {
                    return (obj.isKind(of: cls!), value)
                }
            } else if cls != nil {
                if let dict = value as? [String:Any] {
                    if let obj = obj.value(forKey: name) as? NSObject {
                        obj.setValuesForKeys(dict)
                        return (true, obj)
                    } else if let cls = cls as? NSObject.Type {
                        let obj = cls.init()
                        obj.setValuesForKeys(dict)
                        return (true, obj)
                    }
                } else if let obj = value as? NSObject {
                    return (obj.isKind(of: cls!), value)
                }
            }
        }
        return (true, value)
    }
}

class JsonMap: NSObject {
    
    private struct JsonClass {
        static var propertys: [String:[String:JsonProperty]] = [:]
    }
    
    fileprivate var propertys: [String:JsonProperty] {
        if let className = _className {
            guard JsonClass.propertys[className] == nil else {
                return JsonClass.propertys[className]!
            }
        }
        var propertys = [String:JsonProperty]()
        var cls: AnyClass? = classForCoder
        while cls != nil && cls!.isSubclass(of: JsonMap.self)  {
            var outCount: UInt32 = 0
            let ps = class_copyPropertyList(cls, &outCount)
            var rawP = ps
            for _ in 0..<outCount {
                var property = JsonProperty.init()
                guard rawP?.pointee != nil else {
                    continue
                }
                let p = rawP!.pointee
                let cname = property_getName(p)
                let str = String.init(cString: cname)
                if blacklist.contains(str) {
                    continue
                }
                property.name = str
                var _outCount: UInt32 = 0
                let atts = property_copyAttributeList(p, &_outCount)
                var rawA = atts
                for _ in 0..<_outCount {
                    if let att = rawA?.pointee {
                        let name = String.init(cString: att.name)
                        let value = String.init(cString: att.value)
                        if name == "T" {
                            property.type = EncodingType.encodingType(value: value)
                            if property.type.contains(.object) {
                                let scanner = Scanner.init(string: value)
                                guard scanner.scanString("@\"", into: nil) else {
                                    continue
                                }
                                var clsName: NSString?
                                if scanner.scanUpToCharacters(from: CharacterSet.init(charactersIn: "\"<"), into: &clsName) {
                                    if clsName != nil && clsName!.length > 0 {
                                        let str = clsName! as String
                                        property.cls = NSClassFromString(str)
                                    }
                                }
                                while scanner.scanString("<", into: nil) {
                                    var protocolName: NSString?
                                    if scanner.scanUpTo(">", into: &protocolName) {
                                        if protocolName != nil && protocolName!.length > 0 {
                                            property.protocols.append(protocolName!.substring(from: 0))
                                        }
                                        scanner.scanString(">", into: nil)
                                    }
                                }
                            }
                        } else if name == "V" {
                            property.ivarName = value
                        } else if name == "R" {
                            property.type.formUnion(.propertyReadonly)
                        } else if name == "C" {
                            property.type.formUnion(.propertyCopy)
                        } else if name == "&" {
                            property.type.formUnion(.propertyRetain)
                        } else if name == "N" {
                            property.type.formUnion(.propertyNonatomic)
                        } else if name == "D" {
                            property.type.formUnion(.propertyDynamic)
                        } else if name == "W" {
                            property.type.formUnion(.propertyWeak)
                        } else if name == "G" {
                            property.type.formUnion(.propertyCustomGetter)
                        } else if name == "S" {
                            property.type.formUnion(.propertyCustomSetter)
                        }
                        property.arrClass = arrClasses[property.name]
                    }
                    rawA = rawA?.successor()
                }
                free(atts)
                rawP = rawP?.successor()
                propertys[property.name] = property
            }
            free(ps)
            cls = class_getSuperclass(cls)
        }
        if let className = _className {
            JsonClass.propertys[className] = propertys
        }
        return propertys
    }
    
    required override init() {
        super.init()
    }
    
    var arrClasses: [String:AnyClass] {
        return [:]
    }
    
    var blacklist: [String] {
        return []
    }
    
    class func map(dict: Any?) -> [String:Any]? {
        if let rDict = dict as? [String:Any] {
            return rDict
        }
        return nil
    }
    
    private class func map(arr: Any?) -> [[String:Any]]? {
        if let arr = arr as? [[String:Any]] {
            var rArr = [[String:Any]]()
            for dict in arr {
                if let rDict = map(dict: dict) {
                    rArr.append(rDict)
                }
            }
            return rArr
        }
        return nil
    }
}

extension JsonMap {
    func setMapValuesForKeys(_ dict: Any?) {
        if let type = classForCoder as? JsonMap.Type {
            if let mapDict = type.map(dict: dict) {
                setValuesForKeys(mapDict)
            }
        }
    }
    
    class func mapToObjs(arr: Any?) -> [JsonMap]? {
        if let mapArr = map(arr: arr) {
            var objs = [JsonMap]()
            for dict in mapArr {
                let obj = self.init()
                obj.setValuesForKeys(dict)
                objs.append(obj)
            }
            return objs
        }
        return nil
    }
    
    class func mapToObj(dict: Any?) -> JsonMap? {
        if let mapDict = map(dict: dict) {
            let obj = self.init()
            obj.setValuesForKeys(mapDict)
            return obj
        }
        return nil
    }
    
    func keyValues() -> [String:Any] {
        var dict = [String:Any].init(minimumCapacity: propertys.count)
        for property in propertys {
            dict[property.key] = value(forKey: property.key)
        }
        return dict
    }
    
    func setValuesForObj(_ obj: JsonMap) {
        let dict = obj.keyValues()
        setValuesForKeys(dict)
    }
    
}

extension JsonMap {
    override func setValue(_ value: Any?, forKey key: String) {
        guard value != nil else {
            return
        }
        
        if let property = propertys[key] {
            let result = property.canSetValue(value, forKey: key, forObj: self)
            if result.0 {
                super.setValue(result.1, forKey: key)
            } else {
                print("setValue fail value=\(String(describing: value)), key=\(key)")
            }
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func value(forUndefinedKey key: String) -> Any? {
        
        return nil
    }
}
