//
//  ViewController.swift
//  GFMaestroBug
//
//  Created by sdev on 17/10/17.
//  Copyright © 2017 sdev. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var bugs = [bug?](repeating: nil, count: 25)
    var lastPoint = CGPoint.zero
    var path1 = UIBezierPath()
    var path2 = UIBezierPath()
    var point1Arr = [CGPoint]()
    var point2Arr = [CGPoint]()
    var layer1 = CAShapeLayer()
    var layer2 = CAShapeLayer()
    var fingers = [String?](repeating: nil, count: 2)
    var array = [UIImageView]()
    var counter: Int = 0
    var gameOver = false
    let defaults:UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var submitButtonVar: UIButton!
    @IBOutlet weak var nameBox: UITextField!
    @IBOutlet weak var redWinText: UILabel!
    @IBOutlet weak var blueWinText: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    
    
    @IBAction func submitButton(_ sender: UIButton) {
        let lastCount: Int = counter
        let lastName: String = nameBox.text!
        let s1 = Int((defaults.integer(forKey: "score1") as AnyObject) as! NSNumber)
        let s2 = Int((defaults.integer(forKey: "score2") as AnyObject) as! NSNumber)
        let s3 = Int((defaults.integer(forKey: "score3") as AnyObject) as! NSNumber)
        let s4 = Int((defaults.integer(forKey: "score4") as AnyObject) as! NSNumber)
        let s5 = Int((defaults.integer(forKey: "score5") as AnyObject) as! NSNumber)
        let n1 = String(describing: (defaults.string(forKey: "names1") as AnyObject))
        let n2 = String(describing: (defaults.string(forKey: "names2") as AnyObject))
        let n3 = String(describing: (defaults.string(forKey: "names3") as AnyObject))
        let n4 = String(describing: (defaults.string(forKey: "names4") as AnyObject))
        
        print(s1,s2,s3,s4,s5,lastCount)
        if((s1 == 0) || (s1 > lastCount))
        {
            defaults.set(s1, forKey: "score2")
            defaults.set(s2, forKey: "score3")
            defaults.set(s3, forKey: "score4")
            defaults.set(s4, forKey: "score5")
            defaults.set(lastCount, forKey: "score1")
            defaults.set(n1, forKey: "names2")
            defaults.set(n2, forKey: "names3")
            defaults.set(n3, forKey: "names4")
            defaults.set(n4, forKey: "names5")
            defaults.set(lastName, forKey: "names1")
        }
        else if((s2 == 0) || (s2 > lastCount))
        {
            defaults.set(s2, forKey: "score3")
            defaults.set(s3, forKey: "score4")
            defaults.set(s4, forKey: "score5")
            defaults.set(lastCount, forKey: "score2")
            defaults.set(n2, forKey: "names3")
            defaults.set(n3, forKey: "names4")
            defaults.set(n4, forKey: "names5")
            defaults.set(lastName, forKey: "names2")
        }
        else if((s3 == 0) || (s3 > lastCount))
        {
            defaults.set(s3, forKey: "score4")
            defaults.set(s4, forKey: "score5")
            defaults.set(lastCount, forKey: "score3")
            defaults.set(n3, forKey: "names4")
            defaults.set(n4, forKey: "names5")
            defaults.set(lastName, forKey: "names3")
        }
        else if((s4 == 0) || (s4 > lastCount))
        {
            defaults.set(s4, forKey: "score5")
            defaults.set(lastCount, forKey: "score4")
            defaults.set(n4, forKey: "names5")
            defaults.set(lastName, forKey: "names4")
        }
        else if((s5 == 0) || (s5 > lastCount))
        {
            defaults.set(lastCount, forKey: "score5")
            defaults.set(lastName, forKey: "names5")
        }
        
        menuButton.isHidden = false
    }
    
    override func viewDidLoad() {
        submitButtonVar.isHidden = true
        nameBox.isHidden = true
        blueWinText.isHidden = true
        redWinText.isHidden = true
        menuButton.isHidden = true
        loadGame()
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.counterT), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
    }
    
    func counterT()
    {
        if (!gameOver)
        {
            counter+=1
        }
    }
    
    func loadGame()
    {
        for(index, _) in bugs.enumerated()
        {
            let nBug = bug()
            bugs[index] = nBug
            bugs[index]!.xPos = 25+(Double(self.view.frame.width-50)*Double(arc4random_uniform(100)+1)/100)
            bugs[index]!.yPos = 25+(Double(self.view.frame.width-50)*Double(arc4random_uniform(100)+1)/100)
            if(index>19){
                bugs[index]!.imageView = UIImageView(image: #imageLiteral(resourceName: "bugblue"))
                bugs[index]!.color = "blue"
            }
            else if(index>14){
                bugs[index]!.imageView = UIImageView(image: #imageLiteral(resourceName: "bugred"))
                bugs[index]!.color = "red"
            }
            else if(index>9){
                bugs[index]!.imageView = UIImageView(image: #imageLiteral(resourceName: "bugteal"))
                bugs[index]!.color = "teal"
            }
            else if(index>4){
                bugs[index]!.imageView = UIImageView(image: #imageLiteral(resourceName: "buggreen"))
                bugs[index]!.color = "green"
            }
            else{
                bugs[index]!.imageView = UIImageView(image: #imageLiteral(resourceName: "bugyellow"))
                bugs[index]!.color = "yellow"
            }
            array.append(bugs[index]!.imageView!)
            bugs[index]!.imageView?.frame = CGRect(x: bugs[index]!.xPos - bugs[index]!.width/2, y: bugs[index]!.yPos - bugs[index]!.height/2, width: bugs[index]!.width, height: bugs[index]!.height)
            
            view.addSubview(bugs[index]!.imageView!)
        }
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches
        {
            let point = touch.location(in: gameView)
            for(index,finger) in fingers.enumerated()
            {
                if finger==nil
                {
                    fingers[index] = String(format: "%p", touch)
                    if(index == 0){
                        point1Arr.append(point)
                        layer1.removeFromSuperlayer()
                        path1.removeAllPoints()
                        path1.move(to: point)
                    }
                    else if(index == 1){
                        point2Arr.append(point)
                        layer2.removeFromSuperlayer()
                        path2.removeAllPoints()
                        path2.move(to: point)
                    }
                    break
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let dl = DispatchTime.now()+0.5
        super.touchesEnded(touches, with: event)
        let newFillColor = UIColor(red: 0, green: 0, blue: 125/255.0, alpha: 0.2).cgColor
        for touch in touches
        {
            for(index,finger) in fingers.enumerated()
            {
                if let finger = finger , finger == String(format: "%p", touch)
                {
                    fingers[index] = nil
                    if(index == 0){
                        path1.close();
                        point1Arr.removeAll()
                        containsBug(in: path1)
                        layer1.path = path1.cgPath
                        layer1.fillColor = newFillColor
                        self.gameView.layer.addSublayer(layer1)
                        DispatchQueue.main.asyncAfter(deadline: dl)
                        {
                            self.layer1.removeFromSuperlayer()
                        }
                        
                    }
                    else if(index == 1){
                        path2.close();
                        point2Arr.removeAll()
                        containsBug(in: path2)
                        layer2.path = path2.cgPath
                        layer2.fillColor = newFillColor
                        self.gameView.layer.addSublayer(layer2)
                        DispatchQueue.main.asyncAfter(deadline: dl)
                        {
                            self.layer2.removeFromSuperlayer()
                        }
                    }
                    break
                }
            }
        }
        
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let dl = DispatchTime.now()+0.5
        super.touchesMoved(touches, with: event)
        let newFillColor = UIColor(red: 255.0/255.0, green: 0, blue: 0, alpha: 0.4).cgColor
        for touch in touches
        {
            let point = touch.location(in: gameView)
            for(index,finger) in fingers.enumerated()
            {
                if let finger = finger , finger == String(format: "%p", touch)
                {
                    if(index == 0){
                        let n = point1Arr.count
                        if(n > 2)
                        {
                            for i in 0...n - 2
                            {
                                if intersectionBetweenSegments(point: point1Arr[i], point: point1Arr[i+1], point: point1Arr[n-1], point: point)
                                {
                                    path1.close()
                                    point1Arr.removeAll()
                                    layer1.path = path1.cgPath
                                    layer1.fillColor = newFillColor
                                    self.gameView.layer.addSublayer(layer1)
                                    DispatchQueue.main.asyncAfter(deadline: dl)
                                    {
                                        self.layer1.removeFromSuperlayer()
                                    }
                                    fingers[index] = nil
                                    return
                                }
                            }
                        }
                        point1Arr.append(point)
                        path1.addLine(to: point)
                        layer1.path = path1.cgPath
                        layer1.strokeColor = UIColor.blue.cgColor
                        layer1.fillColor = UIColor.clear.cgColor
                        self.gameView.layer.addSublayer(layer1)
                    }
                    else if(index == 1){
                        
                        let n = point2Arr.count
                        if(n > 2)
                        {
                            for i in 0...n - 2
                            {
                                if intersectionBetweenSegments(point: point2Arr[i], point: point2Arr[i+1], point: point2Arr[n-1], point: point)
                                {
                                    path2.close()
                                    point2Arr.removeAll()
                                    layer2.path = path2.cgPath
                                    layer2.fillColor = newFillColor
                                    self.gameView.layer.addSublayer(layer2)
                                    DispatchQueue.main.asyncAfter(deadline: dl)
                                    {
                                        self.layer2.removeFromSuperlayer()
                                    }
                                    fingers[index] = nil
                                    return
                                }
                            }
                        }
                        point2Arr.append(point)
                        path2.addLine(to: point)
                        layer2.path = path2.cgPath
                        layer2.strokeColor = UIColor.blue.cgColor
                        layer2.fillColor = UIColor.clear.cgColor
                        self.gameView.layer.addSublayer(layer2)
                    }
                    break
                }
            }
            
        }
    }
    
    func intersectionBetweenSegments(point p0: CGPoint, point p1: CGPoint, point p2: CGPoint, point p3: CGPoint) -> Bool
    {
        if(p1==p2)
        {
            return false
        }
        var denominator = (p3.y - p2.y) * (p1.x - p0.x) - (p3.x - p2.x) * (p1.y - p0.y)
        var ua = (p3.x - p2.x) * (p0.y - p2.y) - (p3.y - p2.y) * (p0.x - p2.x)
        var ub = (p1.x - p0.x) * (p0.y - p2.y) - (p1.y - p0.y) * (p0.x - p2.x)
        if (denominator < 0)
        {
            ua = -ua; ub = -ub; denominator = -denominator
        }
        if (ua >= 0.0 && ua <= denominator && ub >= 0.0 && ub <= denominator && denominator != 0)
        {
            return true
        }
        return false
    }
    
    func containsBug(in path:UIBezierPath)
    {
        var red: Bool = false
        var blue: Bool = false
        var teal: Bool = false
        var green: Bool = false
        var yellow: Bool = false
        
        for(index, _) in bugs.enumerated()
        {
            
            if(path.contains(CGPoint(x: bugs[index]!.xPos,y: bugs[index]!.yPos)) && bugs[index]!.enabled)
            {
                if(bugs[index]?.color == "red")
                {
                    red = true                }
                else if(bugs[index]?.color == "blue")
                {
                    blue = true
                }
                else if(bugs[index]?.color == "teal")
                {
                    teal = true
                }
                else if(bugs[index]?.color == "green")
                {
                    green = true
                }
                else if(bugs[index]?.color == "yellow")
                {
                    yellow = true
                }
            }
        }
        
        var current: String
        var currentImage: UIImageView
        if(red == true && blue == false && teal == false && green == false && yellow == false)
        {
            current = "red"
            currentImage = UIImageView(image: #imageLiteral(resourceName: "bugred"))
        }
        else if(red == false && blue == true && teal == false && green == false && yellow == false)
        {
            current = "blue"
            currentImage = UIImageView(image: #imageLiteral(resourceName: "bugblue"))
        }
        else if(red == false && blue == false && teal == true && green == false && yellow == false)
        {
            current = "teal"
            currentImage = UIImageView(image: #imageLiteral(resourceName: "bugteal"))
        }
        else if(red == false && blue == false && teal == false && green == true && yellow == false)
        {
            current = "green"
            currentImage = UIImageView(image: #imageLiteral(resourceName: "buggreen"))
        }
        else if(red == false && blue == false && teal == false && green == false && yellow == true)
        {
            current = "yellow"
            currentImage = UIImageView(image: #imageLiteral(resourceName: "bugyellow"))
        }
        else
        {
            return
        }
        var width = 0.0
        var height = 0.0
        var nrBugs = 0.0
        var newX = 0.0
        var newY = 0.0
        for(index, _) in bugs.enumerated()
        {
            if(path.contains(CGPoint(x: bugs[index]!.xPos,y: bugs[index]!.yPos)) && bugs[index]?.color == current && bugs[index]!.enabled)
            {
                nrBugs+=1
                newX+=bugs[index]!.xPos
                newY+=bugs[index]!.yPos
                width+=bugs[index]!.width
                height+=bugs[index]!.height
                bugs[index]!.enabled = false
                array[index].removeFromSuperview()
                
            }
        }
        let nBug = bug()
        nBug.xPos = newX/nrBugs
        nBug.yPos = newY/nrBugs
        nBug.width = width
        nBug.height = height
        nBug.imageView = currentImage
        nBug.color = current
        nBug.imageView?.frame = CGRect(x: nBug.xPos - nBug.width/2, y: nBug.yPos - nBug.height/2, width: nBug.width, height: nBug.height)
        array.append(nBug.imageView!)
        view.addSubview(nBug.imageView!)
        bugs.append(nBug)
        
        if(nBug.width == 250)
        {
            if(nBug.color == "red")
            {
                gameOver = true
                submitButtonVar.isHidden = false
                nameBox.isHidden = false
                redWinText.isHidden = false
                print(counter)
            }
            else if (nBug.color == "blue")
            {
                gameOver = true
                submitButtonVar.isHidden = false
                nameBox.isHidden = false
                blueWinText.isHidden = false
                print(counter)
            }
        }
    }
    
    @objc func update()
    {
        for(index,_) in bugs.enumerated()
        {
            if(gameOver)
            {
                array[index].removeFromSuperview()
            }
            else{
                let newX: Double = Double(bugs[index]!.xPos + (Double(arc4random_uniform(UInt32(2-(-2)+1)))-2))
                let newY: Double = Double(bugs[index]!.yPos + (Double(arc4random_uniform(UInt32(2-(-2)+1)))-2))
                if(newX-bugs[index]!.width/2 > 0 && newX+bugs[index]!.width/2 < Double(self.view.frame.width) && newY-bugs[index]!.height/2 > 0 && newY+bugs[index]!.height/2 < Double(self.view.frame.height))
                {
                    bugs[index]!.xPos = newX
                    bugs[index]!.yPos = newY
                    bugs[index]!.imageView?.frame = CGRect(x:bugs[index]!.xPos - bugs[index]!.width/2,y:bugs[index]!.yPos - bugs[index]!.height/2, width: bugs[index]!.width, height: bugs[index]!.height)
                    
                }
            }
        }
        
    }
}

