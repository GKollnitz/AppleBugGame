//
//  MainMenu
//  GFMaestroBug
//
//  Created by sdev on 17/10/17.
//  Copyright © 2017 sdev. All rights reserved.
//
import UIKit
import Foundation

class MainMenu: UIViewController
{
    
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var Label5: UILabel!
    let defaults:UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        let s1 = Int((defaults.integer(forKey: "score1") as AnyObject) as! NSNumber)
        let s2 = Int((defaults.integer(forKey: "score2") as AnyObject) as! NSNumber)
        let s3 = Int((defaults.integer(forKey: "score3") as AnyObject) as! NSNumber)
        let s4 = Int((defaults.integer(forKey: "score4") as AnyObject) as! NSNumber)
        let s5 = Int((defaults.integer(forKey: "score5") as AnyObject) as! NSNumber)
        let n1 = String(describing: (defaults.string(forKey: "names1") as AnyObject))
        let n2 = String(describing: (defaults.string(forKey: "names2") as AnyObject))
        let n3 = String(describing: (defaults.string(forKey: "names3") as AnyObject))
        let n4 = String(describing: (defaults.string(forKey: "names4") as AnyObject))
        let n5 = String(describing: (defaults.string(forKey: "names5") as AnyObject))
        
        
        if(n1 != "nil")
        {
            Label1.text = "\(n1) \(s1)"
        }
        if(n2 != "nil")
        {
            Label2.text = "\(n2) \(s2)"
        }
        if(n3 != "nil")
        {
            Label3.text = "\(n3) \(s3)"
        }
        if(n4 != "nil")
        {
            Label4.text = "\(n4) \(s4)"
        }
        if(n5 != "nil")
        {
            Label5.text = "\(n5) \(s5)"
        }
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

