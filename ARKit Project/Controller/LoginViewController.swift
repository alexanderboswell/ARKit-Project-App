//
//  LoginViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/8/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	
	@IBOutlet weak var googleButton: UIButton!
	@IBOutlet weak var facebookButton: UIButton!
	@IBOutlet weak var emailButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }
	
	private func setupUI() {
		googleButton.layer.cornerRadius = 10
		googleButton.clipsToBounds = true
		facebookButton.layer.cornerRadius = 10
		facebookButton.clipsToBounds = true
		emailButton.layer.cornerRadius = 10
		emailButton.clipsToBounds = true
	}
	
	@IBAction func googleSignUp(_ sender: UIButton) {
	}
	
	@IBAction func facebookSignUp(_ sender: UIButton) {
	}
	
	@IBAction func emailSignUp(_ sender: UIButton) {
		
	}
	
	@IBAction func signIn(_ sender: UIButton) {
	
	}
	
	@IBAction func close(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
}
