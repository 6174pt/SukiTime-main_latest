//
//  ListViewController.swift
//  SukimaTime
//
//  Created by Honoka Nishiyama on 2021/10/09.
//

import UIKit

class ListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var segmentedControl:UISegmentedControl!
    var array:[[Any]]=[]
    let saveData:UserDefaults=UserDefaults.standard
    var todoArray:[[Any]]=[]
    var checked5Array:[[Any]]=[]
    var checked10Array:[[Any]]=[]
    var checked15Array:[[Any]]=[]
    var checked30Array:[[Any]]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set()
        
        table.dataSource = self
        table.delegate=self
        
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator=false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentingViewController?.beginAppearanceTransition(false, animated: animated)
        super.viewWillAppear(animated)
        
        table.reloadData()
        
        set()
        
        table.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        table.reloadData()
    }
    
    
    
    @objc func set(){
        if let todo = saveData.object(forKey: "list") {
            todoArray = todo as! [[Any]]
        } else {
            
        }
        
        checked5Array = []
        checked10Array = []
        checked15Array = []
        checked30Array = []
        
        minutecheck()
        
        array=todoArray
        
    }
    
    @objc func minutecheck(){
            for i in 0..<Int(todoArray.count){
                if Int(todoArray[i][1] as! String)! == 5{
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
    
    @IBAction func ValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            set()
        case 1:
            set()
            array = checked5Array
        case 2:
            set()
            array = checked10Array
        case 3:
            set()
            array = checked15Array
        case 4:
            set()
            array = checked30Array
        default:
            set()
        }
        
        table.reloadData()
    }
    
    //    tableviewのcellの幅
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat {
        return 100
    }
    
    //    tableviewのcellの数：
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=table.dequeueReusableCell(withIdentifier: "Cell") as! ToDoTVCTableViewCell
        
        cell.todoView.layer.cornerRadius=cell.todoView.frame.height/4
        cell.todoView.layer.shadowOffset = CGSize(width: 1, height: 1 )
        cell.todoView.layer.shadowOpacity = 0.2
        cell.todoView.layer.shadowRadius = 10
        cell.todoView.layer.shadowColor = UIColor.gray.cgColor
        cell.todoimg.layer.cornerRadius=cell.todoimg.frame.height/2
        cell.todoLabel?.text = array[indexPath.row][0] as? String
        cell.todoLabel.adjustsFontSizeToFitWidth = true
        cell.dateLabel?.text = array[indexPath.row][2] as? String
        cell.minuteLabel?.text = array[indexPath.row][1] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: "Delete") { (action, view, completionHandler) in
            self.showAlert(deleteIndexPath: indexPath)
            completionHandler(true)
        }
        action.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    
    func showAlert(deleteIndexPath indexPath: IndexPath) {
        let dialog = UIAlertController(title: "削除",
                                       message: "ToDoを削除しますか？",
                                       preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "削除", style: .default, handler: { (_) in
            
            
            for i in 0..<Int(self.todoArray.count) {
                if (self.todoArray[i][0] as! String) == (self.array[indexPath.row][0] as! String) {
                    if (self.todoArray[i][1] as! String) == (self.array[indexPath.row][1] as! String){
                        if (self.todoArray[i][2] as! String) == (self.array[indexPath.row][2] as! String){
                            self.todoArray.remove(at: i)
                            self.saveData.set(self.todoArray, forKey: "list")
                            self.array.remove(at: indexPath.row)
                            self.table.deleteRows(at: [indexPath], with: .automatic)
                            
                            break
                        }
                    }
                }
            }
            self.set()
            
        }))
        dialog.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
    
}
