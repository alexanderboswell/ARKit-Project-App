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
	
	init(title: String, description: String, backgroundColor: UIColor, imageName: String) {
		self.title = title
		self.description = description
		self.backgroundColor = backgroundColor
        
        //TODO: Load images with a background task
		if let image = UIImage(named: imageName) {
			self.image = image
		}
	}
}
