//
//  LoginViewController.swift
//  SignInWithApple
//
//  Created by Vishvesh on 02/04/20.
//  Copyright © 2020 human.solutions. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var appleID: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    
    // MARK: - Action onPressLogOut
    @IBAction func onPressLogOut(_ sender: Any) {
        
        let alert = UIAlertController(title: "Alert", message: "Click to Log Out", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "Log Out", style: UIAlertAction.Style.destructive, handler: { action in
            self.logOut()
        })
        alert.addAction(ok)
        self.present(alert,animated: true)

    }
    
    // MARK: - Function logOut
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "userToken")
        UserDefaults.standard.removeObject(forKey: "fullName")
        UserDefaults.standard.removeObject(forKey: "email")
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

            fullName.text = UserDefaults.standard.value(forKey: "fullName") as? String
            appleID.text = UserDefaults.standard.value(forKey: "email") as? String
    
        logOutButton.layer.cornerRadius = 10
        navigationController?.interactivePopGestureRecognizer?.isEnabled =  false
        navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        navigationController?.navigationBar.isHidden = true
    }
    
    
}
