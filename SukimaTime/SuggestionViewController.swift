//
//  SuggestionViewController.swift
//  SukimaTime
//
//  Created by Honoka Nishiyama on 2021/07/26.
//

import UIKit

class SuggestionViewController: UIViewController, UICollectionViewDataSource{
    
    var index:Int=1
    var carouselView: CarouselView! {
        didSet{
            carouselView.dataSource = self
            carouselView.register(CarouselCell.self, forCellWithReuseIdentifier: "carousel")
        }
    }
    
    let saveData:UserDefaults=UserDefaults.standard
    var filteredArray:[[Any]]=[]
    var runArray:[Any]=[]
    
    
    override func viewWillAppear(_ animated: Bool) {
        presentingViewController?.beginAppearanceTransition(false, animated: animated)
        super.viewWillAppear(animated)
        
//        CarouselView(CollectionView)
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        carouselView = CarouselView(frame: CGRect(x:0, y:0, width:width, height:height))
        
        carouselView.dataSource = self
        carouselView.center = CGPoint(x:width / 2,y: height / 2)
        carouselView.scrollToFirstItem()
        self.view.addSubview(carouselView)
        
        
        
        filteredArray = saveData.object(forKey: "filter") as! [[Any]]
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredArray=saveData.object(forKey: "filter") as! [[Any]]
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        filteredArray=saveData.object(forKey: "filter") as! [[Any]]
    
    }
    
    // セクションごとのセル数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredArray=saveData.object(forKey: "filter") as! [[Any]]
        
            return filteredArray.count

    }
    
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carousel", for: indexPath) as! CarouselCell
        cell.contentView.backgroundColor = UIColor.white
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.shadowOffset = CGSize(width: 1,height: 1)
        cell.contentView.layer.shadowColor = UIColor.gray.cgColor
        cell.contentView.layer.shadowOpacity = 0.7
        cell.contentView.layer.shadowRadius = 5
        cell.id = indexPath.row
        
        cell.minutesLabel.text = filteredArray[indexPath.row][1] as? String
        cell.todoLabel.text = filteredArray[indexPath.row][0] as? String
        cell.dateLabel.text = filteredArray[indexPath.row][2] as? String
        
        cell.delegate = self
        
        return cell
    }
    
    
}

extension SuggestionViewController: CatchProtocol {
    
    func goRunVC(taskId: Int) {

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)

        let runViewController = (storyBoard.instantiateViewController(identifier: "RunViewController")) as! RunViewController
        runViewController.indexnumber = taskId

        self.navigationController?.pushViewController(runViewController, animated: true)
    }
}

    
    

