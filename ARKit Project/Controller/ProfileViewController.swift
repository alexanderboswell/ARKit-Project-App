//
//  ProfileViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/8/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

	@IBOutlet weak var profileImageView: UIImageView!
	override func viewDidLoad() {
        super.viewDidLoad()
		
		setupUI()
    }
	
	private func setupUI() {
		profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
		profileImageView.clipsToBounds = true
		
		title = "Profile"
	}
}
