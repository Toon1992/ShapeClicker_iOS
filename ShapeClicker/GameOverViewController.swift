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
    
    @IBOutlet weak var lblTotalScore: UILabel!
    @IBOutlet weak var lblPlayerName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
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
    
//    private func setView(){
//        self.vPopup.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        self.vPopup.layer.cornerRadius = 5
//        self.vPopup.layer.shadowOpacity = 0.8
//        self.vPopup.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//    }
//    
//    public func showView(aView: UIView! ){
//        aView.addSubview(self.vPopup)
//    }
//    
    
}
