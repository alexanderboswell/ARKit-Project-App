//
//  Client.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/9/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//
import UIKit

class Client {
	static func getModules(callback: @escaping ([Module]?, Error?) -> Void) {
		callback([Module(title: "Solar System", description: "Rocket your way through all the planets in augmented reality!", backgroundColor: UIColor(red: 76/255, green: 76/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystemModule", isActive: true),
				  Module(title: "Coming Soon!", description: "More modules exploring other aspects of education will be available soon.", backgroundColor: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0), imageName: "AtomModule", isActive: false)],nil)
	}
	
	static func getActivities(callback: @escaping ([Activity]?, Error?) -> Void) {
		callback ([Activity(title: "Solar System", imageName: "SolarSystem"),
				   Activity(title: "Mercury", imageName: "Mercury"),
				   Activity(title: "Venus", imageName: "Venus"),
				   Activity(title: "Earth", imageName: "Earth"),
				   Activity(title: "Mars", imageName: "Mars"),
				   Activity(title: "Moon", imageName: "Moon"),
				   Activity(title: "Sun", imageName: "Sun"),
				   Activity(title: "Jupiter", imageName: "Jupiter"),
				   Activity(title: "Saturn", imageName: "Saturn"),
				   Activity(title: "Uranus", imageName: "Uranus"),
				   Activity(title: "Neptune", imageName: "Neptune"),
				   Activity(title: "Pluto", imageName: "Pluto")], nil)
	}
}
