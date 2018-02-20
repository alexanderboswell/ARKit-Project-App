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
				   Activity(title: "Mercury", imageName: "Mercury"),
				   Activity(title: "Venus", imageName: "Venus"),
				   Activity(title: "Earth", imageName: "Earth"),
				   Activity(title: "Mars", imageName: "Mars"),
				   Activity(title: "Jupiter", imageName: "Jupiter"),
				   Activity(title: "Saturn", imageName: "Saturn"),
				   Activity(title: "Uranus", imageName: "Uranus"),
				   Activity(title: "Neptune", imageName: "Neptune"),
				   Activity(title: "Pluto", imageName: "Pluto")], nil)
	}
}
