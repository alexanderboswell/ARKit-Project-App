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
		callback([Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 76/255, green: 76/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
											 Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 176/255, green: 0/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
											 Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 3/255, green: 176/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
											 Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 76/255, green: 76/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
											 Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 176/255, green: 0/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
											 Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 3/255, green: 176/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
											 Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 76/255, green: 76/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
											 Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 176/255, green: 0/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem"),
											 Module(title: "Solar System", description: "This is a long description for the solar system module, module, module, module.", backgroundColor: UIColor(red: 3/255, green: 176/255, blue: 207/255, alpha: 1.0), imageName: "SolarSystem")], nil)
	}
	
	static func getActivities(callback: @escaping ([Activity]?, Error?) -> Void) {
		callback ([Activity(title: "Earth", imageName: "EarthActivity"),
				   Activity(title: "Earth", imageName: "EarthActivity"),
				   Activity(title: "Earth", imageName: "EarthActivity"),
				   Activity(title: "Earth", imageName: "EarthActivity"),
				   Activity(title: "Earth", imageName: "EarthActivity"),
				   Activity(title: "Earth", imageName: "EarthActivity"),
				   Activity(title: "Earth", imageName: "EarthActivity"),
				   Activity(title: "Earth", imageName: "EarthActivity")], nil)
	}
}
