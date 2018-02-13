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
    @IBOutlet weak var toast: UIVisualEffectView!
    @IBOutlet weak var label: UILabel!
    
	let planets = Planets()
    var fileName: String!
	var dict = ["Earth": ["""
		Equatorial Diameter:      12,756 km
		Polar Diameter: 12,714 km
		Mass:    5.97 x 10^24 kg
		Moons: 1 (The Moon)
		Orbit Distance:  149,598,262 km (1 AU)
		Orbit Period:      365.24 days
		Surface Temperature:    -88 to 58°C
	""",""]]
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        guard let fileName = fileName else {
            return
        }
        title = fileName
        
		// Set the view's delegate
		sceneView.delegate = self
		
		// Show statistics such as fps and timing information
		sceneView.showsStatistics = true
		
		
		
		// Create a new scene
		let scene = SCNScene(named: "art.scnassets/\(fileName).scn")!
		// Set the scene to the view
		sceneView.scene = scene
        
        setupPlanetAnimations(node: sceneView.scene.rootNode)
		
//		if fileName != "SolarSystem" {
//			if let planetNode = sceneView.scene.rootNode.childNode(withName: "sphere", recursively: true) {
//			let text = SCNText(string: dict[fileName]?[0], extrusionDepth: 1)
//
//			let material = SCNMaterial()
//			material.diffuse.contents = UIColor.white
//			text.materials = [material]
//			let node = SCNNode()
//			node.name = "Label"
//				node.position = SCNVector3(x:(planetNode.geometry?.boundingBox.max.x)! - 0.3, y:(planetNode.position.y) - 0.3, z:(planetNode.position.z))
//				node.scale = SCNVector3(x: 0.02,y: 0.02,z: 0.02)
//			node.geometry = text
//			sceneView.scene.rootNode.addChildNode(node)
//			}
//		}
	}
    
    func setupPlanetAnimations(node parentNode: SCNNode) {
        for node in parentNode.childNodes {
            if let nodeName = node.name, nodeName.contains("Planet") {
                let planet = planets[nodeName]
                if let orbitNode = node.parent, let orbitNodeName = orbitNode.name, orbitNodeName.contains("Orbit") {
                    orbitNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: planet.revolutionSpeed)))
                    print("\(orbitNodeName) revolution was set")
                }
                node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: planet.rotationSpeed)))
                print("\(nodeName) rotation was set")
            }
            setupPlanetAnimations(node: node)
        }
    }
    
    func show() {
        sceneView.scene.rootNode.isHidden = false
    }
    
    func hide() {
        sceneView.scene.rootNode.isHidden = true
    }
    
    @IBAction func longPressTranslate(_ sender: UILongPressGestureRecognizer) {
        
        let location: CGPoint = sender.location(in: sender.view)
        print("double Tap dragging.\(location)")
        let rootLocation = sceneView.scene.rootNode.position
        
        
    }
    
	@IBAction func tap(_ sender: UITapGestureRecognizer) {
        
		if sender.state == UIGestureRecognizerState.recognized
		{
			let location: CGPoint = sender.location(in:sender.view) // for example from a tap gesture recognizer
//            print("location on Screen: \(location)")
			let hits = self.sceneView.hitTest(location, options: nil)
			if let tappedNode = hits.first?.node {
				print("\n\n\n\n")
                print(tappedNode.name ?? "")
				if tappedNode.name != "torus" {
                    if let name = tappedNode.name, !name.contains("Label") {
                        if let planetLabelNode = sceneView.scene.rootNode.childNode(withName: "\(name)Label", recursively: true) {
                            planetLabelNode.removeFromParentNode()
                        } else {
                            let text = SCNText(string: "\(tappedNode.name ?? "")", extrusionDepth: 1)
                            
                            let material = SCNMaterial()
                            material.diffuse.contents = UIColor.white
                            material.lightingModel = .constant
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
    
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        
        let location: CGPoint = sender.location(in: sceneView)
        
        let arHitTestResult = sceneView.hitTest(location, types: .existingPlane)
        if !arHitTestResult.isEmpty {
            let hit = arHitTestResult.first!
            
            sceneView.scene.rootNode.simdTransform = hit.worldTransform
        }
        
    }
	
	var temp = false
	@IBAction func pinch(_ gesture: UIPinchGestureRecognizer) {
		for node in sceneView.scene.rootNode.childNodes {
			SCNTransaction.animationDuration = 1.0
			let pinchScaleX = Float(gesture.scale) * node.scale.x
			let pinchScaleY =  Float(gesture.scale) * node.scale.y
			let pinchScaleZ =  Float(gesture.scale) * node.scale.z
			node.scale = SCNVector3(pinchScaleX, pinchScaleY, pinchScaleZ)
			gesture.scale=1
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
        startNewSession()
	}
    
    func startNewSession() {
        // Create a session configuration with horizontal plane detection
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
//        sceneView.debugOptions = [.showCameras,.showWireframe, ARSCNDebugOptions.showFeaturePoints]
        
        // Run the view's session
        sceneView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
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
	@IBAction func zoomIn(_ sender: UIBarButtonItem) {
        for node in sceneView.scene.rootNode.childNodes {
            SCNTransaction.animationDuration = 1.0
            let zoomScale: Float = 1.1
            let currentScale = node.scale
            node.scale = SCNVector3(currentScale.x*zoomScale, currentScale.y*zoomScale, currentScale.z*zoomScale)
        }
	}
	@IBAction func zoomOut(_ sender: UIBarButtonItem) {
        for node in sceneView.scene.rootNode.childNodes {
            SCNTransaction.animationDuration = 1.0
            let zoomScale: Float = 0.9
            let currentScale = node.scale
            node.scale = SCNVector3(currentScale.x*zoomScale, currentScale.y*zoomScale, currentScale.z*zoomScale)
        }
	}
	@IBAction func button1(_ sender: UIBarButtonItem) {
        guard let startingNode = sceneView.scene.rootNode.childNode(withName: "starting point", recursively: true) else {
            return
        }
        SCNTransaction.animationDuration = 1.0
        let rotationAmt: Float = Float(Double.pi)/8.0
        let rotation = startingNode.rotation
        let oldPosition = startingNode.position
        
        startingNode.position = -startingNode.position
        startingNode.rotation = SCNVector4Make(0, 1, 0, rotation.w+rotationAmt)
        startingNode.position = oldPosition
        
//        for node in startingNode.childNodes {
//
//        }
	}
	@IBAction func button2(_ sender: UIBarButtonItem) {
        
//        guard let startingNode = sceneView.scene.rootNode.childNode(withName: "starting point", recursively: true) else {
//            return
//        }
        
	}
	
	
}

extension SolarSystemViewController: ARSessionObserver {
    
//    func sessionWasInterrupted(_ session: ARSession) {
//        showToast("Session was interrupted")
//    }
//
//    func sessionInterruptionEnded(_ session: ARSession) {
//        startNewSession()
//    }
//
//    func session(_ session: ARSession, didFailWithError error: Error) {
//        showToast("Session failed: \(error.localizedDescription)")
//        startNewSession()
//    }
//
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        var message: String? = nil
        
        switch camera.trackingState {
        case .notAvailable:
            message = "Tracking not available"
        case .limited(.initializing):
            message = "Initializing AR session"
        case .limited(.excessiveMotion):
            message = "Too much motion"
        case .limited(.insufficientFeatures):
            message = "Not enough surface details"
        case .normal:
            message = "Move to find a horizontal surface"
        }
        
        message != nil ? showToast(message!) : hideToast()
    }
}

