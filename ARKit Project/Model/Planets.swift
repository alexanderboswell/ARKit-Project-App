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
        
        planets["SunPlanet"] = Planet(name: "Sun", rotationSpeed: 10, revolutionSpeed: 100)
        planets["MercuryPlanet"] = Planet(name: "Mercury", rotationSpeed: 10, revolutionSpeed: 100)
        planets["VenusPlanet"] = Planet(name: "Venus", rotationSpeed: 10, revolutionSpeed: 100)
        planets["EarthPlanet"] = Planet(name: "Earth", rotationSpeed: 10, revolutionSpeed: 100)
        planets["MarsPlanet"] = Planet(name: "Mars", rotationSpeed: 10, revolutionSpeed: 100)
        planets["JupiterPlanet"] = Planet(name: "Jupiter", rotationSpeed: 10, revolutionSpeed: 100)
        planets["SaturnPlanet"] = Planet(name: "Saturn", rotationSpeed: 10, revolutionSpeed: 100)
        planets["UranusPlanet"] = Planet(name: "Uranus", rotationSpeed: 10, revolutionSpeed: 100)
        planets["NeptunePlanet"] = Planet(name: "Neptune", rotationSpeed: 10, revolutionSpeed: 100)
        planets["PlutoPlanet"] = Planet(name: "Pluto", rotationSpeed: 10, revolutionSpeed: 100)
        planets["MoonPlanet"] = Planet(name: "Moon", rotationSpeed: 10, revolutionSpeed: 100)
        
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
