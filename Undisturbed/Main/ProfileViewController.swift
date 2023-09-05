//
//  ProfileViewController.swift
//  Undisturbed
//
//  Created by Monica Qiu on 9/1/23.
//

import UIKit

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
        if let email = APICaller.shared.currentUser?.email {
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
        APICaller.shared.signOut { [weak self] success in
            guard let self else { return }
            
            DispatchQueue.main.async {
                if success {
                    self.transitionToLoginScreen()
                } else {
                    self.showSignOutFailedAlert()
                }
            }

        }
    }
    
    private func showSignOutFailedAlert() {
        let alert = UIAlertController(title: "Failed to Sign Out", message: "Please check your network and try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        
        present(alert, animated: true)
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
