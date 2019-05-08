//
//  CustomAlert.swift
//  CustomAlert
//
//  Created by 石戸朋哲 on 2019/04/02.
//  Copyright © 2019 石戸朋哲. All rights reserved.
//

import Foundation
import UIKit

class CustomAlertViewController: UIViewController {
  var alertMessage: String?
  var alertMessageLines: Int?
  var actionButtonTitle: String?
  var cancelButtonTitle: String?
  var actionButtonHandler: (() -> Void)?
  var cancelButtonHandler: (() -> Void)?
  
  // MARK: UI
  var alertViewWidth: CGFloat = 0.0
  var alertViewMaxWidth: CGFloat = 500.0
  var alertViewPadding: CGFloat = 15.0
  var innerContentWidth: CGFloat = 0.0
  var innerContentMaxWidth: CGFloat = 450.0
  var alertViewHeightConstraint: NSLayoutConstraint?  

  var overlayView = UIView()
  var alertView = UIView()

//  var closeButtonContainerView = UIView()
//  var closeButtonContainerViewHeight: CGFloat = 48.0
//  var closeButton = UIButton()
//  var closeButtonAreaHeight: CGFloat = 0.0

  var messageContainerView = UIView()
  var messageLabel = UILabel()
  var messageAreaHeight: CGFloat = 0.0
  let messageContainerMarginTop: CGFloat = 16.0
  var messageContainerTopSpace: CGFloat = 0.0

  var actionButtonContainerView = UIView()
  var actionButtonContainerViewHeightConstraint: NSLayoutConstraint?
  let buttonHeight: CGFloat = 44.0
  var buttonMargin: CGFloat = 16.0
  var actionButtonAreaHeight: CGFloat = 0.0
  var actionButton = UIButton()
  var cancelButton = UIButton()
  var actionButtons = [UIButton]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setIdentifiers()
    self.layoutView(self.presentingViewController)
  }
  
  // Initializer
  public convenience init(message: String?, messageLines: Int?, actionButtonTitle: String, cancelButtonTitle: String?, actionButtonHandler: @escaping () -> Void, cancelButtonHandler: @escaping () -> Void) {
    self.init(nibName: nil, bundle: nil)

    self.alertMessage = message
    self.alertMessageLines = messageLines
    self.actionButtonTitle = actionButtonTitle
    self.cancelButtonTitle = cancelButtonTitle
    self.actionButtonHandler = actionButtonHandler
    self.cancelButtonHandler = cancelButtonHandler

    self.modalPresentationStyle = .overFullScreen
    self.modalTransitionStyle = .crossDissolve
  }

  override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  
  open override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
  open func setIdentifiers() {
    self.overlayView.accessibilityIdentifier = "overlayView"
    self.alertView.accessibilityIdentifier = "alertView"
//    self.closeButtonContainerView.accessibilityIdentifier = "closeButtonContainerView"
    self.messageContainerView.accessibilityIdentifier = "messageContainerView"
    self.actionButtonContainerView.accessibilityIdentifier = "actionButtonContainerView"
  }
  
  open func layoutView(_ presenting: UIViewController?) {
    // Set OverlayView
    overlayView.frame = self.view.frame
    overlayView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.5)

    // Set AlertView
    self.alertViewWidth = overlayView.frame.width * 0.8 > alertViewMaxWidth ? alertViewMaxWidth : overlayView.frame.width * 0.8
    alertView.backgroundColor = UIColor(red:239/255, green:240/255, blue:242/255, alpha:1.0)
    
    // Set InnerContent Width
    self.innerContentWidth = alertViewWidth * 0.9 > innerContentMaxWidth ? innerContentMaxWidth : alertViewWidth * 0.9
   
    // Set CloseButton
//    let closeIconImage = UIImage(named: "close-icon")
//    closeButton.setImage(closeIconImage, for: .normal)
//    closeButton.addTarget(self, action: #selector(self.actionButtonTapped(_:)), for: .touchUpInside)
    
    self.messageContainerTopSpace = messageContainerMarginTop + alertViewPadding
    
    // Set MessageLabel
    messageLabel.frame.size = CGSize(width: innerContentWidth, height: 0.0)
    messageLabel.text = self.alertMessage
    messageLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
    messageLabel.numberOfLines = self.alertMessageLines ?? 0
    messageLabel.textAlignment = .center
    messageLabel.textColor = .black
    messageLabel.sizeToFit()
    messageLabel.frame = CGRect(x: 0, y: 0, width: innerContentWidth, height: messageLabel.frame.height)

    // MARK: Add subviews
    self.view.addSubview(overlayView)
    
    overlayView.addSubview(alertView)

//    alertView.addSubview(closeButtonContainerView)
    alertView.addSubview(messageContainerView)
    alertView.addSubview(actionButtonContainerView)

//    closeButtonContainerView.addSubview(closeButton)

    messageContainerView.addSubview(messageLabel)

    self.addButtons(actionButton, cancelButton, actionButtonTitle!, cancelButtonTitle)

    // MARK: Constraints settings
    overlayView.translatesAutoresizingMaskIntoConstraints = false
    alertView.translatesAutoresizingMaskIntoConstraints = false
