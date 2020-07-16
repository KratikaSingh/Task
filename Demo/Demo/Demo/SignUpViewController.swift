//
//  SignUpViewController.swift
//  Demo
//
//  Created by fluper on 16/07/20.
//  Copyright © 2020 fluper. All rights reserved.
//

import UIKit
import iOSDropDown
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textfieldUsername: UITextField!
    @IBOutlet weak var textFieldType: DropDown!
    var db:DBHelper = DBHelper()
    var indexNo:Int32?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeSelection()
        setShadow()
    }
    
    func setShadow(){
        self.navBarView.drawShadowwithCorner()
        self.usernameView.drawShadowwithCorner()
        self.passwordView.drawShadowwithCorner()
    }
    
    func typeSelection(){
        textFieldType.optionArray = ["Type A", "Type B", "Type C"]
        textFieldType.didSelect{(selectedText , index ,id) in
            self.textFieldType.text = "\(selectedText)"
            self.indexNo = Int32(index)
        }
    }
    
    @IBAction func buttonSignUp(_ sender: UIButton) {
        
        db.insert(username: String(textfieldUsername.text ?? ""), password:String(textFieldPassword.text ?? ""), loginType: indexNo){ _ in
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
                else{return}
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func buttonsignIn(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
            else{return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
