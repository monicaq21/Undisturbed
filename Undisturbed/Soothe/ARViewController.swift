//
//  ARViewController.swift
//  Undisturbed
//
//  Created by Monica Qiu on 9/2/23.
//

import UIKit

class ARViewController: UIViewController {
    
    var sceneOption: SceneOption?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBarController?.tabBar.isHidden = true
        
        presentAR()
    }
    
    private func presentAR() {
        guard let sceneOption else { return }
        
        print(sceneOption.rawValue)
    }

}
