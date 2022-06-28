//
//  EndViewController.swift
//  SukimaTime
//
//  Created by Honoka Nishiyama on 2021/08/03.
//

import UIKit

class EndViewController: UIViewController {
    
    @IBOutlet var todoLabel:UILabel!
    @IBOutlet var timeLabel:UILabel!
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet var deletebutton:UIButton!
    @IBOutlet var retainbutton:UIButton!
    
    let saveData:UserDefaults=UserDefaults.standard
    var runArray:[Any]=[]
    var todoArray:[[Any]]=[[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runArray=saveData.object(forKey: "run") as! [Any]
        todoLabel.text=runArray[0] as? String
        timeLabel.text=runArray[1] as? String
        dateLabel.text=runArray[2] as? String
        
        //UI設定
        card.layer.cornerRadius = 10.0
        card.layer.shadowOffset = CGSize(width: 0, height: 0)
        card.layer.shadowRadius = 10.0
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.25
        
        
        setButton(button: deletebutton)
        deletebutton.backgroundColor=UIColor(named: "Blue2")
        deletebutton.layer.cornerRadius=deletebutton.frame.height/2
        
        setButton(button: retainbutton)
        retainbutton.backgroundColor=UIColor(named: "Blue1")
        retainbutton.layer.cornerRadius=retainbutton.frame.height/2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentingViewController?.beginAppearanceTransition(false, animated: animated)
        super.viewWillAppear(animated)
        
        runArray=saveData.object(forKey: "run") as! [Any]
        todoLabel.text=runArray[0] as? String
        timeLabel.text=runArray[1] as? String
        dateLabel.text=runArray[2] as? String
        
    }
    
    func setButton(button: UIButton!){
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.layer.shadowOffset = CGSize(width: 3, height: 3 )
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 10
        button.layer.shadowColor = UIColor.gray.cgColor
    }
    
    @IBAction func delete(){
        todoArray=saveData.object(forKey: "list") as! [[Any]]
        for i in 0..<Int(todoArray.count) {
            if (todoArray[i][0] as! String) == (runArray[0] as! String) {
                if (todoArray[i][1] as! String) == (runArray[1] as! String){
                    if (todoArray[i][2] as! String) == (runArray[2] as! String){
                        todoArray.remove(at: i)
                        saveData.set(todoArray, forKey: "list")
                        break
                    }
                }
            }
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func keep(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
