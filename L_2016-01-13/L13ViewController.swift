//
//  L13ViewController.swift
//  LearningSwift
//
//  Created by AEF-RD-1 on 16/1/13.
//  Copyright © 2016年 yim. All rights reserved.
//
/**
* 闭包是自包含的功能代码块，可以在代码中使用或者用来作为参数传值。
* 在Swift中的闭包与C、OC中的blocks和其它编程语言（如Python）中的lambdas类似。
* 闭包可以捕获和存储上下文中定义的的任何常量和变量的引用。这就是所谓的变量和变量的自封闭，
* 因此命名为”闭包“("Closures）").Swift还会处理所有捕获的引用的内存管理。
*
* 全局函数和嵌套函数其实就是特殊的闭包。
* 闭包的形式有：
* （1）全局函数都是闭包，有名字但不能捕获任何值。
* （2）嵌套函数都是闭包，且有名字，也能捕获封闭函数内的值。
* （3）闭包表达式都是无名闭包，使用轻量级语法，可以根据上下文环境捕获值。
*
* Swift中的闭包有很多优化的地方:
* (1)根据上下文推断参数和返回值类型
* (2)从单行表达式闭包中隐式返回（也就是闭包体只有一行代码，可以省略return）
* (3)可以使用简化参数名，如$0, $1(从0开始，表示第i个参数...)
* (4)提供了尾随闭包语法(Trailing closure syntax)

*/
import UIKit
import Foundation

class L13ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //1.闭包基础
//        LClosuresBase()
        
        //2.闭包进阶
