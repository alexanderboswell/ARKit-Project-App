//
//  ViewController.swift
//  ARKit Project
//
//  Created by alexander boswell on 11/11/17.
//  Copyright © 2017 alexander boswell. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class SolarSystemViewController: UIViewController, ARSCNViewDelegate {
	
	@IBOutlet var sceneView: ARSCNView!
	var fileName: String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Set the view's delegate
		sceneView.delegate = self
		
		// Show statistics such as fps and timing information
		sceneView.showsStatistics = true
		
		guard let fileName = fileName else {
			return
		}
		
		// Create a new scene
		let scene = SCNScene(named: "art.scnassets/\(fileName).scn")!
		// Set the scene to the view
		sceneView.scene = scene
		
	}
    
	@IBAction func tap(_ sender: UITapGestureRecognizer) {
		if sender.state == UIGestureRecognizerState.recognized
		{
			let location: CGPoint = sender.location(in:sender.view) // for example from a tap gesture recognizer
			let hits = self.sceneView.hitTest(location, options: nil)
			if let tappedNode = hits.first?.node {
				print("\n\n\n\n")
                print(tappedNode.name ?? "")
				if tappedNode.name != "torus" {
                    if let name = tappedNode.name, !name.contains("Label") {
                        if let planetLabelNode = sceneView.scene.rootNode.childNode(withName: "\(name)Label", recursively: true) {
                            planetLabelNode.removeFromParentNode()
                        } else {
                            let text = SCNText(string: "\(tappedNode.name ?? "")>", extrusionDepth: 1)
                            
                            let material = SCNMaterial()
                            material.diffuse.contents = UIColor.lightGray
                            text.materials = [material]
                            let node = SCNNode()
                            node.name = "\(name)Label"
                            node.position = SCNVector3(x:tappedNode.position.x - Float(text.containerFrame.width / 2), y:tappedNode.position.y + (tappedNode.geometry?.boundingBox.max.y)!, z:tappedNode.position.z)
                            if tappedNode.name == "Sun" {
                                node.scale = SCNVector3(x: 0.8,y: 0.2,z: 0.8)
                            } else {
                                node.scale = SCNVector3(x: 0.02,y: 0.02,z: 0.02)
                            }
                            node.geometry = text
                            sceneView.scene.rootNode.addChildNode(node)
                        }
                    } else if let name = tappedNode.name {
                        let planetVC = SolarSystemViewController.makeFromStoryboard()
                        planetVC.fileName = name.minus("Label")
                        navigationController?.pushViewController(planetVC, animated: true)
                    }
				}
			}
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Create a session configuration
		let configuration = ARWorldTrackingConfiguration()
		
		// Run the view's session
		sceneView.session.run(configuration)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		// Pause the view's session
		sceneView.session.pause()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Release any cached data, images, etc that aren't in use.
	}
	// MARK: - ARSCNViewDelegate
	
	/*
	// Override to create and configure nodes for anchors added to the view's session.
	func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
	let node = SCNNode()
	
	return node
	}
	*/
	
	func session(_ session: ARSession, didFailWithError error: Error) {
		// Present an error message to the user
		
	}
	
	func sessionWasInterrupted(_ session: ARSession) {
		// Inform the user that the session has been interrupted, for example, by presenting an overlay
		
	}
	
	func sessionInterruptionEnded(_ session: ARSession) {
		// Reset tracking and/or remove existing anchors if consistent tracking is required
		
	}
    
    static func makeFromStoryboard() -> SolarSystemViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SolarSystemViewController") as! SolarSystemViewController
    }
}
