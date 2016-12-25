//
//  ChooseViewController.swift
//  ShapeClicker
//
//  Created by Toon De True on 25/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController{
    
    @IBOutlet weak var vClickColor: UIView!
    @IBOutlet weak var vClickShape: UIView!
    private var tag : Int = 0
    private var player: Player = Player()
    
    public func setPlayer(player: Player){
        self.player = player
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       initialize(viewGame: vClickShape)
       initialize(viewGame: vClickColor)
    }
    
    private func initialize(viewGame: UIView){
        viewGame.layer.cornerRadius = 8.0
        viewGame.tag = tag
        
        addTouchEvent(viewGame: viewGame)
        
        tag += 1
    }
    
    func tap(_ sender: UITapGestureRecognizer){
        let sendTag = sender.view!.tag
        
        if let resultController = storyboard!.instantiateViewController(withIdentifier: "Game") as? GameViewController{
            if sendTag == 0{
                    resultController.setGame(isShape: true)
            } else {
                    resultController.setGame(isShape: false)
            }
                resultController.setPlayer(player: player)
                present(resultController, animated: true, completion: nil)
            }
    }
    
    private func addTouchEvent(viewGame : UIView){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tap) )
        viewGame.addGestureRecognizer(gesture)
    }
}
