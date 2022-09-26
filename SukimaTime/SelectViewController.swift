//
//  SelectViewController.swift
//  SukimaTime
//
//  Created by Honoka Nishiyama on 2021/07/26.
//

import UIKit

class SelectViewController: UIViewController {
    
    let saveData:UserDefaults=UserDefaults.standard
    var todoArray:[[Any]]=[]
    var filteredArray:[[Any]] = []
    var checked5Array:[[Any]]=[]
    var checked10Array:[[Any]]=[]
    var checked15Array:[[Any]]=[]
    var checked30Array:[[Any]]=[]
    
    @IBOutlet weak var fiveminuts:UIButton!
    @IBOutlet var tenminuts:UIButton!
    @IBOutlet var fifteenminuts:UIButton!
    @IBOutlet var thirtyminuts:UIButton!
    @IBOutlet var label:UILabel!
    @IBOutlet var subLabel:UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
    presentingViewController?.beginAppearanceTransition(false, animated: animated)
        super.viewWillAppear(animated)
        
        let content = UNMutableNotificationContent()
        content.title = "SukiTime"
        content.body = "スキマ時間を有効活用しませんか？"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        filteredArray=[]
        
        checked5Array=[]
        checked10Array=[]
        checked15Array=[]
        checked30Array=[]
        
        if let todo = saveData.object(forKey: "list") {
            todoArray = saveData.object(forKey: "list") as! [[Any]]
        } else {
            
        }
        
        
//        Todoが無い時「Todoを追加してください」表示
        if todoArray.isEmpty{
            label.isHidden=false
            subLabel.isHidden=false
        }else{
            label.isHidden=true
            subLabel.isHidden=true
            
            for i in 0..<Int(todoArray.count) {
                if Int(todoArray[i][1] as! String)! == 5 {
                    checked5Array += [todoArray[i]]
                }
                if Int(todoArray[i][1] as! String)! == 10{
                    checked10Array += [todoArray[i]]
                }
                if Int(todoArray[i][1] as! String)! == 15{
                    checked15Array += [todoArray[i]]
                }
                if Int(todoArray[i][1] as! String)! == 30{
                    checked30Array += [todoArray[i]]
                }
            }
        }
        
        
        if checked5Array.count == 0{
            fiveminuts.isEnabled=false
            setInvalidButton(button: fiveminuts)
            fiveminuts.backgroundColor=UIColor(named: "Blue2")
            fiveminuts.alpha=0.5
        }else{
            fiveminuts.isEnabled=true
            fiveminuts.alpha=1.0
        }
        
        if checked10Array.count == 0{
            tenminuts.isEnabled=false
            setInvalidButton(button: tenminuts)
            tenminuts.backgroundColor=UIColor(named: "Blue1")
            tenminuts.alpha=0.5
        }else{
            tenminuts.isEnabled=true
            tenminuts.alpha=1.0
        }
        
        if checked15Array.count == 0{
            fifteenminuts.isEnabled=false
            setInvalidButton(button: fifteenminuts)
            fifteenminuts.backgroundColor=UIColor(named: "Blue1")
            fifteenminuts.alpha=0.5
        }else{
            fifteenminuts.isEnabled=true
            fifteenminuts.alpha=1.0
        }
        
        if checked30Array.count == 0{
            thirtyminuts.isEnabled=false
            setInvalidButton(button: thirtyminuts)
            thirtyminuts.backgroundColor=UIColor(named: "Blue2")
            thirtyminuts.alpha=0.5
        }else{
            thirtyminuts.isEnabled=true
            thirtyminuts.alpha=1.0
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton(button: fiveminuts)
        fiveminuts.backgroundColor=UIColor(named: "Blue2")
        
        setButton(button: tenminuts)
        tenminuts.backgroundColor=UIColor(named: "Blue1")
        
        setButton(button: fifteenminuts)
        fifteenminuts.backgroundColor=UIColor(named: "Blue1")
        
        setButton(button: thirtyminuts)
        thirtyminuts.backgroundColor=UIColor(named: "Blue2")

    }
    
    func setButton(button:UIButton!){
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.layer.shadowOffset = CGSize(width: 3, height: 3 )
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 10
        button.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func setInvalidButton(button:UIButton!){
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.layer.shadowOffset = CGSize(width: 0, height: 0 )
    }
    
    
    @objc func get(){
        todoArray=saveData.object(forKey: "list") as! [[Any]]
    }
    
    @IBAction func five(){
        self.get()
        for i in 0..<Int(todoArray.count) {
            if Int(todoArray[i][1] as! String)! == 5 {
                filteredArray += [todoArray[i]]
                saveData.set(filteredArray, forKey: "filter")
            }
        }
    }
    
    @IBAction func ten(){
        self.get()
        for i in 0..<Int(todoArray.count) {
            if Int(todoArray[i][1] as! String)! == 10 {
                filteredArray += [todoArray[i]]
                saveData.set(filteredArray, forKey: "filter")
            }
        }
    }
    
    @IBAction func fifteen(){
        self.get()
        for i in 0..<Int(todoArray.count) {
            if Int(todoArray[i][1] as! String)! == 15 {
                filteredArray += [todoArray[i]]
                saveData.set(filteredArray, forKey: "filter")
            }
        }
    }
    
    @IBAction func thirty(){
        self.get()
        for i in 0..<Int(todoArray.count) {
            if Int(todoArray[i][1] as! String)! == 30 {
                filteredArray += [todoArray[i]]
                saveData.set(filteredArray, forKey: "filter")
            }
        }
    }
    
}
