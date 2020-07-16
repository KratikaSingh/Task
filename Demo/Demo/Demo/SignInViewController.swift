//
//  SignInViewController.swift
//  Demo
//
//  Created by fluper on 16/07/20.
//  Copyright © 2020 fluper. All rights reserved.
//

import UIKit
import iOSDropDown

class SignInViewController: UIViewController {
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var db:DBHelper = DBHelper()
    var logintype:Int32?
    override func viewDidLoad() {
        super.viewDidLoad()
     setShadow()
        
    }
   func setShadow(){
          self.navBarView.drawShadowwithCorner()
          self.usernameView.drawShadowwithCorner()
          self.passwordView.drawShadowwithCorner()
      }
    
    @IBAction func buttonSignIn(_ sender: UIButton) {
        
        let user = db.read()
        for index in user {
            if index.username != String(textFieldUsername.text ?? "") {
                print("Username doesn't Exist")
                return
            }
            
            if index.password != String(textFieldPassword.text ?? "") {
                print("Password do not match")
                return
            }
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController" ) as? ViewController
                else{return}
            vc.loginType = index.loginType
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func buttonSignUp(_ sender: UIButton) {
        self.navigationController?.popViewController(animated:true)
    }
    
}
