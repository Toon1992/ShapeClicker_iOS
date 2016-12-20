//
//  ColorShape.swift
//  ShapeClicker
//
//  Created by Toon De True on 20/12/2016.
//  Copyright © 2016 Toon De True. All rights reserved.
//

import Foundation

class ColorShape {
    let color : Color
    let shape : Shape
    var name : String
    
    init(color: Color, shape: Shape){
        self.color = color
        self.shape = shape
        self.name = ""
        self.name = makeName()
    }
    
    init(){
        self.color = Color.blue
        self.shape = Shape.cirkel
        self.name = ""
        self.name = makeName()
    }
    
    private func makeName() -> String {
        var temp = ""
        
        switch color {
        case .blue:
            temp = "blue"
            break
        case .red:
            temp = "red"
            break
        case .green:
            temp = "green"
            break
        case .yellow:
            temp = "yellow"
            break
        case .purple:
            temp = "purple"
            break
        }

        
        switch shape {
        case .cirkel:
            temp += "cirkel"
            break
        case .rectangle:
           temp += "rectangle"
            break
        case .triangle:
            temp += "triangle"
            break
        }

        return temp
    }
}

extension ColorShape{
    
    static func ==(lhs: ColorShape, rhs: ColorShape) -> Bool{
        return lhs.shape == rhs.shape
    }
    
}
