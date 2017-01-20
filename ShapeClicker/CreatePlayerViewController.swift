//
//  CreatePlayerViewController.swift
//  ShapeClicker
//
//  Created by Toon De True on 21/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import UIKit

internal class CreatePlayerViewController : UIViewController{
    
    //properties
    @IBOutlet weak var txfPlayerName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var player: Player = Player()
        let name = txfPlayerName.text!
        
        if name.isEmpty{
            player.playerName = "Guest"
        }
        
        let destinationVC = segue.destination as! ChooseViewController
        destinationVC.setPlayer(player: player)
    }
    
    private func startGame(player: Player){
        if let resultController = storyboard!.instantiateViewController(withIdentifier: "chooseGame") as? ChooseViewController{
            resultController.setPlayer(player: player)
            present(resultController, animated: true, completion: nil)
        }
    }
}
