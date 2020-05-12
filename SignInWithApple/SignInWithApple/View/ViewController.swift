//
//  ViewController.swift
//  SignInWithApple
//
//  Created by Vishvesh on 02/04/20.
//  Copyright © 2020 human.solutions. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if UserDefaults.standard.value(forKey: "userToken") != nil {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as?
                LoginViewController else { return }
            navigationController?.pushViewController(vc, animated: false)
            
        }
        
        let button = ASAuthorizationAppleIDButton()
        button.frame.size.width = 200
        button.frame.size.height = 50
        self.view.addSubview(button)
        button.cornerRadius = 20
        button.center = self.view.center
        self.view.backgroundColor = .white
        button.addTarget(self, action: #selector(appleIdRequest), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Action appleIdRequest
    @objc func appleIdRequest() {
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        let request = appleIdProvider.createRequest()
        request.requestedScopes = [.fullName , .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self as? ASAuthorizationControllerDelegate
        authorizationController.performRequests()
    }
    
}

// MARK: - ASAuthorizationControllerDelegate Method
extension ViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
        
            print("Success")
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            
            let userToken = String(userIdentifier)
            let fullNameString = (fullName?.givenName)! + " " + (fullName?.familyName)!
            var emailString = ""
            if email == nil {
                emailString = "AppleID is hidden"
            }else {
                emailString = String(email!)
            }
            
            
            
            UserDefaults.standard.set(userToken, forKey: "userToken")
            UserDefaults.standard.set(fullNameString, forKey: "fullName")
            UserDefaults.standard.set(emailString, forKey: "email")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(vc, animated: true)
        
            } else {
            print("Not Success")
        }
        
    }
}
