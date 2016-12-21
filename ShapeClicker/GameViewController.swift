//
//  GameController.swift
//  ShapeClicker
//
//  Created by Toon De True on 20/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import UIKit

internal class GameViewController: UIViewController {
    
    //Properties
    @IBOutlet weak var lblFindElement: UILabel!
    @IBOutlet weak var progressTimer: UIProgressView!
    @IBOutlet weak var stvUp: UIStackView!
    @IBOutlet weak var stvDown: UIStackView!
    @IBOutlet weak var lblScore: UILabel!
    
    private var game = Game()
    private var viewShapes = [ColorShape]()
    
    private var timer = Timer()
    private var poseDuration = 1000
    private var indexProgressbar = 999
    private var maxTimeInterval = 0.007
    private var timeInterval = 0.0
    private let maxAddTime = 50
    private var addTime = 0
    private var player : Player = Player()
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize(){
        timeInterval = maxTimeInterval
        addTime = maxAddTime
        
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
        switch colorShape.shape {
        case Shape.cirkel:
            lblFindElement.text = "Cirkel"
            break
        case Shape.rectangle:
            lblFindElement.text = "Rectangle"
            break
        case Shape.triangle:
            lblFindElement.text = "Triangle"
            break
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
        var flag = true
        var index = 0
        
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
            
            if flag {
                stvUp.addArrangedSubview(imagev)
            } else {
                stvDown.addArrangedSubview(imagev)
            }
            
            index += 1
        }
    }
    
    func tap(_ sender: UITapGestureRecognizer){
       let tag = sender.view!.tag
       let shape = viewShapes[tag]
        
       let isCorrect = game.checkIfCorrectShape(colorShape: shape)
    
        if isCorrect{
            addSubtractTime(time: addTime * 2)
            game.addScore(shape: shape)
            refreshScoreLabel()
        } else {
            addSubtractTime(time: addTime * -1)
        }
        
       reset()
    }
    
    private func removeViewsFromStack(stack: UIStackView ){
        for view in stack.subviews{
            view.removeFromSuperview()
        }
        
    }
    
    private func reset(){
        removeViewsFromStack(stack: stvUp)
        removeViewsFromStack(stack: stvDown)
        viewShapes = game.getViewShapes()
        setLabel()
        fillStacks()
    }
    
    
}
