//
//  CarouselView.swift
//  SukimaTime
//
//  Created by Honoka Nishiyama on 2022/01/11.
//

import UIKit

class CarouselView: UICollectionView{
    
    var id:Int = 0
    
    let cellIdentifier = "carousel"
    
    let saveData:UserDefaults=UserDefaults.standard
    var filteredArray:[[Any]]=[[]]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 画面内に表示されているセルを取得
        let cells = self.visibleCells
        for cell in cells {
            // ここでセルのScaleを変更する
            transformScale(cell: cell)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
    }
    
    
    convenience init(frame: CGRect) {
        let layout = PagingPerCellFlowLayout()
        layout.itemSize = CGSize(width: frame.width*0.8, height: frame.height / 2)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 16, right: 50)
        
        
        self.init(frame: frame, collectionViewLayout: layout)
        
        // 水平方向のスクロールバーを非表示にする
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.white
        
    }
    
    func transformScale(cell: UICollectionViewCell) {
        // 計算してスケールを変更する
        let cellCenter:CGPoint = self.convert(cell.center, to: nil) //セルの中心座標
        let screenCenterX:CGFloat = UIScreen.main.bounds.width / 2  //画面の中心座標x
        let cellCenterDisX:CGFloat = abs(screenCenterX - cellCenter.x)
        let reductionRatio:CGFloat = -0.0009                        //縮小率
        let maxScale:CGFloat = 1                                    //最大値
        let newScale = reductionRatio * cellCenterDisX + maxScale   //新しいスケール
        cell.transform = CGAffineTransform(scaleX:newScale, y:newScale)
    }

    func scrollToFirstItem(){
        self.layoutIfNeeded()
        
        self.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
    }
    
}

