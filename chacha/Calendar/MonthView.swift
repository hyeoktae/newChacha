//
//  MonthView.swift
//  chacha
//
//  Created by Fury on 28/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

protocol MonthViewDelegate: class {
  func didChangeMonth(monthIndex: Int, year: Int)
  func collectionReloadData()
}

class MonthView: UIView {
  
  // MARK:- Properties
  var monthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  var currentMonthIndex = 0
  var currentYear: Int = 0
  var delegate: MonthViewDelegate?
  
  let lblName: UILabel = {
    let label = UILabel()
    label.text = "Default Month Year text"
    label.textColor = Style.monthViewLblColor
    label.textAlignment = .center
    label.font=UIFont.boldSystemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let btnRight: UIButton = {
    let btn = UIButton()
    btn.setTitle(">", for: .normal)
    btn.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
    return btn
  }()
  
  let btnLeft: UIButton = {
    let btn = UIButton()
    btn.setTitle("<", for: .normal)
    btn.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)
    btn.setTitleColor(UIColor.lightGray, for: .disabled)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.addTarget(self, action: #selector(btnLeftRightAction(sender:)), for: .touchUpInside)
    return btn
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
    
    currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
    currentYear = Calendar.current.component(.year, from: Date())
    
    setupViews()
  }
  
  @objc func btnLeftRightAction(sender: UIButton) {
    if sender == btnRight {
      currentMonthIndex += 1
      if currentMonthIndex > 11 {
        currentMonthIndex = 0
        currentYear += 1
      }
    } else {
      currentMonthIndex -= 1
      if currentMonthIndex < 0 {
        currentMonthIndex = 11
        currentYear -= 1
      }
    }
    
    var currentMonthString = ""
    if String(currentMonthIndex).count == 1 {
      currentMonthString = "0\(currentMonthIndex + 1)"
    } else {
      currentMonthString = "\(currentMonthIndex + 1)"
    }
    delegate?.collectionReloadData()
    lblName.text = "\(monthsArr[currentMonthIndex]) \(currentYear)"
    delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
    
  }
  
  func setupViews() {
    self.addSubview(lblName)
    lblName.topAnchor.constraint(equalTo: topAnchor).isActive = true
    lblName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    lblName.widthAnchor.constraint(equalToConstant: 150).isActive = true
    lblName.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    lblName.text = "\(monthsArr[currentMonthIndex]) \(currentYear)"
    
    self.addSubview(btnRight)
    btnRight.topAnchor.constraint(equalTo: topAnchor).isActive = true
    btnRight.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    btnRight.widthAnchor.constraint(equalToConstant: 50).isActive = true
    btnRight.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    
    self.addSubview(btnLeft)
    btnLeft.topAnchor.constraint(equalTo: topAnchor).isActive = true
    btnLeft.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    btnLeft.widthAnchor.constraint(equalToConstant: 50).isActive = true
    btnLeft.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
