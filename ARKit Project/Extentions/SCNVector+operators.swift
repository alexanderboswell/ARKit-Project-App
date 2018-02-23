//
//  SCNVector+operators.swift
//  ARKit Project
//
//  Created by Christian Riboldi on 1/29/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import SceneKit

extension SCNVector3 {
    
    static prefix func -(prefix: SCNVector3) -> SCNVector3 {
        return SCNVector3(-prefix.x, -prefix.y, -prefix.z)
    }
    
    static func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
    }
    
    func getText() -> String {
        return "x:\(self.x), y:\(self.y), z:\(self.z)"
    }
    
}

