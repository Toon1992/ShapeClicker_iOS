//
//  Game.swift
//  ShapeClicker
//
//  Created by Toon De True on 20/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import Foundation
import GameplayKit

class Game{
    private let MAX_SHAPES = 5
    private var viewShapes : [ColorShape]
    private var findShape : ColorShape
    private var score = 0
    
    init(){
        viewShapes = [ColorShape]()
        findShape = ColorShape()
        
        setNewShapes()
    }
    
    public func setNewShapes(){
        findShape = generateNewFindShape()
        generateViewingShapes()
    }
    
    public func generateViewingShapes(){
        if !viewShapes.isEmpty{
            viewShapes = [ColorShape]()
        }
        
        viewShapes.append(findShape)
        
        for _ in 1...MAX_SHAPES{
            viewShapes.append(generateShape())
        }
        
        if !viewShapes.contains(findShape){
            viewShapes[0] = findShape;
        }
        
        viewShapes = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: viewShapes) as! [ColorShape]
    }
    
    public func generateShape() -> ColorShape{
        let tempColor = Color(rawValue: arc4random_uniform(Color.purple.rawValue + 1))
        let tempShape = Shape(rawValue: arc4random_uniform(Shape.rectangle.rawValue + 1))
        
        return ColorShape(color: tempColor!, shape: tempShape!)
    }
    
    public func generateNewFindShape() -> ColorShape{
        findShape = generateShape()
        
        return findShape
    }
    
    public func getFindShape() -> ColorShape{
        return findShape
    }
    
    public func getViewShapes()->[ColorShape]{
        return viewShapes
    }
    
    public func checkIfCorrectShape(colorShape: ColorShape) ->Bool{
        var isCorrect: Bool = false
        
        if(findShape == colorShape){
            isCorrect = true
        }
        
        setNewShapes()
        
        return isCorrect
    }
    
    public func checkIfCorrectColor(colorShape: ColorShape)->Bool{
        var isCorrect:Bool = false
        
        if(findShape.color == colorShape.color){
            isCorrect = true
        }
        
        setNewShapes()
        
        return isCorrect
    }
    
    public func getScore()->Int{
        return score
    }
    
    public func addScore(shape: ColorShape){
        score += shape.score
    }
    
    public func getShapeString()->String{
        switch findShape.shape {
        case Shape.cirkel:
            return "Cirkel"
        case Shape.rectangle:
            return "Rectangle"
        case Shape.triangle:
            return "Triangle"
        }
    }
    
    public func getColorString()-> String{
        let number = arc4random_uniform(5)
        
        switch number {
        case 0:
            return "Red"
        case 1:
            return "Purple"
        case 2:
            return "Blue"
        case 3:
            return "Green"
        case 4:
            return "Yellow"
        default:
            return "Orange"
        }
        
    }

    
}
