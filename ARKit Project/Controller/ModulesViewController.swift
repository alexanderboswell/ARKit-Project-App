//
//  ModulesViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/7/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class ModulesViewController: UICollectionViewController {
	
	private var modules: [Module] = []
	private struct Storyboard {
		static let moduleCellIdentifier = "ModeuleCell"
		static let sectionInsets = UIEdgeInsets(top: 6.0, left: 4.0, bottom: 6.0, right: 4.0)
		static let itemsPerRow: CGFloat = 2.0
		static let activitiesSegueIdentifier = "ShowActivities"
	}
	
	//MARK: Viewcontroller lifecycle
	
	override func viewDidLoad() {
		loadModules()
	}
	
	//MARK: Custom methods
	
	private func loadModules() {
		Client.getModules { (modules, error) in
			if let modules = modules {
				self.modules = modules
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
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Storyboard.activitiesSegueIdentifier, sender: nil)
    }
}
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
