//
//  SignInVC.swift
//  RegistrationApp
//
//  Created by Валентин Величко on 29.01.22.
//

import UIKit

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccountBtn() {
        let signUpStoryboard = UIStoryboard(name: "SignUpStoryboard", bundle: nil)
      guard let SignUpUIVC = signUpStoryboard.instantiateViewController(withIdentifier: "CreateAccountVC") as? CreateAccountVC else {
         return }
        navigationController?.pushViewController(SignUpUIVC, animated: true)
    }
    
    @IBAction func emailTextField() {
    }
    
    @IBAction func passTextField() {
    }
    
    @IBAction func signInBtnClick() {
    }
    
    @IBOutlet weak var signInBtn: UIButton!
    
}
