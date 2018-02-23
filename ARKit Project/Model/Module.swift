//
//  Module.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/7/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class Module {

	var title: String
	var description: String
	var backgroundColor: UIColor
	var image: UIImage?
	var isActive: Bool
	
	init(title: String, description: String, backgroundColor: UIColor, imageName: String, isActive: Bool) {
		self.title = title
		self.description = description
		self.backgroundColor = backgroundColor
		self.isActive = isActive
        
        //TODO: Load images with a background task
		if let image = UIImage(named: imageName) {
			self.image = image
		}
	}
}
