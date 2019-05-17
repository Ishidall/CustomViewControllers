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
  var spinner: CustomSpinner? = CustomSpinner(message: "アップロード中..", additionalMessage: "40~60秒ほどお待ちください")
  var carouselModal: CarouselModal?
  
  var modalImage1: UIImage?
  var modalImage2: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let img1url = URL(string: "https://via.placeholder.com/300x600")
    let img2url = URL(string: "https://via.placeholder.com/200x350")
    
    do {
      let data1 = try Data(contentsOf: img1url!)
      let data2 = try Data(contentsOf: img2url!)
      
      modalImage1 = UIImage(data: data1)
      modalImage2 = UIImage(data: data2)
    } catch {
      print(error)
    }
    
    
    let modalImages = [modalImage1!, modalImage2!]
    let modalDescriptions = ["これは\nサンプル画像です", "This is sample image\nvia placeholder.com"]

    do {
      self.carouselModal = try CarouselModal(title: "撮影のヒント", images: modalImages, descriptions: modalDescriptions)
    } catch {
      print(error)
    }

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
    carouselModal!.show(self)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//      self.spinner.changeMessage(message: "サイズ計測中..")
      self.spinner?.dismissSpinner()
    }
  }
}

