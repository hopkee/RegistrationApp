//
//  SignInVC.swift
//  RegistrationApp
//
//  Created by Валентин Величко on 29.01.22.
//

import UIKit

final class SignInVC: UIViewController {
    
    private var email: String?
    private var password: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func createAccountBtn() {
        let signUpStoryboard = UIStoryboard(name: "SignUpStoryboard", bundle: nil)
        guard let SignUpUIVC = signUpStoryboard.instantiateViewController(withIdentifier: "CreateAccountVC") as? CreateAccountVC else {
         return }
        navigationController?.pushViewController(SignUpUIVC, animated: true)
    }

    @IBAction private func emailField(_ sender: UITextField) {
        if sender.text?.count ?? 0 > 0 {
            signInBtnOutlet.isEnabled = true
            email = sender.text
            errorLabel.isHidden = true
        }
    }
    
    @IBAction private func passField(_ sender: UITextField) {
        if sender.text?.count ?? 0 > 0 {
            signInBtnOutlet.isEnabled = true
            password = sender.text
            errorLabel.isHidden = true
        }
    }
    
    @IBAction private func signInBtn(_ sender: UIButton) {
        if VerificationService.checkUser(email: email, password: password) {
            performSegue(withIdentifier: "Go_To_Main", sender: nil)
        } else {
            errorLabel.isHidden = false
        }
    }
        
    @IBOutlet weak private var signInBtnOutlet: UIButton!
    @IBOutlet weak private var errorLabel: UILabel!
}
