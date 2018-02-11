//
//  Planets.swift
//  ARKit Project
//
//  Created by Christian Riboldi on 2/10/18.
//  Copyright © 2018 alexander boswell. All rights reserved.
//

import Foundation

class Planets {
    
    enum planetNames: String {
        case sun, mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto, moon
        static let allValues = [sun, mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto, moon]
    }
    
    var planets: [String:Planet]
    
    required init() {
        planets = [String:Planet]()
        for name in planetNames.allValues {
            let planet = Planet(name: name.rawValue.capitalized, rotationSpeed: Double.random(max: 5, min: 20), revolutionSpeed: Double.random(max: 10, min: 50))
            planets[planet.nodeName] = planet
        }
    }
    
    func isValidKey(name: String) -> Bool {
        return planets[name] != nil ? true : false
    }
    
    subscript(name: String) -> Planet {
        get {
            assert(isValidKey(name: name), "Node name is not valid")
            if let planet = planets[name] {
                return planet
            }
            // Should never reach this because it should be a valid key.
            return Planet(name: "notAPlanet", rotationSpeed: 0.0, revolutionSpeed: 0.0)
        }
    }
    
    
    
}
