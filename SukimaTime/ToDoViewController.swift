//
//  ToDoViewController.swift
//  SukimaTime
//
//  Created by Honoka Nishiyama on 2021/07/26.
//


import Foundation
import UIKit

class ToDoViewController: UIViewController, UIAdaptivePresentationControllerDelegate{
    
    @IBOutlet weak var todoTextField:UITextField!
    @IBOutlet weak var timeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var timeTextField:UITextField!
//    @IBOutlet weak var dateTextField:UITextField!
    @IBOutlet weak var add:UIButton!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    var todonumber:Int=0
    var timenumber:Int=0
    var datenumber:Int=0
    var date:String=""
    
    var todoArray:[[Any]] = []

    //    ユーザーデフォルトにアクセス
    let saveData:UserDefaults=UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        card.layer.cornerRadius = 10.0
        card.layer.shadowOffset = CGSize(width: 0, height: 0)
        card.layer.shadowRadius = 10.0
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0.25
        
        
        add.frame=CGRect(x: view.frame.size.width/2-170, y: view.frame.size.height/2+200, width: 340, height: 40)
        add.backgroundColor = UIColor(named: "Blue2")
        add.setTitleColor(UIColor.white, for: UIControl.State.normal)
        add.layer.cornerRadius = 20
        add.layer.shadowOffset = CGSize(width: 3, height: 3 )
        add.layer.shadowOpacity = 0.5
        add.layer.shadowRadius = 10
        add.layer.shadowColor = UIColor.gray.cgColor
        
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        
        add.isEnabled=false
        add.backgroundColor = UIColor(red: 133/255, green: 152/255, blue: 183/255, alpha: 0.4)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        presentingViewController?.beginAppearanceTransition(false, animated: animated)
        super.viewWillAppear(animated)
        
        
        if let todo = saveData.object(forKey: "list") {
            todoArray = saveData.object(forKey: "list") as! [[Any]]
        } else {
            
        }
        setNumber()
        timeTextField.isEnabled=false
//        dateTextField.isEnabled=false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presentingViewController?.beginAppearanceTransition(true, animated: animated)
        presentingViewController?.endAppearanceTransition()
    }
    
    
//    項目のリセット
    func setNumber(){
//        項目欄のリセット
        todoTextField.text=""
        timeTextField.text=""
//        dateTextField.text=""
//        すべての項目が未入力の状態である
        todonumber=0
        timenumber=0
        datenumber=0
        saveData.set(todonumber, forKey: "todo")
        saveData.set(timenumber, forKey: "time")
        saveData.set(datenumber, forKey: "date")
    }
    
    
//    未入力項目がある時のAddボタンの無効化
    func judgeNumber(){
        if todonumber == 0{
            add.isEnabled=false
            add.backgroundColor = UIColor(red: 133/255, green: 152/255, blue: 183/255, alpha: 0.4)
        }else{
            if timenumber == 0{
                add.isEnabled=false
                add.backgroundColor = UIColor(red: 133/255, green: 152/255, blue: 183/255, alpha: 0.4)
            }else{
                if datenumber == 0{
                    add.isEnabled=false
                    add.backgroundColor = UIColor(red: 133/255, green: 152/255, blue: 183/255, alpha: 0.4)
                }else{
                    add.isEnabled=true
                    add.backgroundColor = UIColor(red: 133/255, green: 152/255, blue: 183/255, alpha: 1.0)
                }
            }
        }
    }
    
    
//    日付入力
    @IBAction func dateChanged(_ sender: UIDatePicker) {
//        self.dateTextField.text = self.format(date: datePicker.date)
        
        date = self.format(date: datePicker.date)
        
//        日付欄は入力済みである
        datenumber=1
        saveData.set(datenumber, forKey: "date")
        todonumber = saveData.object(forKey: "todo") as! Int
        timenumber = saveData.object(forKey: "time") as! Int
        judgeNumber()
        
    }
    
    
//    日付の表示フォーマット
    func format(date:Date)->String{
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd"
        let strDate = dateformatter.string(from: date)
        
        return strDate
    }
    
    
//    分数選択
    @IBAction func tappedSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.timeTextField.text = "5"
        case 1:
            self.timeTextField.text = "10"
        case 2:
            self.timeTextField.text = "15"
        case 3:
            self.timeTextField.text = "30"
        default:
            self.timeTextField.text = "-"
        }
//        分数欄は入力済みである
        timenumber=1
        saveData.set(timenumber, forKey: "time")
        todonumber = saveData.object(forKey: "todo") as! Int
        datenumber = saveData.object(forKey: "date") as! Int
        judgeNumber()
    }
    
    
//    Todo名
    @IBAction func todoEditChanged(_ sender: Any) {
        todonumber=1
        saveData.set(todonumber, forKey: "todo")
        timenumber = saveData.object(forKey: "time") as! Int
        datenumber = saveData.object(forKey: "date") as! Int
        judgeNumber()
    }
        
//    Todoの追加
    @IBAction func addData(){
        todoArray += [[todoTextField.text!, timeTextField.text!, date]]
        print(todoArray)
        saveData.set(todoArray, forKey: "list")
//        項目のリセット
        setNumber()
        add.isEnabled=false
        add.backgroundColor = UIColor(red: 133/255, green: 152/255, blue: 183/255, alpha: 0.4)
        let alert: UIAlertController = UIAlertController(title: "完了", message: "ToDoが追加されました", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "OK", style: .default, handler: { action in }
            )
        )
        present(alert, animated: true, completion: nil)
    }
    
}
