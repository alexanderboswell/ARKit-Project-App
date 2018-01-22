//
//  ProfileViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/8/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

	//MARK: Outlets
	
	@IBOutlet weak var profileImageView: UIImageView!
	
	//MARK: Viewcontroller lifecycle
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		setupUI()
    }
	
	//MARK: Custom methods
	
	private func setupUI() {
		profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
		profileImageView.clipsToBounds = true
		
		title = "Profile"
	}
	
	//MARK: Actions
	
	@IBAction func close(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
}
