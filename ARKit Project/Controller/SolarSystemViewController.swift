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
		print("here")
		if sender.state == UIGestureRecognizerState.recognized
		{
			let location: CGPoint = sender.location(in:sender.view) // for example from a tap gesture recognizer
			let hits = self.sceneView.hitTest(location, options: nil)
			if let tappedNode = hits.first?.node {
				print(tappedNode.name ?? "")
				if tappedNode.name != "torus" {
					guard let pointOfView = sceneView.pointOfView else { return }
					
					let text = SCNText(string: tappedNode.name ?? "", extrusionDepth: 1)
					
					let textNode = SCNNode(geometry: text)
					textNode.geometry = text
					textNode.position = SCNVector3Make(textNode.position.x + tappedNode.position.x , textNode.position.y + tappedNode.position.y, textNode.position.z + tappedNode.position.z)
					//					textNode.boundingBox
					sceneView.scene.rootNode.addChildNode(textNode)
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
}
