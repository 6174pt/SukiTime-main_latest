//
//  RunViewController.swift
//  SukimaTime
//
//  Created by Honoka Nishiyama on 2021/07/27.
//

import UIKit

class RunViewController: UIViewController {
    
    let saveData:UserDefaults=UserDefaults.standard
    var filteredArray:[[Any]]=[]
    var runArray:[Any]=[]
    var runtime:Int=0
    var firsttime:Int=0
    var middletime:Int=0
    var firstTimer = Timer()
    var secondTimer = Timer()
    var indexnumber:Int=0
    
    let shape=CAShapeLayer()
    let startButton:UIButton=UIButton()
    let stopButton:UIButton=UIButton()
    let restartButton:UIButton=UIButton()
    let resetButton:UIButton=UIButton()
    let circle:UIImageView=UIImageView()
    @IBOutlet var endButton:UIButton!
    let timerLabel:UILabel=UILabel()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "stopbutton1")
        
        let ciclePath=UIBezierPath(arcCenter: view.center, radius: 150, startAngle: -(.pi/2), endAngle: .pi/2*3, clockwise: true)
        
        
//        ベース
        circle.backgroundColor = .white
        circle.frame=CGRect(x: view.frame.size.width/2-155, y: view.frame.size.height/2-155, width: 310, height: 310)
        circle.layer.cornerRadius=155
        circle.layer.shadowColor=UIColor.gray.cgColor
        circle.layer.shadowOffset = CGSize(width: 3, height: 3 )
        circle.layer.shadowOpacity = 0.5
        circle.layer.shadowRadius = 10 
        view.addSubview(circle)
        
//        ゲージベース
        let baseShape=CAShapeLayer()
        baseShape.path=ciclePath.cgPath
        baseShape.fillColor=UIColor.clear.cgColor
        baseShape.lineWidth=10
        baseShape.strokeColor=UIColor(named: "Gray")?.cgColor
        view.layer.addSublayer(baseShape)
        
//        ゲージ
        shape.path=ciclePath.cgPath
        shape.lineWidth=10
        shape.strokeColor=UIColor(named: "Blue2")?.cgColor
        shape.fillColor=UIColor.clear.cgColor
        shape.strokeEnd=0
        shape.lineCap = .round
        view.layer.addSublayer(shape)
        
        timerLabel.frame = CGRect(x: view.frame.size.width/2-100, y: view.frame.size.height/2-40, width: 200, height: 80)
        timerLabel.textAlignment = NSTextAlignment.center
        timerLabel.text = "00:00"
        timerLabel.textColor = UIColor.darkGray
        timerLabel.font = UIFont.systemFont(ofSize: 60)
        view.addSubview(timerLabel)
        
