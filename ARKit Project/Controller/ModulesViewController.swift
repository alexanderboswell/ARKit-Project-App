//
//  ModulesViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/7/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

private let APP_URL = "https://itunes.apple.com/us/app/arocket/id1352097337?ls=1&mt=8"

class ModulesViewController: UICollectionViewController {
	
    //MARK: Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var shareButton: UIBarButtonItem!
	
	//MARK: Private variables
    
	private var modules: [Module] = []
	private struct Storyboard {
		static let moduleCellIdentifier = "ModuleCell"
		static let sectionInsets = UIEdgeInsets(top: 6.0, left: 4.0, bottom: 6.0, right: 4.0)
		static let itemsPerRow: CGFloat = 2.0
		static let activitiesSegueIdentifier = "ShowActivities"
	}
	
	//MARK: Viewcontroller lifecycle
	
	override func viewDidLoad() {
		loadModules()
	}
	
	//MARK: Actions
	
	@IBAction func share(_ sender: Any) {
		//Set the default sharing message.
		let message = "Check out this new augmented reality app!"
		//Set the link to share.
		if let link = NSURL(string: APP_URL)
		{
			let objectsToShare = [message,link] as [Any]
			let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
			activityVC.excludedActivityTypes = [.addToReadingList, .assignToContact, .markupAsPDF, .openInIBooks, .saveToCameraRoll]
			self.present(activityVC, animated: true, completion: nil)
		}
	}
	
	//MARK: Custom methods
	
	private func loadModules() {
		Client.getModules { (modules, error) in
			if let modules = modules {
				self.modules = modules
                self.activityIndicator.stopAnimating()
				self.collectionView?.reloadData()
			}
		}
	}

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modules.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.moduleCellIdentifier, for: indexPath) as? ModuleCell else {
			return UICollectionViewCell()
		}
		let module = modules[indexPath.row]
		cell.titleLabel.text = module.title
		cell.descriptionLabel.text = module.description
		cell.backgroundColor = module.backgroundColor
		cell.image.image = module.image
    	cell.layer.cornerRadius = 10
		cell.arrowImage.isHidden = !module.isActive
		
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if modules[indexPath.row].isActive {
        	performSegue(withIdentifier: Storyboard.activitiesSegueIdentifier, sender: nil)
		}
    }
}

//Calculate cell size based on device and orientation
extension ModulesViewController : UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let paddingSpace = Storyboard.sectionInsets.left * ( Storyboard.itemsPerRow + 1)
		let width = view.frame.width
		let height = view.frame.height
		if UIDevice.current.orientation.isLandscape {
			if width > 600 && height > 600 {
				return CGSize(width: height / 3 - paddingSpace, height: width / 10)
			} else {
				return CGSize(width: width / 2 - paddingSpace, height: height / 2.8)
			}
		} else {
			if width > 600 && height > 600 {
				return CGSize(width: view.frame.width / 3 - paddingSpace, height: view.frame.height / 10)
			} else {
				return CGSize(width: view.frame.width - paddingSpace, height: view.frame.height / 5)
			}
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return Storyboard.sectionInsets
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return Storyboard.sectionInsets.left
	}
}
