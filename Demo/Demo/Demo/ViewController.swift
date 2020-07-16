//
//  ViewController.swift
//  Demo
//
//  Created by fluper on 16/07/20.
//  Copyright © 2020 fluper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var loginType:Int32?
    @IBOutlet weak var imageFullScreen: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
      logintypeScene()
    }
    
    func logintypeScene(){
        if loginType == 0{
                  imageFullScreen.image = #imageLiteral(resourceName: "apple-bracelet-car-computer-576739")
                  stackView.isHidden = true
              }
              if loginType == 1{
                  imageFullScreen.isHidden = true
                  stackView.axis = .horizontal
                  image1.image = #imageLiteral(resourceName: "desk-macbook-pro-apple-notebook-16347")
                  image2.image = #imageLiteral(resourceName: "photo-of-person-holding-brown-teddy-bear-1261572")
                  stackView.isHidden = false
              }
              if loginType == 2{
                  imageFullScreen.isHidden = true
                  stackView.axis = .vertical
                  image1.image = #imageLiteral(resourceName: "desk-macbook-pro-apple-notebook-16347")
                  image2.image = #imageLiteral(resourceName: "photo-of-person-holding-brown-teddy-bear-1261572")
                  stackView.isHidden = false
              }
    }
    @IBAction func buttonLogout(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}