//        LClosuresAdvance()
        
        //3.尾随闭包
        TrailingClosures()
        
    }
    
    /**
     闭包进阶
     */
    func LClosuresAdvance (){
        //例:使用几次迭代展示了 sort 函数定义和语法优化的方式。 每一次迭代都用更简洁的方式描述了相同的功能。
        //sort 函数: ，会根据您提供的排序闭包将已知类型数组中的值进行排序。 一旦排序完成，函数会返回一个与原数组大小相同的新数组，该数组中包含已经正确排序的同类型元素。
        
        //sort(_:) 方法接受一个闭包,该闭包函数需要传入与数组元素类型相同的两个值,并返回一个布尔类型值来表明 当排序结束后传入的第一个参数排在第二个参数前面还是后面。如果第一个参数值出现在第二个参数值前面,排 序闭包函数需要返回 true ,反之返回 false 。
        //该例子对一个 String 类型的数组进行排序,因此排序闭包函数类型需为 (String, String) -> Bool 。
        func backwards (s1:String,s2:String) -> Bool {
            return s1>s2
        }
        //1.
        let nameList = ["Chris","Alex","Barry","Daniel","Yim"]
        let reversed = nameList.sort(backwards)
        print("reversed:\(reversed)") //reversed结果为:["Yim", "Daniel", "Chris", "Barry", "Alex"]
        print("============================")
        
        //2. 使用闭包表达式语法 <展示了之前 backwards(_:_:) 函数对应的闭包表达式版本的代码>
        let reversed2  = nameList.sort({
            (s1:String,s2:String) ->Bool in
            return s1 > s2
        })
        print("reversed2:\(reversed2)")
        print("============================")
        
        //2.1 改写成一行 ---> sort(_:) 方法的整体调用保持不变,一对圆括号仍然包裹住了方法的整个参数。然而,参数现在变成了内 联闭包
        let reversed3 = nameList.sort({(s1:String,s2:String) ->Bool in return s1 > s2})
        print("reversed3:\(reversed3)")
        print("============================")
        
        //MARK: - 根据上下文推断类型(Inferring Type From Context)
        //2.2 可推断类型---> 实际上任何情况下,通过内联闭包表达式构造的闭包作为参数传递给函数或方法时,都可以推断出闭包的参数和 返回值类型。 这意味着闭包作为函数或者方法的参数时,我们几乎不需要利用完整格式构造内联闭包。
        let reversed4 = nameList.sort({s1,s2 in return s1 > s2})
        print("reversed4:\(reversed4)")
        print("============================")
        
        
        // MARK: - 单表达式闭包隐式返回(Implicit Return From Single-Expression Clossures)
        let reversed5 = nameList.sort({s1,s2 in s1>s2})
        print("reversed5:\(reversed5)")
        print("============================")
        
        // MARK: - 参数名称缩写 <Swift 自动为内联闭包提供了参数名称缩写功能,您可以直接通过 $0 , $1 , $2 来顺序调用闭包的参数,以此类推。 如果您在闭包表达式中使用参数名称缩写,您可以在闭包参数列表中省略对其的定义,并且对应参数名称缩写的 类型会通过函数类型进行推断。 in 关键字也同样可以被省略,因为此时闭包表达式完全由闭包函数体构成 >
        let reversed6 = nameList.sort({$0 > $1 })//在这个例子中, $0 和 $1 表示闭包中第一个和第二个 String 类型的参数。
        print("reversed6:\(reversed6)")
        print("============================")
        
        
        // MARK: - 运算符函数(Operator Functions)
        //实际上还有一种更简短的方式来撰写上面例子中的闭包表达式。Swift 的 String 类型定义了关于大于 号( > )的字符串实现,其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。而这正好与 sor t(_:) 方法的第二个参数需要的函数类型相符合。因此,您可以简单地传递一个大于号,Swift 可以自动推断出您 想使用大于号的字符串函数实现:
        let reversed7 = nameList.sort(>)
        print("reversed7:\(reversed7)")
        print("============================")
        
        
        
        
        
    }
    
    /**
     尾随闭包
     date:2016-01-14
     */
    func TrailingClosures(){
    
        // mark - 尾随闭包 :将一个很长的闭包表达式作为最后一个参数传递给函数,可以使用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式,函数支持将其作为最后一个参数调用
        
        /**
        func someFunctionThatTakesAClosure(closure: () -> Void) { // 函数体部分
        }
        
        // 以下是不使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure({
            // 闭包主体部分
        })
        
        // 以下是使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure() {
            // 闭包主体部分
        }
        */
        
        // 在LClosuresAdvance 中， sort(_:) 方法参数的字符串排序闭包可以改写为:
        let nameList = ["Chris","Alex","Barry","Daniel","Yim"]
        let reversed = nameList.sort() { $0 > $1 }
        
        //如果函数只需要闭包表达式一个参数,当使用尾随闭包时,甚至可以把 () 省略掉:
        let reversed2 = nameList.sort {$0 > $1}
        print("reversed:\(reversed),reversed2:\(reversed2)")
        print("============================")
        
        //当闭包非常长以至于不能在一行中进行书写时,尾随闭包变得非常有用,举例：Swift 的 Array 类型有一个 map(_:) 方法,其获取一个闭包表达式作为其唯一参数。该闭包函数会为数组中的每一个元素调用一次,并返回 该元素所映射的值。具体的映射方式和返回值类型由闭包来指定。
        //当提供给数组的闭包应用于每个数组元素后, map(_:) 方法将返回一个新的数组,数组中包含了与原数组中的元 素一一对应的映射后的值。
        
        //下面介绍了如何在 map(_:) 方法中使用尾随闭包将 Int 类型数组 [16, 58, 510] 转换为包含对应 String 类型的值 的数组 ["OneSix", "FiveEight", "FiveOneZero"] :
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        print("digitNames:\(digitNames)")
        let numbers = [16, 58, 510]
        
//        let strings = numbers.map {
//            
//            (var num) -> String in
//            var output = ""
//            while num > 0 {
//                output = digitNames[num % 10]! + output
//                num /= 10
//            }
//            return output
//        }
        // strings 常量被推断为字符串类型数组,即 [String]
        // 其值为 ["OneSix", "FiveEight", "FiveOneZero"]
        // map(_:) 为数组中每一个元素调用了闭包表达式。我们不需要指定闭包的输入参数 num 的类型,因为可以通过要 映射的数组类型进行推断
//        print("strings:\(strings)")
        
        
    }
    
    
    
    /**
     闭包基础
     */
    func LClosuresBase (){
        
        //1.1 举例： 定义一个字符串的变量的方法--直接赋值
        var name = "yim"
        
        //使用闭包的方式定义
        // ****(1)
        var name2:String = { return "yim"}()
        // ****(2)还可以省略等号和括号
        var name3:String{ return "yim" }
        
        print("naem:\(name),name2:\(name2),name3:\(name3)")
        print("============================")
        
        //****(3)闭包中可以定义get方法
        var str:String{
            
            get { return "yim" }
        }
        
        //****(4)闭包中可以定义get/set方法
        var str2:String{
            get {return "yim" }
            set {print("str2 set ok")}
        }
        
        print("str:\(str),str2:\(str2)")
        print("============================")
        
        //****(5)在闭包中使用willSet和didSet ，willSet /didSet不能和get/set共同使用的， 在使用willSet /didSet时，变量需要有初始值
        var str3:String = "yim"{
            willSet { print("newValue:\(newValue)")}
            didSet  { print("oldValue:\(oldValue)")}
        }
        print("str3:\(str3)")
        str3 = "new yim"
        print("str3:\(str3)")
        print("============================")
        
        //最全的定义形式
        /*
        {
        (arguments) -> returnType in
        
        code
        }(arguments)
        */
        // ****(6)可以在闭包中定义参数，返回值。 闭包后用括号执行，并在括号中可以传参
        //例:
        var str4 = {
            (arg1:String,arg2:String) ->String in
            return arg1 + arg2
        }("y","im")
        print("str4:\(str4)")
        print("============================")
        
        //****(6.1),基于最全的定义方式，可以省略参数的类型<swift的类型推导，根据后面括号的传参能自动判断参数的类型。>
        var str5 = {
            arg1,arg2 ->String in
            return arg1 + arg2
        }("y","im")
        print("str5:\(str5)")
        print("============================")
        
        //****(6.2),继续可以省略返回值类型<省略了返回值类型后，变量要显示声明它的类型>
        var str6:String = {
            arg1,arg2 in
            return arg1+arg2
        }("y","im")
        print("str6:\(str6)")
        print("============================")
        
        //*****(6.3),继续可以省略参数
        var str7:String = {
            return $0+$1
        }("y","im")
        print("str7:\(str7)")
        print("============================")
        
        // ****如果闭包中只有一行代码， 其实return 也能省略。
        var str8:String = {
            $0+$1
        }("y","im")
        print("str8:\(str8)")
        print("============================")
        
        
        // ****如果闭包没有定义参数 ，像这样
        var str9:String = {
            return "yim"
        }()
        print("str9:\(str9)")
        print("============================")
        
        // ****既然闭包没有定义参数 ，那么()也能省略.......<没有=号>
        var str10:String{
            return "yim"
        }
        print("str10:\(str10)")
        print("============================")
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
