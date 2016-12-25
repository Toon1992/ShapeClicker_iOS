//
//  GameOverPopUpViewController.swift
//  ShapeClicker
//
//  Created by Toon De True on 21/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import UIKit

internal class GameOverViewController : UIViewController{
    
    //properties
    private var score = 0
    private var player : Player = Player()
    private var highscores: HighScore = HighScore.instance
    
    @IBOutlet weak var lblTotalScore: UILabel!
    @IBOutlet weak var lblPlayerName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
      
        checkHighScore()
        
    }
    
    private func checkHighScore(){
       player.score = score
       highscores.addHighScore(highscore: player)
        highscores.checkHighScore()
    }
    
    private func setLabels(){
        lblTotalScore.text = String(score)
        lblPlayerName.text = player.playerName
    }
    
    public func setScore(score: Int){
        self.score = score
    }
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
}
