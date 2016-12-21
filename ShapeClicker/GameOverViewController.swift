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
    var score = 0
    
    @IBOutlet weak var lblTotalScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    
    private func setLabels(){
        lblTotalScore.text = String(score)
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
