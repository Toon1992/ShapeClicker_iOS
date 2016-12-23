//
//  HighscoreViewController.swift
//  ShapeClicker
//
//  Created by Toon De True on 23/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import UIKit

//source: https://www.ralfebert.de/tutorials/ios-swift-uitableviewcontroller/custom-cells/

class HighScoreTableViewCell: UITableViewCell{
        //properties
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblPlayerName: UILabel!
    
}

class HighscoreViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //Properties
    @IBOutlet weak var highscoreTableView: UITableView!
    let textcellIdentifier = "TableCell"
    var highScoresArr = [Player]()
    
    var highScore : HighScore = HighScore.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highScoresArr = highScore.getHighScores()
        highscoreTableView.delegate = self
        highscoreTableView.dataSource = self
        
        
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       return highScoresArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = highscoreTableView.dequeueReusableCell(withIdentifier: textcellIdentifier) as! HighScoreTableViewCell
        
        let row = indexPath.row
        cell.lblPlayerName.text = highScoresArr[row].playerName
        cell.lblScore.text = highScoresArr[row].score
        
        return cell
    }
}
