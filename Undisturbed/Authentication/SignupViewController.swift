//
//  SignupViewController.swift
//  Undisturbed
//
//  Created by Monica Qiu on 9/3/23.
//

import UIKit

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
        
        APICaller.shared.signUp(email: email, password: password) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let authResult):
                    self.setupNewUserInfo(id: authResult.user.uid)
                    self.transitionToHomeScreen()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = "Sorry, sign up failed for internal reasons. Please try again in a bit." // make pw better
                    return
                }
            }

        }
        
    }
    
    private func setupNewUserInfo(id: String) {
        
        let userRef = Database.database().reference(withPath: "users").child(id)
        
        // their trigger sound preferences
        let triggersDict = makeTriggersDictionary()
        
        // their misophonia score
        let misoScore = -1
        
        // set the values
        userRef.setValue(["misophonia_score": misoScore]) { error, _ in
            if let error = error {
                print("Error storing misophonia score: \(error.localizedDescription)")
            }
        }
                         
        userRef.child("triggers").setValue(triggersDict) { error, _ in
            if let error = error {
                print("Error storing triggers: \(error.localizedDescription)")
            }
        }
        
    }
    
    private func makeTriggersDictionary() -> [String: [String: Any]] {
        
        var triggers = [Trigger]()
        triggers.append(Trigger(name: "Wet Chewing"))
        triggers.append(Trigger(name: "Chalk Scratching"))
        triggers.append(Trigger(name: "Yawning"))
        triggers.append(Trigger(name: "Tapping"))
        triggers.append(Trigger(name: "Sniffing"))
        
        var triggersDict = [String: [String: Any]]()
        for i in (0..<triggers.count) {
            triggersDict["\(i)"] = [
                "name": triggers[i].name,
                "score": 3
            ]
        }
        return triggersDict
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
