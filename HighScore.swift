// Created by Toon De True on 23/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import Foundation
import SwiftyJSON

class HighScore{
    private var highscores : [Player]?
    private var jsonObj : JSON?
    static let instance = HighScore()
    
    private init(){
        if(highscores == nil){
            highscores = [Player]()
            jsonObj = nil
            readJson()
        }
    }
    
    //Source: http://stackoverflow.com/questions/24410881/reading-in-a-json-file-using-swift
    //GeCode naar mijn behoefte
    private func readJson(){
        if let path = Bundle.main.path(forResource: "HighScores", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                self.jsonObj = JSON(data: data)
                if self.jsonObj == JSON.null {
                    print("Could not get json from file, make sure that file contains valid json.")
                } else {
                    fillHighScoreArr()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    private func fillHighScoreArr(){
        for item in (jsonObj?["HighScore"].arrayValue)!{
            let playerName = item["playerName"].stringValue
            let score = item["score"].stringValue
            highscores?.append(Player(playerName: playerName, score: Int(score)))
        }
    }
    
    public func getHighScores()->[Player]{
        return highscores!
    }
    
    public func addHighScore(highscore: Player){
        highscores?.append(highscore)
    }
    
    public func checkHighScore(){
        highscores?.sort{
            $0.score! > $1.score!
        }
       
        highscores?.remove(at: (highscores?.count)! - 1)
        print(highscores?.count)
        
        writeToJsonfile()
    }
    
    private func writeToJsonfile(){
        //"/Users/toondetrue/Desktop/HighScores.json"
        jsonObj?["HighScore"] = JSON(highscores)
        let str = jsonObj?.description
        let newData = str?.data(using: String.Encoding.utf8)!
        let path = "/Users/toondetrue/Desktop/IOS App/iOSProject/ShapeClicker/ShapeClicker/HighScore.swift"
        if let file = FileHandle(forWritingAtPath: path){
               file.write(newData!)

       }
        
   }
}
