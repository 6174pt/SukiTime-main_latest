//
//  CarouselCell.swift
//  SukimaTime
//
//  Created by Honoka Nishiyama on 2022/01/11.
//

import UIKit

protocol CatchProtocol {
    func goRunVC(taskId:Int)
}


class CarouselCell: UICollectionViewCell {
    
    var minutesLabel:UILabel!
    var todotitleLabel:UILabel!
    var todoLabel:UILabel!
    var datetitleLabel:UILabel!
    var dateLabel:UILabel!
    var decide:UIButton!
    
    var id:Int = 0
    
    var delegate : CatchProtocol?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        let width:CGFloat = self.contentView.frame.width
        let height:CGFloat = self.contentView.frame.height
        
        // 適当なmargin
        let margin:CGFloat = 15
        let margin2:CGFloat = 30
        
        // 分数アイコン
        minutesLabel = UILabel()
        minutesLabel.frame = CGRect(x: (width-50)/2, y: margin * 2, width: 50, height: 50)
        minutesLabel.textAlignment = .center
        minutesLabel.textColor = UIColor.white
        minutesLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        minutesLabel.backgroundColor = UIColor(named: "Blue2")
        minutesLabel.layer.cornerRadius = 50/2
        minutesLabel.clipsToBounds = true
        
        // todoタイトル
        todotitleLabel = UILabel()
        todotitleLabel.text = "Todo"
        todotitleLabel.frame = CGRect(x:margin,
                                  y:margin * 6,
                                  width:width - margin * 2,
                                  height:50)
        todotitleLabel.textAlignment = .center
        todotitleLabel.textColor = UIColor.gray
        todotitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        // todo名ラベル
        todoLabel = UILabel()
        todoLabel.frame = CGRect(x:margin,
                                  y:margin * 8,
                                  width:width - margin * 2,
                                  height:50)
        todoLabel.textAlignment = .center
        todoLabel.textColor = UIColor.black
        todoLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        todoLabel.adjustsFontSizeToFitWidth = true
        
        // 日付タイトル
        datetitleLabel = UILabel()
        datetitleLabel.text = "Date"
        datetitleLabel.frame = CGRect(x:margin,
                                  y:margin * 11,
                                  width:width - margin * 2,
                                  height:50)
        datetitleLabel.textAlignment = .center
        datetitleLabel.textColor = UIColor.gray
        datetitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        // 日付ラベル
        dateLabel = UILabel()
        dateLabel.frame = CGRect(x:margin,
                                  y:margin * 13,
                                  width:width - margin * 2,
                                  height:50)
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor.black
        dateLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        // 決定ボタン
        decide = UIButton()
        decide.frame = CGRect(x:margin,
                              y:height - 50 - margin * 1.5,
                                  width:width - margin * 2,
                                  height:50)
        decide.backgroundColor = UIColor(named: "Blue2")
        decide.setTitleColor(UIColor.white, for: UIControl.State.normal)
        decide.setTitle("Decide", for: .normal)
        decide.layer.borderWidth = 4  // 5
        decide.layer.borderColor = UIColor(named: "Blue2")?.cgColor
 
        decide.layer.cornerRadius = 10  // 7
        
        decide.layer.shadowOffset = CGSize(width: 3, height: 3 )  // 8
        decide.layer.shadowOpacity = 0.5  // 9
        decide.layer.shadowRadius = 10  // 10
        decide.layer.shadowColor = UIColor.gray.cgColor  // 11
        decide.addTarget(self, action: #selector(self.tapButton(_:)), for: UIControl.Event.touchUpInside)
        
        
        self.contentView.addSubview(minutesLabel)
        self.contentView.addSubview(todotitleLabel)
        self.contentView.addSubview(todoLabel)
        self.contentView.addSubview(datetitleLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(decide)
    }
    
    @objc func tapButton(_ sender: UIButton){
        
        delegate?.goRunVC(taskId: id)
        
        
    }
    
    
}

public extension UIButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       super.touchesBegan(touches, with: event)
        touchStartAnimation(p: self)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchEndAnimation(p: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchEndAnimation(p: self)
    }
}

func touchStartAnimation(p: UIButton, duration: CGFloat = 0.1){
    UIView.animate(withDuration: TimeInterval(duration),
        delay: 0.0,
        options: UIView.AnimationOptions.curveEaseIn,
        animations: {() -> Void in
            p.transform = CGAffineTransform(scaleX: 0.95, y: 0.95);
            p.alpha = 0.7
        },
        completion: nil
    )
}

func touchEndAnimation(p: UIButton, duration: CGFloat = 0.1){
    UIView.animate(withDuration: TimeInterval(duration),
        delay: 0.0,
        options: UIView.AnimationOptions.curveEaseIn,
        animations: {() -> Void in
            p.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
            p.alpha = 1
        },
        completion: nil
    )
}

