//
//  Shape.swift
//  LearningSwift
//
//  Created by AEF-RD-1 on 16/1/12.
//  Copyright © 2016年 yim. All rights reserved.
//

import UIKit

class NameShape: NSObject {

    var numberOfSides = 0
    var sName:String
    
    //构造器--初始化类的实例
    init(name:String) {
        self.sName = name
    }
    
    //自己写的方法
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}


//创建一个 NameShape 的子类

class Square: NameShape {
    
    var sideLength :Double = 0.0
    
    init(length:Double, name: String) {
        self.sideLength = length
        super.init(name: name)
        numberOfSides = 4
    }
    
    
    func area () -> String {
        
        return "A square with sides of length \(sideLength) area is:\(sideLength * sideLength)"
    }
    
    
    //重写父类方法
    override func simpleDescription() -> String {
        
        return "A square with sides of length \(sideLength)."
    }
    
}


class EquilateralTriangle: NameShape {
    var sideLength:Double = 0.0

    //构造器
    /**
    方法执行了3步
    1. 设置子类声明的属性值
    2. 调用父类的构造器
    3. 改变父类定义的属性值。其他的工作比如调用方法、getters和setters也可以在这个阶段完成。
    
    */
    
    /**
     *  如果你不需要计算属性，但是仍然需要在设置一个新值之前或者之后运行代码，使用willSet和didSet。
     *  比如：TriangleAndSquare 类确保三角形的边长总是和正方形的边长相同。
     */
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    
    //
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    //
    override func simpleDescription() -> String {
        
        return "An equilateral triagle with sides of length \(sideLength)."
    }
    
}


class TriangleAndSquare {
    
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(length: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
    
    
}











