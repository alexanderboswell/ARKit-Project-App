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
    var image: UIImage?
    
    init(title: String, imageName: String) {
        self.title = title
        if let image = UIImage(named: imageName) {
            self.image = image
        }
    }
}
