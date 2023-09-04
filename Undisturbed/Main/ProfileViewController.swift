//
//  ProfileViewController.swift
//  Undisturbed
//
//  Created by Monica Qiu on 9/1/23.
//

import UIKit
import FirebaseAuth
import Firebase

class ProfileViewController: UIViewController {
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    let misoScoreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    let signoutBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.backgroundColor = .brown
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(emailLabel)
        if let email = Auth.auth().currentUser?.email {
            emailLabel.text = "Email: \(email)"
        } else {
            emailLabel.text = "Email: Unknown"
        }
        
        view.addSubview(misoScoreLabel)
//        if let userid = Auth.auth().currentUser?.uid,
//           let misoScore = Database.database().reference(withPath: "users").child(userid).value(forKey: "misophonia_score") as? Int {
//            if misoScore == -1 {
//                misoScoreLabel.text = "Your Misophonia Score: (haven't taken yet)"
//            } else {
//                misoScoreLabel.text = "Your Misophonia Score: \(misoScore)"
//            }
//        } else {
//            emailLabel.text = "Your Misophonia Score: backend error..."
//        }
        
        view.addSubview(signoutBtn)
        signoutBtn.addTarget(self, action: #selector(signOutBtnTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signoutBtn.frame = CGRect(x: 100, y: 100, width: view.width - 200, height: 100)
        emailLabel.frame = CGRect(x: 30, y: signoutBtn.bottom + 50, width: view.width - 60, height: 50)
    }
    
    @objc private func signOutBtnTapped() {
        do {
            try Auth.auth().signOut()
            transitionToLoginScreen()
        } catch {
            print("Signout failed")
        }
    }
    
    private func transitionToLoginScreen() {
        DispatchQueue.main.async {
            let vc = UINavigationController(rootViewController: LoginViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true) {
                self.navigationController?.popToRootViewController(animated: false)
            }
        }
    }

}