//        スタートボタン
        startButton.frame=CGRect(x: view.frame.size.width/2-25, y: view.frame.size.height/2-25, width: 50, height: 50)
        startButton.setTitle("▶︎", for: .normal)
        startButton.setTitleColor(UIColor.lightGray, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        startButton.backgroundColor = UIColor.clear
        startButton.layer.cornerRadius=25
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        view.addSubview(startButton)
        
//        ストップボタン
        stopButton.frame=CGRect(x: view.frame.size.width/2-25, y: view.frame.size.height/2+67.5, width: 50, height: 50)
        stopButton.layer.borderColor = UIColor(named: "Blue2")?.cgColor
        stopButton.setImage(img, for: .normal)
        stopButton.addTarget(self, action: #selector(didTapStopButton), for: .touchUpInside)
        view.addSubview(stopButton)
        
//        リスタートボタン
        restartButton.frame=CGRect(x: view.frame.size.width/2-25, y: view.frame.size.height/2+67.5, width: 50, height: 50)
        restartButton.setTitle("▶︎", for: .normal)
        restartButton.backgroundColor = UIColor(named: "Blue2")
        restartButton.layer.cornerRadius=25
        restartButton.addTarget(self, action: #selector(didTapRestartButton), for: .touchUpInside)
        view.addSubview(restartButton)
        
//        リセットボタン
        resetButton.frame=CGRect(x: view.frame.size.width/2+130, y: view.frame.size.height/2+200, width: 40, height: 40)
        resetButton.setTitle("↻", for: .normal)
        resetButton.backgroundColor=UIColor(named: "Blue2")
        resetButton.layer.cornerRadius=20
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        view.addSubview(resetButton)
        
//        完了ボタン
        endButton.frame=CGRect(x: view.frame.size.width/2-170, y: view.frame.size.height/2+200, width: 280, height: 40)
        endButton.backgroundColor = UIColor(named: "Blue2")
        endButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        endButton.layer.cornerRadius = 20  // 7
        endButton.layer.shadowOffset = CGSize(width: 3, height: 3 )  // 8
        endButton.layer.shadowOpacity = 0.5  // 9
        endButton.layer.shadowRadius = 10  // 10
        endButton.layer.shadowColor = UIColor.gray.cgColor  // 11
        
        restartButton.isHidden=true
        stopButton.isHidden=true
        resetButton.isEnabled=false
        resetButton.alpha=0.5
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentingViewController?.beginAppearanceTransition(false, animated: animated)
        super.viewWillAppear(animated)
        
        filteredArray = saveData.object(forKey: "filter") as! [[Any]]
        
        runArray += filteredArray[indexnumber]
        
        saveData.register(defaults: ["run": [] ])
        saveData.set(runArray, forKey: "run")
        
        
        runtime = Int(runArray[1] as! String)! * 60
        firsttime = runtime
        
        timerLabel.text="\(firsttime/60):00"
        timerLabel.isHidden=true
        
        }
    
//    一度目のスタートで呼び出す
    @objc func firstCountDown(){
        
        let min = Int(firsttime/60)
        let sec = Int(firsttime) % 60
        timerLabel.text = String(format: "%02d:%02d", min,sec)
        firsttime -= 1
        if firsttime == 0{
            firstTimer.invalidate()
            timerLabel.text="00:00"
        }
    }
    
//    ストップ
    @objc func stopCountDown(){
        if firstTimer.isValid{
            middletime = firsttime
            firstTimer.invalidate()
        }
        if secondTimer.isValid{
            secondTimer.invalidate()
        }
    }
    
//    二度目以降のスタートで呼び出す
    @objc func secondCountDown(){
        
        let min = Int(middletime/60)
        let sec = Int(middletime) % 60
        timerLabel.text = String(format: "%02d:%02d", min,sec)
        middletime -= 1
        if middletime == 0{
            secondTimer.invalidate()
            timerLabel.text="00:00"
        }
    }
    
//    一度目のスタート
    @objc func didTapStartButton(){
        shape.speed=1.0
        let animation=CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue=1
        animation.duration = CFTimeInterval(runtime)
        animation.isRemovedOnCompletion=false
        animation.fillMode = .forwards
        shape.add(animation,forKey: "animation")
        
        timerLabel.isHidden=false
        firstTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(firstCountDown), userInfo: nil, repeats: true)
        
        UIButton.animate(withDuration: 0.5, animations: {
             self.startButton.alpha = 0
        }, completion:  { _ in
               self.startButton.isHidden = true
        })
        stopButton.isHidden=false
        stopButton.alpha=0
        UIButton.animate(withDuration: 0.5, animations: {
            self.stopButton.alpha=1
            self.resetButton.alpha=1
        })
        resetButton.isEnabled=true
    }
    

//    ストップ
    @objc func didTapStopButton(){
        let pausedTime=shape.convertTime(CACurrentMediaTime(), from: nil)
        shape.speed=0.0
        shape.timeOffset = pausedTime
        stopButton.isHidden=true
        restartButton.isHidden=false

//        check!!
        resetButton.isEnabled=true
        
        stopCountDown()
    }
    
//    二度目以降のスタート
    @objc func didTapRestartButton(){
        let pausedTime=shape.timeOffset
        shape.speed=1.0
        shape.timeOffset=0.0
        shape.beginTime=0.0
        let timeSincePause:CFTimeInterval=shape.convertTime(CACurrentMediaTime(), from: nil)-pausedTime
        shape.beginTime=timeSincePause
        restartButton.isHidden=true
        stopButton.isHidden=false
        resetButton.isEnabled=true
        
        secondTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondCountDown), userInfo: nil, repeats: true)
        
    }
    
//    リセット
    @objc func didTapResetButton(){
        
        //タイマーが止まっていなかったら止める
        if firstTimer.isValid{
            firstTimer.invalidate()
            didTapStopButton()
        }
        if secondTimer.isValid{
            secondTimer.invalidate()
            didTapStopButton()
        }
        
        //shapeの位置をリセットする
        shape.timeOffset = 0.0

        restartButton.isHidden=true
        stopButton.isHidden=true
        startButton.isHidden=false
        
        firsttime = 600
        
        let min = Int(firsttime/60)
        let sec = Int(firsttime) % 60
        timerLabel.text = String(format: "%02d:%02d", min,sec)
        timerLabel.isHidden = true
    }

}
