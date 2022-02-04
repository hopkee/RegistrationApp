//
//  WelcomeVC.swift
//  RegistrationApp
//
//  Created by Валентин Величко on 29.01.22.
//

import UIKit

final class WelcomeVC: UIViewController {

    var name: String?
    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateName()
        createNewUser(name: name, pass: password, email: email)
    }
    
    @IBOutlet weak private var welcomeLabel: UILabel!
    

    @IBAction private func btnGoSignIn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func updateName() {
        if let nameForLabel = name {
            welcomeLabel.text?.append(" " + nameForLabel)
        }
    }
    
    private func createNewUser(name: String?, pass: String?, email: String?) {
        let newUser = [pass, name]
        if let emailToWrite = email {
            UserDefaults.standard.set(newUser, forKey: emailToWrite)
        }
    }
}
