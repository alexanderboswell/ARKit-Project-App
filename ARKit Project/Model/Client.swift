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
		callback([Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 76/255, green: 76/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem")],nil)
	}
	
	static func getActivities(callback: @escaping ([Activity]?, Error?) -> Void) {
		callback ([Activity(title: "Solar System", imageName: "EarthActivity"),
				   Activity(title: "Mercury", imageName: "EarthActivity"),
				   Activity(title: "Venus", imageName: "EarthActivity"),
				   Activity(title: "Earth", imageName: "EarthActivity"),
				   Activity(title: "Mars", imageName: "EarthActivity"),
				   Activity(title: "Jupiter", imageName: "EarthActivity"),
				   Activity(title: "Saturn", imageName: "EarthActivity"),
				   Activity(title: "Uranus", imageName: "EarthActivity"),
				   Activity(title: "Neptune", imageName: "EarthActivity"),
				   Activity(title: "Pluto", imageName: "EarthActivity")], nil)
	}
}
