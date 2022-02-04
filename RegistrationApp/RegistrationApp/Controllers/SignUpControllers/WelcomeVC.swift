//
//  WelcomeVC.swift
//  RegistrationApp
//
//  Created by Валентин Величко on 29.01.22.
//

import UIKit

class WelcomeVC: UIViewController {

    var name: String?
    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateName()
        createNewUser(name: name, pass: password, email: email)
    }
    
    @IBOutlet weak var welcomeLabel: UILabel!
    

    @IBAction func btnGoSignIn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignInStoryboard", bundle: nil)
        guard let signInVC = storyboard.instantiateViewController(withIdentifier: "Sign_In") as? SignInVC else { return }
        
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    private func updateName() {
        if let nameForLabel = name {
            welcomeLabel.text?.append(" " + nameForLabel)
        }
    }
    
    func createNewUser(name: String?, pass: String?, email: String?) {
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(pass, forKey: "pass")
        UserDefaults.standard.set(email, forKey: "email")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
