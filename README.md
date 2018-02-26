# JsonMap
swift json对象和模型转换工具类

## 定义JsonMap实体类
```swift
class Person: JsonMap {
    @objc var name = ""
    @objc var age = 0

    override var description: String {
        return super.description + " name=" + name + " age=" + "\(age)"
    }
}
```
注意：JsonMap使用OC的runtime机制进行映射，在swift4.0需要指定哪些属性可以桥接到OC类，你只要在属性前添加@objc标识即可。

## JsonMap的简单使用
### 字典转模型
```swift
let dict : [String : Any] = ["name":"jack", "age": 10]
if let person = Person.mapToObj(dict: dict) {
    print("--dict mapToObj--")
    print("dict = %@", dict)
    print(person)
}
```

### 数组转模型数组
```swift
let arr : [[String : Any]] = [["name":"tom", "age":19], ["name":"rose", "age": 17]]
if let persons = Person.mapToObjs(arr: arr) {
    print("--arr mapToObjs--")
    print("arr = %@", arr)
    print(persons)
}
```

### 模型转字典
```swift
let person = Person()
person.name = "myName"
person.age = 35
let keyValue = person.keyValues()
print("--keyValues--")
print(person)
print("keyValue = %@", keyValue)
```

### 字典赋值
```swift
let dict = ["name":"111", "age": 100]
let person = Person()
person.setMapValuesForKeys(dict)
print("--setMapValuesForKeys--")
print("dict = %@", dict)
print(person)
```

### 自定义映射
```swift
class CustomMapPerson: Person {
    override class func map(dict: Any?) -> [String:Any]? {
        if var dict = super.map(dict: dict) {
            if let name2 = dict["name2"] as? String {
                dict["name"] = "my name is " + name2
            }
            if let age2 = dict["age2"] as? Int {
                dict["age"] = 10 + age2
            }
            return dict
        }
        return nil
    }
}
```
```swift
let dict = ["name2":"222", "age2":5];
if let person = CustomMapPerson.mapToObj(dict: dict) {
    print("--CustomMapPerson--")
    print("dict = %@", dict)
    print(person)
}
```

### 黑名单
```swift
class BlacklistPerson: Person {
    override var blacklist: [String] {
        return ["age"]
    }
}
```
```swift
let dict = ["name":"333", "age":90]
if let person = BlacklistPerson.mapToObj(dict: dict) {
    print("--BlacklistPerson--")
    print("dict = %@", dict)
    print(person)
}
```

### 模型数组属性
```swift
class House: JsonMap {
    @objc var address = ""
    @objc var area = 0
    override var description: String {
        return super.description + " address=" + address + " area=" + "\(area)"
    }
}

class ArrayHousePerson: Person {
    @objc var houses: [House] = []
    override var arrClasses: [String : AnyClass] {
        return ["houses":House.classForCoder()]
    }
    override var description: String {
        return super.description + " houses=" + "\(houses)"
    }
}
```
```swift
let arr = [["address":"xxx", "area":100], ["address":"yyy", "area":200]]
let dict = ["name":"ming", "age":13, "houses":arr]
if let person = ArrayHousePerson.mapToObj(dict: dict) {
    print("--ArrayHousePerson--")
    print("dict = %@", dict)
    print(person)
}
```




