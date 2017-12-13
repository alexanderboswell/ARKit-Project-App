//
//  ActivitiesViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 12/8/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit

class ActivitiesViewController: UICollectionViewController {
    
	private var activities: [Activity] = []
	private struct Storyboard {
		static let sectionInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
		static let activityCellIdentifier = "ActivityCell"
		static let arscnSegueIdentifier = "OpenARSCNScene"
	}
	
	//MARK: View Controller lifecycle
	
	override func viewDidLoad() {
		loadActivities()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Storyboard.arscnSegueIdentifier {
			if let vc = segue.destination as? SolarSystemViewController {
				vc.fileName = "Earth"
			}
		}
	}
	
	//MARK: Custom methods
	
	private func loadActivities() {
		Client.getActivities { (activities, error) in
			if let activities = activities {
				self.activities = activities
				self.collectionView?.reloadData()
			}
		}
	}
	
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activities.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.activityCellIdentifier, for: indexPath) as? ActivityCell else {
            return UICollectionViewCell()
        }
        let activity = activities[indexPath.row]
        cell.title.text = activity.title
        cell.image.image = activity.image
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 10
        return cell
    }
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		performSegue(withIdentifier: Storyboard.arscnSegueIdentifier, sender: nil)
	}
}

extension ActivitiesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = view.frame.width
		let height = view.frame.height
		let buffer = view.frame.width - view.safeAreaLayoutGuide.layoutFrame.size.width
        if UIDevice.current.orientation.isLandscape {
			if width > 700 && height > 700 {
            	return CGSize(width: height / 4 - 10 , height: width / 15)
			} else {
				return CGSize(width: width - 10 - (buffer / 2), height: height / 4)
			}
        } else {
			if width > 700 && height > 700 {
				return CGSize(width: width / 4 - 10, height: height / 15)
			} else {
				return CGSize(width: width - 10  - (buffer / 2), height: height / 8)
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