//    closeButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
//    closeButton.translatesAutoresizingMaskIntoConstraints = false
    messageContainerView.translatesAutoresizingMaskIntoConstraints = false
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    actionButtonContainerView.translatesAutoresizingMaskIntoConstraints = false

    // self.view
    let overlayViewTopSpaceConstraint = NSLayoutConstraint(item: overlayView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
    let overlayViewRightSpaceConstraint = NSLayoutConstraint(item: overlayView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0)
    let overlayViewLeftSpaceConstraint = NSLayoutConstraint(item: overlayView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0)
    let overlayViewBottomSpaceConstraint = NSLayoutConstraint(item: overlayView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
    self.view.addConstraints([overlayViewTopSpaceConstraint, overlayViewRightSpaceConstraint, overlayViewLeftSpaceConstraint, overlayViewBottomSpaceConstraint])
    
    // overlayView
    let alertViewCenterXConstraint = NSLayoutConstraint(item: alertView, attribute: .centerX, relatedBy: .equal, toItem: overlayView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
    let alertViewCenterYConstraint = NSLayoutConstraint(item: alertView, attribute: .centerY, relatedBy: .equal, toItem: overlayView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
    overlayView.addConstraints([alertViewCenterXConstraint, alertViewCenterYConstraint])
    
    // AlertView
    let alertViewWidthConstraint = NSLayoutConstraint(item: alertView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: alertViewWidth)
    alertViewHeightConstraint = NSLayoutConstraint(item: alertView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 1000.0)
    alertView.addConstraints([alertViewWidthConstraint, alertViewHeightConstraint!])

    print("**********************************************0")
//    let closeButtonContainerViewTopSpaceConstraint = NSLayoutConstraint(item: closeButtonContainerView, attribute: .top, relatedBy: .equal, toItem: alertView, attribute: .top, multiplier: 1.0, constant: 0.0)
//    let closeButtonContainerViewRightSpaceConstraint = NSLayoutConstraint(item: closeButtonContainerView, attribute: .right, relatedBy: .equal, toItem: alertView, attribute: .right, multiplier: 1.0, constant: 0.0)
//    let closeButtonContainerViewLeftSpaceConstraint = NSLayoutConstraint(item: closeButtonContainerView, attribute: .left, relatedBy: .equal, toItem: alertView, attribute: .left, multiplier: 1.0, constant: 0.0)
    print("**********************************************1")
    let messageContainerViewRightSpaceConstraint = NSLayoutConstraint(item: messageContainerView, attribute: .right, relatedBy: .equal, toItem: alertView, attribute: .right, multiplier: 1.0, constant: 0.0)
    let messageContainerViewLeftSpaceConstraint = NSLayoutConstraint(item: messageContainerView, attribute: .left, relatedBy: .equal, toItem: alertView, attribute: .left, multiplier: 1.0, constant: 0.0)
    print("**********************************************2")
    let actionButtonContainerViewRightSpaceConstraint = NSLayoutConstraint(item: actionButtonContainerView, attribute: .right, relatedBy: .equal, toItem: alertView, attribute: .right, multiplier: 1.0, constant: 0.0)
    let actionButtonContainerViewLeftSpaceConstraint = NSLayoutConstraint(item: actionButtonContainerView, attribute: .left, relatedBy: .equal, toItem: alertView, attribute: .left, multiplier: 1.0, constant: 0.0)
    let actionButtonContainerViewTopSpaceConstraint = NSLayoutConstraint(item: actionButtonContainerView, attribute: .top, relatedBy: .equal, toItem: messageContainerView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
    let actionButtonContainerViewBottomSpaceConstraint = NSLayoutConstraint(item: actionButtonContainerView, attribute: .bottom, relatedBy: .equal, toItem: alertView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
    
    // MARK: 修正
    let messageContainerViewTopSpaceConstraint = NSLayoutConstraint(item: messageContainerView, attribute: .top, relatedBy: .equal, toItem: alertView, attribute: .top, multiplier: 1.0, constant: messageContainerTopSpace)

    alertView.addConstraints([messageContainerViewRightSpaceConstraint, messageContainerViewLeftSpaceConstraint, actionButtonContainerViewRightSpaceConstraint, actionButtonContainerViewLeftSpaceConstraint, actionButtonContainerViewTopSpaceConstraint, actionButtonContainerViewBottomSpaceConstraint, messageContainerViewTopSpaceConstraint])
    print("**********************************************3")
    
    // CloseButtonContainerView
//    let closeButtonContainerViewHeightConstraint = NSLayoutConstraint(item: closeButtonContainerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: closeButtonContainerViewHeight)
//    let closeButtonRightSpaceConstraint = NSLayoutConstraint(item: closeButton, attribute: .right, relatedBy: .equal, toItem: closeButtonContainerView, attribute: .right, multiplier: 1.0, constant: -10.0)
//    let closeButtonCenterYConstraint = NSLayoutConstraint(item: closeButton, attribute: .centerY, relatedBy: .equal, toItem: closeButtonContainerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)

    print("**********************************************3.1")
    
//    closeButtonContainerView.addConstraints([closeButtonContainerViewHeightConstraint, closeButtonRightSpaceConstraint, closeButtonCenterYConstraint])

    print("**********************************************3.2")
    // MessageContainerView
//    let messageContainerViewHeightConstraint = NSLayoutConstraint(item: messageContainerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: messageLabel.frame.height + 5.0)
    let messageLabelCenterXConstraint = NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: messageContainerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
    let messageLabelCenterYConstraint = NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: messageContainerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
    messageContainerView.addConstraints([messageLabelCenterXConstraint, messageLabelCenterYConstraint])
    
    let messageLabelWidthConstraint = NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: innerContentWidth)
    messageLabel.addConstraints([messageLabelWidthConstraint])
    
    print("**********************************************4")
    actionButtonContainerViewHeightConstraint = NSLayoutConstraint(item: actionButtonContainerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 0.0)
    actionButtonContainerView.addConstraints([actionButtonContainerViewHeightConstraint!])
    print("**********************************************5")

    // MARK: Button Area layouts
    var actionButtonAreaPositionY: CGFloat = buttonMargin
    
    let buttonWidth = innerContentWidth - buttonMargin * 2
    let buttonPositionX: CGFloat = (alertViewWidth - innerContentWidth) / 2 + buttonMargin

    for button in actionButtons {
      let isCancelButton = (button.tag == 2)

      button.setTitleColor(isCancelButton ? .black : .white , for: .normal)
      button.backgroundColor = isCancelButton ? .white: .red
      button.frame = CGRect(x: buttonPositionX, y: actionButtonAreaPositionY, width: buttonWidth, height: buttonHeight)
      button.layer.borderWidth = isCancelButton ? 1.0 : 0.0
      button.layer.borderColor = isCancelButton ? UIColor.black.cgColor : UIColor.clear.cgColor

      actionButtonAreaPositionY += buttonMargin + buttonHeight
    }

    actionButtonAreaPositionY += alertViewPadding
    actionButtonAreaHeight = actionButtonAreaPositionY
    print("**********************************************6")
    
//    closeButtonAreaHeight = closeButtonContainerViewHeight
    
    messageAreaHeight = messageContainerTopSpace + messageLabel.frame.height
    
    self.calcAlertViewHeight()

    alertView.frame.size = CGSize(width: alertViewWidth, height: alertViewHeightConstraint?.constant ?? 150)
  }
  
  func addButtons(_ actionButton: UIButton, _ cancelButton: UIButton, _ actionButtonTitle: String, _ cancelButtonTitle: String?) {
    actionButton.layer.masksToBounds = true
    actionButton.setTitle(actionButtonTitle, for: .normal)
    actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    actionButton.isEnabled = true
    actionButton.layer.cornerRadius = 0.0
    actionButton.addTarget(self, action: #selector(self.actionButtonTapped(_:)), for: .touchUpInside)
    actionButton.tag = 1
    
    actionButtons.append(actionButton)
    
    actionButtonContainerView.addSubview(actionButton)
    
    guard let cancelButtonTitle = cancelButtonTitle else { return }
    
    cancelButton.layer.masksToBounds = true
    cancelButton.setTitle(cancelButtonTitle, for: .normal)
    cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    cancelButton.isEnabled = true
    cancelButton.layer.cornerRadius = 0.0
    cancelButton.addTarget(self, action: #selector(self.actionButtonTapped(_:)), for: .touchUpInside)
    cancelButton.tag = 2
    
    actionButtons.append(cancelButton)

    actionButtonContainerView.addSubview(cancelButton)
  }
  
  @objc func actionButtonTapped(_ sender: UIButton) {
    sender.isSelected = true

    self.dismiss(animated: true) {
      switch sender.tag {
      case 1:
        guard let actionButtonHandler = self.actionButtonHandler else { return }
        
        actionButtonHandler()
      case 2:
        guard let cancelButtonHandler = self.cancelButtonHandler else { return }
        
        cancelButtonHandler()
      default:
        return
      }
    }
  }
  
  func calcAlertViewHeight() {
    let maxHeight = self.view.frame.height
    
    // for avoiding constraint error
    actionButtonContainerViewHeightConstraint?.constant = 0.0

//    var alertViewHeight =  closeButtonAreaHeight + messageAreaHeight + actionButtonAreaHeight
    var alertViewHeight = messageAreaHeight + actionButtonAreaHeight

    if (alertViewHeight > maxHeight) {
      alertViewHeight = maxHeight
    }

    alertViewHeightConstraint?.constant = alertViewHeight
    
    var actionButtonContainerViewHeight = actionButtonAreaHeight
    if (actionButtonContainerViewHeight > maxHeight) {
      actionButtonContainerViewHeight = maxHeight
    }

    actionButtonContainerViewHeightConstraint?.constant = actionButtonContainerViewHeight
  }
}
