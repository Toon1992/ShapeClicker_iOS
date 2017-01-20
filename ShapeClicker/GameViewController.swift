//
//  GameController.swift
//  ShapeClicker
//
//  Created by Toon De True on 20/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import UIKit

internal class GameViewController: UIViewController{
    
    //Properties
    @IBOutlet weak var lblFindElement: UILabel!
    @IBOutlet weak var stDown: UIStackView!
    @IBOutlet weak var stUp: UIStackView!
    @IBOutlet weak var progressTimer: UIProgressView!
    
    @IBOutlet weak var lblScore: UILabel!
    
    private var game = Game()
    private var viewShapes = [ColorShape]()
    
    private var timer = Timer()
    private var poseDuration = 500
    private var indexProgressbar = 0
    private let maxIndexProgressBar = 499
    private let maxTimeInterval = 0.007
    private var timeInterval = 0.0
    private let maxAddTime = 50
    private var addTime = 0
    private var player : Player = Player()
    private var isShapeGame: Bool = true
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    public func setGame(isShape: Bool){
        self.isShapeGame = isShape
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
    }
    
    private func initialize(){
        timeInterval = maxTimeInterval
        addTime = maxAddTime
        indexProgressbar = maxIndexProgressBar
        
        viewShapes = game.getViewShapes()
        
        setLabel()
        fillStacks()
        setProgressView()
    }
    
    private func setProgressView(){
        progressTimer.progress = 100.0
        cmdGo()
        
        progressTimer.transform = progressTimer.transform.scaledBy(x: 1,y: 5)
        progressTimer.progressTintColor = UIColor.blue
    }
    
    private func cmdGo(){
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.setProgressBar), userInfo: nil, repeats: true)
    }
    
    func setProgressBar(){
        if indexProgressbar < 0 {
            showGameOver()
            timer.invalidate()
        }
        
        //veranderen van kleur
        if indexProgressbar <= poseDuration/2 && indexProgressbar > 200 {
            progressTimer.progressTintColor = UIColor.yellow
        } else if indexProgressbar <= 200 && indexProgressbar > 0{
            progressTimer.progressTintColor = UIColor.red
        } else {
           progressTimer.progressTintColor = UIColor.blue
        }
        
        
        progressTimer.progress = Float(indexProgressbar) / Float(poseDuration - 1)
        
        indexProgressbar -= 1
    }
    
    private func showGameOver(){
        if let resultController = storyboard!.instantiateViewController(withIdentifier: "GameOver") as? GameOverViewController{
            resultController.setScore(score: game.getScore())
            resultController.setPlayer(player: player)
            present(resultController, animated: true, completion: nil)
        }
    }
    
    private func addSubtractTime(time: Int){
        indexProgressbar += time
        
        if(indexProgressbar >= maxIndexProgressBar){
            indexProgressbar = maxIndexProgressBar
        }
        
    }
    
    private func refreshScoreLabel(){
        lblScore.text = String(game.getScore())
    }
    
    private func setLabel(){
        let colorShape = game.getFindShape()
        setLabelText(colorShape: colorShape)
        setLabelColor(colorShape: colorShape)
    }
    
    private func setLabelText(colorShape: ColorShape){
        if isShapeGame{
           lblFindElement.text = game.getShapeString()
        } else {
            lblFindElement.text = game.getColorString()
        }
       
    }
    
    private func setLabelColor(colorShape: ColorShape){
        switch colorShape.color {
        case Color.blue:
            lblFindElement.textColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
            break
        case Color.red:
            lblFindElement.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            break
        case Color.green:
            lblFindElement.textColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
            break
        case Color.yellow:
            lblFindElement.textColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
            break
        case Color.purple:
            lblFindElement.textColor = UIColor(red: 1, green: 0, blue: 1, alpha: 1)
            break
        }
    }
    
    private func fillStacks(){
        var index = 0
        var flag = true
        
        for shape in viewShapes{
            let image : UIImage = UIImage(named: shape.name)!
            let imagev = UIImageView(image: image)
            imagev.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            imagev.tag = index
            
            let singleTap = UITapGestureRecognizer(target: self, action:#selector(self.tap))
            singleTap.numberOfTapsRequired = 1
            
            imagev.isUserInteractionEnabled = true
            imagev.addGestureRecognizer(singleTap)
            
            if index >= 3{
                flag = false
            }
            
            if flag{
                stUp.addArrangedSubview(imagev)
            } else {
                stDown.addArrangedSubview(imagev)
            }
            
            index += 1
        }
    }
    
    func tap(_ sender: UITapGestureRecognizer){
       let tag = sender.view!.tag
       let shape = viewShapes[tag]
        var isCorrect = false
        
        if isShapeGame {
            isCorrect = game.checkIfCorrectShape(colorShape: shape)
        } else {
            isCorrect = game.checkIfCorrectColor(colorShape: shape)
        }
    
        if isCorrect{
            addSubtractTime(time: addTime * 2)
            game.addScore(shape: shape)
            refreshScoreLabel()
        } else {
            addSubtractTime(time: addTime * -1)
        }
        
        versnellenVanTijd()
        
        reset()
    }
    
    private func versnellenVanTijd(){
        //vernellen van de timebar
        if game.getScore() > 0 && game.getScore()%500 == 0{
            timeInterval -= 0.0005
            print(timeInterval)
            if timeInterval <= 0.001{
                timeInterval = 0.001
            }
            
        }
    }
    
    private func reset(){
        viewShapes = game.getViewShapes()
        reload(stv: stUp)
        reload(stv: stDown)
        setLabel()
        fillStacks()
    }
    
    private func reload(stv: UIStackView){
        for view in stv.subviews{
            view.removeFromSuperview()
        }
    }
    
    
}
