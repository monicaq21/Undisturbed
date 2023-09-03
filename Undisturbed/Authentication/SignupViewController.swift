//
//  SignupViewController.swift
//  Undisturbed
//
//  Created by Monica Qiu on 9/3/23.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        errorLabel.isHidden = true
    }
    
    @IBAction func toLoginBtnTapped(_ sender: Any) {
        transitionToLoginScreen()
    }
    
    private func getEmailInvalidMessage() -> String? {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespaces),
              email != ""
        else { return "Please fill in an email." }
        
        return nil
    }
    
    private func getPasswordInvalidMessage() -> String? {
        guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces),
              password != ""
        else { return "Please fill in a password." }
        
        // add in password test predicate later
        
        return nil
    }

    @IBAction func signUpBtnTapped(_ sender: Any) {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return }
        
        let emailInvalidMessage = getEmailInvalidMessage()
        let passwordInvalidMessage = getPasswordInvalidMessage()
        
        if (emailInvalidMessage != nil || passwordInvalidMessage != nil) { // invalid email or password
            errorLabel.isHidden = false
            errorLabel.text = (emailInvalidMessage ?? "") + "\n" + (passwordInvalidMessage ?? "")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard error == nil
            else {
                self?.errorLabel.isHidden = false
                self?.errorLabel.text = "Sorry, sign up failed for internal reasons. Please try again in a bit."
                return
            }
            
            self?.transitionToHomeScreen()
            
        }
        
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
