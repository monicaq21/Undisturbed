//
//  ARViewController.swift
//  Undisturbed
//
//  Created by Monica Qiu on 9/2/23.
//

import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    var sceneOption: SceneOption?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBarController?.tabBar.isHidden = true
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // help debug
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        presentAR()
    }
    
    private func presentAR() {
        guard let sceneOption else { return }
        
        print(sceneOption.rawValue)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touchPoint = touches.first?.location(in: sceneView) else { return }
        
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

}
