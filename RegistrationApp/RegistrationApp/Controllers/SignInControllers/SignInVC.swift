//
//  SignInVC.swift
//  RegistrationApp
//
//  Created by Валентин Величко on 29.01.22.
//

import UIKit

class SignInVC: UIViewController {
    
    var email: String?
    var password: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccountBtn() {
        let signUpStoryboard = UIStoryboard(name: "SignUpStoryboard", bundle: nil)
        guard let SignUpUIVC = signUpStoryboard.instantiateViewController(withIdentifier: "CreateAccountVC") as? CreateAccountVC else {
         return }
        navigationController?.pushViewController(SignUpUIVC, animated: true)
    }

    @IBAction func emailField(_ sender: UITextField) {
        if sender.text?.count ?? 0 > 0 {
            signInBtnOutlet.isEnabled = true
            self.email = sender.text
            errorLabel.isHidden = true
        }
    }
    
    @IBAction func passField(_ sender: UITextField) {
        if sender.text?.count ?? 0 > 0 {
            signInBtnOutlet.isEnabled = true
            self.password = sender.text
            errorLabel.isHidden = true
        }
    }
    
    @IBAction func signInBtn(_ sender: UIButton) {
        if VerificationService.isEmailExist(email: self.email) &&
            VerificationService.isPassExist(pass: self.password) {
            performSegue(withIdentifier: "Go_To_Main", sender: nil)
        } else {
            errorLabel.isHidden = false
        }
    }
        
    @IBOutlet weak var signInBtnOutlet: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
}
