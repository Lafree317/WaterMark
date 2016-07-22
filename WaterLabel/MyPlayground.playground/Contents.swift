//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

// 声明协议
protocol someProtocol {
    func printSome()
}

// 让两个类遵守协议
class ClassA: someProtocol {
    func printSome(){
        print("cccccc")
    }
}
class ClassB: someProtocol {
    func printSome(){
        print("some")
    }
}

// 将这两个类作为第三个类的代理
class ClassC{
    var delegateA:someProtocol?
    var delegateB:someProtocol?
}

// 初始化
let objectA = ClassA()
let objectB = ClassB()
let objectC = ClassC()
// 赋值
objectC.delegateA = ClassA()
objectC.delegateB = ClassB()

objectC.delegateA?.printSome()
//// 执行代理方法
//if let delegate = objectC.delegateB {
//    delegate.printSome() // 调用协议方法
//}
if let delegate = objectC.delegateA {
    delegate.printSome() // 调用协议方法
}




// 声明一个新的协议
protocol OptionProtocol {
    func option(a:Int,b:Int) -> Int
    
}
// 直接重写类去遵守协议
extension ClassA:OptionProtocol{
    func option(a: Int, b: Int) -> Int {
        return a+b
    }// 不同实现
}
extension ClassB:OptionProtocol{
    func option(a: Int, b: Int) -> Int {
        return a*b
    }// 不同实现
}

objectA.option(1, b: 2)
objectA.printSome()

objectB.option(1, b: 2)
objectB.printSome()


// 通过协议节省代码
protocol Shakeable { }

extension Shakeable where Self: UIView {
    // shake 方法的默认实现
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - 4.0, self.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x + 4.0, self.center.y))
        layer.addAnimation(animation, forKey: "position")
    }
}





class shakeImageView:UIImageView,Shakeable{
    
}
let imageViewA = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
imageViewA.backgroundColor = .redColor()


let imageViewB = shakeImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
imageViewB.backgroundColor = .redColor()
imageViewB.shake()

class ShakeButton:UIButton,Shakeable{

}
class backView: UIView {
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        setImageView()
        setButton()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageView:shakeImageView!
    var button:ShakeButton!
    func setImageView(){
        imageView = shakeImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        imageView.backgroundColor = .redColor()
        self.addSubview(imageView)
    }
    func setButton(){
        button = ShakeButton(type: .System)
        button.frame = CGRect(x: 0, y: 50, width: 100, height: 50)
        button.setTitle("按钮", forState: .Normal)
        button.addTarget(self, action: #selector(buttonClick), forControlEvents: .TouchUpInside)
        self.addSubview(button)
    }
    func buttonClick(){
        print("aaaaaaa")
        imageView.shake()
        button.shake()
    }
}



let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
containerView.backgroundColor = UIColor.yellowColor()
XCPShowView("containerView", view: containerView)


let view = backView()
containerView.addSubview(view)
view.center = containerView.center
