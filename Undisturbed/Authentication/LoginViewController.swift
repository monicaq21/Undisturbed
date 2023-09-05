//
//  LoginViewController.swift
//  Undisturbed
//
//  Created by Monica Qiu on 9/3/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        errorLabel.isHidden = true
    }

    @IBAction func loginBtnTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }
        
        APICaller.shared.signIn(email: email, password: password) { [weak self] success in
            guard let self else { return }
            DispatchQueue.main.async {
                if success {
                    self.transitionToHomeScreen()
                } else {
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = "The email or password you entered is incorrect."
                }
            }
        }
    }
    
    @IBAction func toSignupBtnTapped(_ sender: Any) {
        transitionToSignupScreen()
    }
    
    private func transitionToHomeScreen() {
        DispatchQueue.main.async {
            let vc = UINavigationController(rootViewController: TabBarViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true) {
                self.navigationController?.popToRootViewController(animated: false)
            }
        }
    }
    
    private func transitionToSignupScreen() {
        DispatchQueue.main.async {
            let vc = UINavigationController(rootViewController: SignupViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true) {
                self.navigationController?.popToRootViewController(animated: false)
            }
        }
    }
    

}
