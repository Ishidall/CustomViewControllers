//
//  ViewController.swift
//  CustomAlert
//
//  Created by 石戸朋哲 on 2019/04/02.
//  Copyright © 2019 石戸朋哲. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  

  let alertController = CustomAlertViewController(message: "野生のTetsuさんAが現れた！野生のTetsuさんBが現れた！", messageLines: 0, actionButtonTitle: "たたかう", cancelButtonTitle: "にげる", actionButtonHandler: {
    print("actionButtonTapped!")
  }, cancelButtonHandler: {
    print("cancelButtonTapped!")
  })
  var spinner: CustomSpinner = CustomSpinner(message: "アップロード中..", additionalMessage: "40~60秒ほどお待ちください")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = .green
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    self.show()
  }

  @IBAction func showAlert(_ sender: Any) {
    self.show()
  }
  
  func show() {
    //    self.present(alertController, animated: true)
    self.present(spinner, animated: true)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//      self.spinner.changeMessage(message: "サイズ計測中..")
      self.spinner.dismissSpinner()
      self.present(self.alertController, animated: true)
    }
  }
}

