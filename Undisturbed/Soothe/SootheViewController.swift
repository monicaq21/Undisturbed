//
//  SootheViewController.swift
//  Undisturbed
//
//  Created by Monica Qiu on 9/1/23.
//

import UIKit

class SootheViewController: UIViewController {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return UILabel()
    }()
    
    var dropdownMenu: UIButton = {
        let button = UIButton()
        button.setTitle("Tab to switch to paper sound", for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    var startBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    var sceneOption: SceneOption = .wetMud

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(dropdownMenu)
        view.addSubview(startBtn)
        
        startBtn.addTarget(self, action: #selector(startBtnTapped), for: .touchUpInside)
        dropdownMenu.addTarget(self, action: #selector(dropdownBtnTapped), for: .touchUpInside)
        titleLabel.text = "Please choose a scenario:"
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titleLabel.frame = CGRect(
            x: 50,
            y: view.height / 3,
            width: view.width - 100,
            height: 30
        )
        
        dropdownMenu.frame = CGRect(
            x: 50,
            y: titleLabel.bottom + 50,
            width: view.width - 100,
            height: 30
        )
        
        startBtn.frame = CGRect(
            x: 50,
            y: dropdownMenu.bottom + 50,
            width: view.width - 100,
            height: 30
        )
    }
    
    @objc private func startBtnTapped() {
        let vc = ARViewController()
        vc.sceneOption = sceneOption
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func dropdownBtnTapped() {
        sceneOption = .drawPaper
    }

}
