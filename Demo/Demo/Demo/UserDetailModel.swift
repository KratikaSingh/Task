//
//  UserDetailModel.swift
//  Demo
//
//  Created by fluper on 16/07/20.
//  Copyright © 2020 fluper. All rights reserved.
//

import Foundation
  

class UserDetails{
    // MARK:- Objects
    enum loginStatus { case first , secound , third }
    var username:String?
    var password:String?
    var loginType:Int32?
        
    init(username:String?, password:String?, loginType:Int32?)  {
           self.username = username
           self.password = password
           self.loginType = loginType
       }
     
}
