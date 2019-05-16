//
//  CustomSpinner.swift
//  CustomAlert
//
//  Created by 石戸朋哲 on 2019/04/05.
//  Copyright © 2019 石戸朋哲. All rights reserved.
//

import Foundation
import UIKit

class CustomSpinner: UIViewController {
  var spinnerMessage: String?
  var additionalMessage: String?
  
  var overlayView = UIView()
  
  var containerView = UIView()
  var containerViewWidth: CGFloat = 140.0
  var containerViewHeight: CGFloat = 140.0
  
  var spinner = UIActivityIndicatorView()
  
  var messageLabel = UILabel()
  var additionalMessageLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.layoutView(self.presentingViewController)
  }
  
  // Initializer
  public convenience init(message: String?, additionalMessage: String?) {
    self.init(nibName: nil, bundle: nil)
    
    self.spinnerMessage = message
    self.additionalMessage = additionalMessage
    
    self.modalPresentationStyle = .overFullScreen
    self.modalTransitionStyle = .crossDissolve
  }
  
  override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  open func layoutView(_ presenting: UIViewController?) {
    // Set OverlayView
    overlayView.frame = self.view.frame
    overlayView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.5)
    
    // Set ContainerView
    containerView.frame = CGRect(x: (overlayView.frame.width - containerViewWidth) / 2, y: (overlayView.frame.height - containerViewHeight) / 2, width: containerViewWidth, height: containerViewHeight)
    containerView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.7)
    containerView.layer.cornerRadius = 5.0
    containerView.layer.masksToBounds = true
    
    // Set Spinner
    spinner.frame = CGRect(x: 46.0, y: 28.0, width: 48.0, height: 48.0)
    spinner.style = .whiteLarge
    spinner.color = UIColor.darkGray
    spinner.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
    
    // Set MessageLabel
    messageLabel.frame.size = CGSize(width: containerViewWidth, height: 0.0)
    messageLabel.text = self.spinnerMessage
    messageLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    messageLabel.textColor = .black
    messageLabel.sizeToFit()
    messageLabel.frame = CGRect(x: 0.0, y: 92.0, width: containerViewWidth, height: messageLabel.frame.height)
    
    // Set AdditionalMessageLabel
    if self.additionalMessage != nil {
      additionalMessageLabel.text = self.additionalMessage
      additionalMessageLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
      additionalMessageLabel.numberOfLines = 0
      additionalMessageLabel.textAlignment = .center
      additionalMessageLabel.textColor = .white
      additionalMessageLabel.sizeToFit()
      additionalMessageLabel.frame.size = CGSize(width: additionalMessageLabel.frame.width, height: additionalMessageLabel.frame.height)
    }
    
    self.view.addSubview(overlayView)
    
    overlayView.addSubview(containerView)
    
    if self.additionalMessage != nil {
      overlayView.addSubview(additionalMessageLabel)
    }
    
    containerView.addSubview(spinner)
    containerView.addSubview(messageLabel)

    additionalMessageLabel.translatesAutoresizingMaskIntoConstraints = false
    
    if self.additionalMessage != nil {
      let additionalMessageLabelXConstraint = NSLayoutConstraint(item: additionalMessageLabel, attribute: .centerX, relatedBy: .equal, toItem: overlayView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
      let additionalMessageLabelTopSpaceConstraint = NSLayoutConstraint(item: additionalMessageLabel, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 32.0)
    
      overlayView.addConstraints([additionalMessageLabelXConstraint])
      overlayView.addConstraints([additionalMessageLabelTopSpaceConstraint])
    }
    
    spinner.startAnimating()
  }
  
  open func changeMessage(message: String) {
    self.spinnerMessage = message
    
    messageLabel.text = self.spinnerMessage
  }
  
  open func dismissSpinner() {
    self.dismiss(animated: true, completion: nil)
  }
}
