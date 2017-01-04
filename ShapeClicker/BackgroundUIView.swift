//
//  BackgroundUIView.swift
//  ShapeClicker
//
//  Created by Toon De True on 04/01/2017.
//  Copyright © 2017 Toon De True. All rights reserved.
//

import UIKit

extension UIView{
    
    @IBInspectable var addStandaardbackgroundColor: Bool{
        get{
            if let color = layer.backgroundColor{
                return color == UIColor(red: 62/255, green: 218/255, blue: 255/255, alpha: 1).cgColor
            }
            
            return false
        } set{
            layer.backgroundColor = UIColor(red: 62/255, green: 218/255, blue: 255/255, alpha: 1).cgColor
        }
    }
    
    @IBInspectable var Shadow: Bool{
        get{
            return layer.shadowOpacity > 0.0
        }
        set{
            if newValue == true{
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
            
            if Shadow == false{
                self.layer.masksToBounds = true
            }
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
