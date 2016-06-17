//
//  ViewController.swift
//  LearningSwift
//
//  Created by AEF-RD-1 on 16/1/12.
//  Copyright © 2016年 yim. All rights reserved.
//



import UIKit
import Foundation


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        //4.调用方法
        //test()
        //createDictionaryAndArray()
        useFlowOfControl()
        
        // 调用返回一个参数的方法
        //print("say:\(methodAndClosePackeg("lisi", age: 18)) ")
        
        /*
        // 调用返回多个参数的方法
        let statistics = calculateStatistics([10,100,79,3,29,99])
        print("statistics.sum:\(statistics.sum)")   //
        print("statistics.sum:\(statistics.2)")     //输出和上一句是一样的
        */

        //带有可变个数的参数(参数不固定个数)
        print("sumOfListElement():\(sumOfListElement())")
        print("sumOfListElement():\(sumOfListElement(10,12,60))")
        
        //嵌套函数
        print("y = \(returns())")
        
        //函数是第一等类型，这意味着函数可以作为另一个函数的返回值。
        let increment = makeIncrementer();
        print("increment(9):\(increment(9))")
        
        //函数也可以当做参数传入另一个函数
        let numbers = [20,19,5,7]
        hasAnyMatches(numbers, condition: lessThanTen) //为何不用传参？？？？？
        
        //使用类
        //NameShape
        let shape = NameShape(name: "zhangsan");
        print("shape:\(shape.simpleDescription())")
        
        //Square
        let square = Square(length: 2.5, name: "lisi")
        print("square:\(square.simpleDescription())")
        print("area : \(square.area())")
        
        //EquilateralTriangle
        let triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
        print("triangle:\(triangle.simpleDescription())")
        print("triangle.perimeter:\(triangle.perimeter)")
        triangle.perimeter = 9.9
        print("triangle.sideLength:\(triangle.sideLength)")
        
        //TriangleAndSquare
        let triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
        print("triangleAndSquare.square.sideLength  :\(triangleAndSquare.square.sideLength)")
        print("triangleAndSquare.triangle.sideLength:\(triangleAndSquare.triangle.sideLength)")
        
        triangleAndSquare.square = Square(length: 50, name: "larger square")
        print("triangleAndSquare.triangle.sideLength:\(triangleAndSquare.triangle.sideLength)")
        
    }

    
    /**
     方法
     */
    func test(){
        //1.声明变量
        var myVarible = 20
        
        myVarible = 30;
        
        print("声明了变量 myVarible:\(myVarible)")
        
        //2.声明常量
        let myAge = 50
        
        let height:Double = 15
        
        print("声明常量，myAge:\(myAge),height:\(height)")
        
        let label = "this label width is "
        
        let width = 100
        
        let widthLabel = label + String(width); //int 转string类型
        
        //3.输出语句
        print(widthLabel);
        
        
        
        //NSLog( "L:\(%d) [%@: - %@]  %@",__LINE__, [[NSString stringWithUTF8String:__FILE__] lastPathComponent],String(_cmd) )//[NSString stringWithFormat:(s), ##__VA_ARGS__]
        
        let line = #line;
        
        let date:NSDate = NSDate.init() ;
        
        print("\(date.description) \(classForCoder) L:\(line) \(#function)")
        
        NSLog("L:\(line) \(classForCoder) \(#function)");
        
//        NSLog(<#T##format: String##String#>, <#T##args: CVarArgType...##CVarArgType#>)
        
        //================
        let apples = 3;
        let oranges = 5
        let appleSummary = "i have \(apples) apples"
        let fruitSummary = "i have \(apples + oranges) prices of fruit."
        print("appleSummary:\(appleSummary)...fruitSummary:\(fruitSummary)")
        
        print("use test() method")
    }
    //5.创建字典和数组
    func createDictionaryAndArray(){
        
        //字典
        var occupations = [
            "name":"zs",
            "age":20,
        ]
        print("occupations \(occupations)")
        occupations["age"] = 22;
        print("occupations changed \(occupations)")
        
        //数组
        var shopList = ["a","b","c"]
        print("shopList \(shopList)")
        shopList[1] = "bb"
        print("shopList changed \(shopList)")

        //创建空的数组-使用初始化语法
        let emptyArray = [String]();//字符串数组
        let emptyDictionary = [String:Float]()//
        
        print("emptyArray:\(emptyArray),emptyDictionary:\(emptyDictionary)")
        
    }
    
    //6。使用控制流
    func useFlowOfControl(){
        //6.1 for-in
        let scoreList = [20,39,56,90,100]
        var teamScore = 0
        for score in scoreList{
            if score > 40{
                teamScore+=3
            }else{
                teamScore+=1
            }
        }
        print("teamScore:\(teamScore)")
        
        //6.2 if语句
        let optionalString :String? = "Hello" //问号"?",表示标记这个变量的值是可选的
        print("optionalString == nil:\(optionalString == nil)")
        
        let optionalName:String? = "Apple Name"
        var greeting = "Hello"
        if let name = optionalName{
            greeting = "Hello,\(name)"
        }else{
            greeting = "Hello2,"
        }
        print("greeting:\(greeting)")
        
        //添加一个else语句，当optionalName是nil时给greeting赋一个不同的值
        //如果变量的可选值是nil，条件会判断为false，大括号中的代码会被跳过。如果不是nil，会将值赋给let后面的常量，这样代码块中就可以使用这个值了。
        //另一种处理可选值的方法是通过使用 ?? 操作符来提供一个默认值。如果可选值缺失的话，可以使用默认值来代替。
        
        let nickName: String? = nil
        let fullName: String = "John Appleseed"
        let informalGreeting = "Hi \(nickName ?? fullName)"
        print("informalGreeting:\(informalGreeting)")
        
        
        //6.3 switch(支持任意类型的数据以及各种比较操作——不仅仅是整数以及测试相等)
        let vegetable  = "red pepper"
        switch vegetable {
        
            case "red":
                print("Add some raisins and make ants on a log.")
            case "cucumber","watercress":
                print("that would make a good tea sandwich.")
            case let x where x.hasSuffix("pepper"):
                print("Is it a spicy \(x)?")
            default:
                print("Everything tastes good in soup.")
        }
        //let在上述例子的等式中是如何使用的，它将匹配等式的值赋给常量x
        //运行switch中匹配到的子句之后，程序会退出switch语句，并不会继续向下运行，所以不需要在每个子句结尾写break
        
        
        
        //6.4 for- in 遍历字典
        let interestingNumbers = [
            "prime":[2,3,4,5,6,9],
            "Fibonacci":[1,8,2,7],
            "Square":[1,4,11,5,2],
        ]
        
        var largest = 0;
        var key :String = ""
        for(kind,numbers) in interestingNumbers{
            
            for number in numbers {
                if number > largest{
                    largest = number;
                    key = kind
                }
            }
            
        }
        print("largest:\(largest),key:\(key)")
        
        //6.5 while (使用while来重复运行一段代码直到不满足条件。循环条件也可以在结尾，保证能至少循环一次。)
        var n = 2
        var i = 0
        while n < 100{
            n = n * 2
            i += 1
        }
        print("n:\(n),i:\(i)")
        
        
        var m = 2
        var j = 0
        repeat {
            j += 1
            m = n * 2
            
        } while m < 100
        
        print("m :\(m),j:\(j)")
        
        
        // 6.6 在循环中使用 ..< 来表示范围
        var firstForLoop = 0
        for i in 0..<4 {    //不包括4，要使用4是用...表示
            firstForLoop += i
        }
        print("firstForLoop:\(firstForLoop)")
        
        var secondForLoop = 0
        for var i = 0; i < 4; ++i {
            secondForLoop += i
        }
        print("secondForLoop:\(secondForLoop)")
        
        var ss = 0
        for m in 0...5 {
            //
            ss += m;
        }
        print("ss:\(ss)")
    }
    
    //7. ->来指定函数返回值的类型。
    func methodAndClosePackeg(name:String,age:Int) -> String{
        
        return "Hello! I am \(name),and \(age) years old"
    }
    
    //7.1 用元组让一个函数返回多个值，元组的元素可以用名称或数组表示
    func calculateStatistics (scores:[Int]) ->(min:Int,max:Int,sum:Int) {
    
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        
        for score in scores {
            if score > max {
                max = score //最大值
            } else if score < min {
                min = score //最小值
            }
            sum += score //得到总和
        }
        
        return (min, max, sum)
    
    }
    
    // 8. 函数可以带有可变个数的参数，这些参数在函数内表现为数组的形式：
    func sumOfListElement(numbers:Int...) -> Int {
        
        var sum = 0
        for number in numbers {
            sum += number
        }
        return sum
    }

    // 9.嵌套函数
    func returns ()->Int{
        
        var y = 10
        func add(){
            y+=5
        }
        add()
        
        return y
    }
    
    //10.函数是第一等类型，这意味着函数可以作为另一个函数的返回值。
    func makeIncrementer() -> (Int->Int){
        
        func addOne(number:Int)->Int{
            
            return number + 1;
        }
        
        return addOne;
    }
    
    // 11.函数也可以当做参数传入另一个函数。
    func hasAnyMatches (list:[Int], condition:Int -> Bool) ->Bool {
        
        for item in list {
            if condition(item) {
                return true
            }
        }
        
        return false
    }
    
    func lessThanTen (number:Int) ->Bool {
        
        return number < 10;
        
    }
    
    //===================没搞懂===========================
    //函数实际上是一种特殊的闭包:它是一段能之后被调取的代码。闭包中的代码能访问闭包所建作用域中能得到的变量和函数，即使闭包是在一个不同的作用域被执行的 - 你已经在嵌套函数例子中所看到。你可以使用{}来创建一个匿名闭包。使用in将参数和返回值类型声明与闭包函数体进行分离。
    /*
    numbers.map({
        (number:Int) -> Int in
        let result = 3 * number
        return result
    })
    */
    
    //有很多种创建更简洁的闭包的方法。如果一个闭包的类型已知，比如作为一个回调函数，你可以忽略参数的类型和返回值。单个语句闭包会把它语句的值当做结果返回。
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

