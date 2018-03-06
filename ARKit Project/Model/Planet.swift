//
//  Planet.swift
//  ARKit Project
//
//  Created by Christian Riboldi on 2/10/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import SceneKit

class Planet {
    
    let name: String
    var nodeName: String {
        get {
            return "\(name)Planet"
        }
    }
    var orbitName: String {
        get {
            return "\(name)Orbit"
        }
    }
    var labelName: String {
        get {
            return "\(name)NameLabel"
        }
    }
    let rotationSpeed: TimeInterval!
    let revolutionSpeed: TimeInterval!
    let maxLabelScale: Float!
    
    required init(name: String, rotationSpeed: Double, revolutionSpeed: Double, maxLabelScale: Float) {
        self.name = name
        self.rotationSpeed = rotationSpeed
        self.revolutionSpeed = revolutionSpeed
        self.maxLabelScale = maxLabelScale
    }
    
}
