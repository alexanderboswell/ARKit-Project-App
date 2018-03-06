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
        
        planets["SunPlanet"] = Planet(name: "Sun", rotationSpeed: 24.47, revolutionSpeed: 0.0, maxLabelScale: 10.0)
        planets["MercuryPlanet"] = Planet(name: "Mercury", rotationSpeed: 58.65, revolutionSpeed: 88.0, maxLabelScale: 10.0)
        planets["VenusPlanet"] = Planet(name: "Venus", rotationSpeed: 116.75, revolutionSpeed: 224.7, maxLabelScale: 10.0)
        planets["EarthPlanet"] = Planet(name: "Earth", rotationSpeed: 1.0, revolutionSpeed: 365.2, maxLabelScale: 10.0)
        planets["MarsPlanet"] = Planet(name: "Mars", rotationSpeed: 1.03, revolutionSpeed: 687.0, maxLabelScale: 10.0)
        planets["JupiterPlanet"] = Planet(name: "Jupiter", rotationSpeed: 0.42, revolutionSpeed: 4331.0, maxLabelScale: 55.0)
        planets["SaturnPlanet"] = Planet(name: "Saturn", rotationSpeed: 0.44, revolutionSpeed: 10747.0, maxLabelScale: 55.0)
        planets["UranusPlanet"] = Planet(name: "Uranus", rotationSpeed: 0.72, revolutionSpeed: 30589.0, maxLabelScale: 35.0)
        planets["NeptunePlanet"] = Planet(name: "Neptune", rotationSpeed: 0.67, revolutionSpeed: 59800.0, maxLabelScale: 30.0)
        planets["PlutoPlanet"] = Planet(name: "Pluto", rotationSpeed: 6.39, revolutionSpeed: 90560.0, maxLabelScale: 30.0)
        planets["MoonPlanet"] = Planet(name: "Moon", rotationSpeed: 27.0, revolutionSpeed: 27.32, maxLabelScale: 1.0)
        
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
            return Planet(name: "notAPlanet", rotationSpeed: 0.0, revolutionSpeed: 0.0, maxLabelScale: 0.0)
        }
    }
    
    
    
}
