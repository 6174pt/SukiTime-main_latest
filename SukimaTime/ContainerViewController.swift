//
//  ContainerViewController.swift
//  SukimaTime
//
//  Created by Honoka Nishiyama on 2021/10/09.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet var button:UIButton!
    let saveData:UserDefaults=UserDefaults.standard
    var todoArray:[[Any]]=[[]]
    var checked5Array:[[Any]]=[[]]
    var checked10Array:[[Any]]=[[]]
    var checked15Array:[[Any]]=[[]]
    var checked30Array:[[Any]]=[[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.layer.cornerRadius=button.frame.height/2
        button.layer.shadowOffset = CGSize(width: 3, height: 3 )
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 10
        button.layer.shadowColor = UIColor.gray.cgColor
        
    }
    
    
    
    @IBAction func plus(_ sender: Any){
        // ①storyboardのインスタンス取得
        let storyboard: UIStoryboard = self.storyboard!
        
        // ②遷移先ViewControllerのインスタンス取得
        let nextView = storyboard.instantiateViewController(withIdentifier: "add") as! ToDoViewController
        
        // ③画面遷移
        self.present(nextView, animated: true, completion: nil)
    }
    
    
}
