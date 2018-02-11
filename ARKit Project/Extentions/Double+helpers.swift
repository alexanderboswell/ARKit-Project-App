//
//  Double+helpers.swift
//  ARKit Project
//
//  Created by Christian Riboldi on 2/10/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import Foundation

extension Double {
    
    static func random(max maxInt: Int, min minInt: Int) -> Double {
        return self.random(max: Double(maxInt), min: Double(minInt))
    }
    
    static func random(max: Double, min: Double) -> Double {
        return (drand48() * max) + min
    }
}
