//
//  Activity.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/8/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class Activity {
    
    var title: String
	var scnFile: String
    var image: UIImage?
    
	init(title: String, imageName: String) {
        self.title = title
		self.scnFile = imageName
        if let image = UIImage(named: imageName) {
            self.image = image
        }
    }
}
