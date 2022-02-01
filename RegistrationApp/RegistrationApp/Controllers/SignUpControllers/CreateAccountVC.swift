//
//  CreateAccountVC.swift
//  RegistrationApp
//
//  Created by Валентин Величко on 29.01.22.
//

import UIKit

final class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultStateOfScreen()
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAccountVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(CreateAccountVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func emailTextFieldAction() {
        if let email = emailTextFieldOutlet.text {
            if VerificationService.isValidEmail(email: email) {
                validEmailLabel.isHidden = true
                isEntireFormValid()
                return
            } else {
                validEmailLabel.isHidden = false
            }
        }
    }
    
    @IBAction func nameTextFieldAction() {
        if let name = nameTextFieldOutlet.text {
            if !VerificationService.isValidName(name: name) {
                validNameLabel.isHidden = false
                return
            }
        }
        validNameLabel.isHidden = true
        isEntireFormValid()
    }
    
    @IBAction func passTextFieldOneAction() {
        if let password = passOneOutlet.text {
            passStrongLevelLabel.isHidden = false
            switch VerificationService.isValidPassword(pass: password) {
            case .notVeryStrong:
                passDifficulty.setProgress(0.8, animated: true)
                passDifficulty.tintColor = .yellow
                passStrongLevelLabel.text = "Password difficulty is closer to strongest"
                isEntireFormValid()
            case .notVeryWeak:
                passDifficulty.setProgress(0.6, animated: true)
                passDifficulty.tintColor = .yellow
                passStrongLevelLabel.text = "Your password isn't very weak, try to use symbols"
                isEntireFormValid()
            case .strong:
                passDifficulty.setProgress(1, animated: true)
                passDifficulty.tintColor = .green
                passStrongLevelLabel.textColor = .green
                passStrongLevelLabel.text = "Your password is very strong"
                isEntireFormValid()
            case .veryWeak:
                passDifficulty.setProgress(0.2, animated: true)
                passDifficulty.tintColor = .red
                passStrongLevelLabel.text = "Password is too weak. Please use symbols, camel cases and numbers"
            case .weak:
                passDifficulty.setProgress(0.4, animated: true)
                passDifficulty.tintColor = .orange
                passStrongLevelLabel.text = "Your password is weak. Please use symbols and numbers"
            case .tooShort:
                passDifficulty.setProgress(0, animated: true)
                passDifficulty.tintColor = .red
                passStrongLevelLabel.text = "Password is too short. Use at least 8 characters"
            }
            if !passMatchLabel.isHidden && password.count > 0 {
                passTextFieldTwoAction()
                isEntireFormValid()
            }
        }
    }
    
    @IBAction func passTextFieldTwoAction() {
        passMatchLabel.isHidden = false
        if let passOne = passOneOutlet.text, let passTwo = passTwoOutlet.text {
            if VerificationService.isPassConfirm(pass1: passOne, pass2: passTwo) && passOne.count >= 8 {
                passMatchLabel.textColor = .green
                passMatchLabel.text = "Good! Passwords match"
                isEntireFormValid()
            } else {
                passMatchLabel.textColor = .red
                passMatchLabel.text = "Passwords don't match"
                passMatchLabel.isHidden = true
            }
        }
    }
    
    @IBAction func signUpBtnClick() {
        
    }
    
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var nameTextFieldOutlet: UITextField!
    @IBOutlet weak var passOneOutlet: UITextField!
    @IBOutlet weak var passTwoOutlet: UITextField!
    @IBOutlet weak var passDifficulty: UIProgressView!
    @IBOutlet weak var validEmailLabel: UILabel!
    @IBOutlet weak var validNameLabel: UILabel!
    @IBOutlet weak var passStrongLevelLabel: UILabel!
    @IBOutlet weak var passMatchLabel: UILabel!
    @IBOutlet weak var signUpBtnOutlet: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private func defaultStateOfScreen() {
        validEmailLabel.isHidden = true
        validNameLabel.isHidden = true
        passStrongLevelLabel.isHidden = true
        passMatchLabel.isHidden = true
        passDifficulty.setProgress(0, animated: false)
        signUpBtnOutlet.isEnabled = false
    }
    
    private func isEntireFormValid() {
        if let emailText = emailTextFieldOutlet.text {
        if validEmailLabel.isHidden,
           emailText.count > 0,
           validNameLabel.isHidden,
           passMatchLabel.textColor == .green {
            signUpBtnOutlet.isEnabled = true
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
          // if keyboard size is not available for some reason, dont do anything
          return
        }

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
      }

     @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            
        
        // reset back the content inset to zero after keyboard is gone
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
      }
    }
