//
//  CodeVerificationVC.swift
//  RegistrationApp
//
//  Created by Валентин Величко on 29.01.22.
//

import UIKit
import UserNotifications

class CodeVerificationVC: UIViewController, UNUserNotificationCenterDelegate {
    
    var name: String?
    var email: String?
    var password: String?
    
    var verificationCode: String?
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNotificationCenter.delegate = self
        self.makeNotificationWithPassword()
        self.requestNotificationAuthorization()
    }
    
    @IBOutlet weak var createAccountBtn: UIButton!
    
    @IBAction func passField(_ sender: UITextField) {
        if let enteredCode = sender.text,
           let generatedCode = verificationCode {
            if enteredCode == generatedCode {
                createAccountBtn.isEnabled = true
            }
        }
    }

    @IBAction func createAccountBtnClick(_ sender: UIButton) {
        performSegue(withIdentifier: "Go_To_Welcome", sender: nil)
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func requestNotificationAuthorization() {
            let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .sound)
            
            self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
                if let error = error {
                    print("Error: ", error)
                }
            }
        }
    
    func makeNotificationWithPassword() {
        let tempPass = String(Int.random(in: 9999...99999))
        verificationCode = tempPass
        let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "Your verification code"
            notificationContent.body = tempPass
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2,
                                                            repeats: false)
            let request = UNNotificationRequest(identifier: "notificationWithPassword",
                                                content: notificationContent,
                                                trigger: trigger)
            
            userNotificationCenter.add(request) { (error) in
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
    }
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if let welcomeVC = segue.destination as? WelcomeVC {
     welcomeVC.password = password
     welcomeVC.email = email
     welcomeVC.name = name
        }
    }
}
