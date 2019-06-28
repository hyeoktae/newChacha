//
//  CalendarView.swift
//  chacha
//
//  Created by Fury on 28/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

struct Colors {
  static var darkRed = #colorLiteral(red: 0.5019607843, green: 0.1529411765, blue: 0.1764705882, alpha: 1)
  static var lightGray = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
}

struct Style {
  static var bgColor = UIColor.black
  static var monthViewLblColor = UIColor.black
  static var monthViewBtnRightColor = UIColor.black
  static var monthViewBtnLeftColor = UIColor.black
  static var activeCellLblColor = UIColor.black
  static var activeCellLblColorHighlighted = UIColor.black
  static var weekdaysLblColor = UIColor.black
  
  static func themeLight(){
    bgColor = UIColor.white
    monthViewLblColor = UIColor.black
    monthViewBtnRightColor = UIColor.black
    monthViewBtnLeftColor = UIColor.black
    activeCellLblColor = UIColor.black
    activeCellLblColorHighlighted = UIColor.white
    weekdaysLblColor = UIColor.black
  }
}

class CalendarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MonthViewDelegate {
  
  private let shared = Fury.shared
  
  // MARK: Properties
  var todayCount = -1
  var currentCount = 0
  var numOfDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  var currentMonthIndex: Int = 0
  var currentYear: Int = 0
  var presentMonthIndex = 0
  var presentYear = 0
  var todaysDate = 0
  var firstWeekDayOfMonth = 0   //(Sunday-Saturday 1-7)
  
  
  
  let monthView: MonthView = {
    let v = MonthView()
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  let weekdaysView: WeekdaysView = {
    let v = WeekdaysView()
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  let myCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    let myCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    myCollectionView.showsHorizontalScrollIndicator = false
    myCollectionView.translatesAutoresizingMaskIntoConstraints = false
    myCollectionView.backgroundColor = UIColor.clear
    myCollectionView.allowsMultipleSelection = false
    return myCollectionView
  }()
  
  private let attendanceView: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0, green: 0.5894984603, blue: 0, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let latingView: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.9335912466, green: 0.8079068065, blue: 0, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let absentView: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let attendanceText: UITextField = {
    let textField = UITextField()
    textField.text = "출석"
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  private let latingText: UITextField = {
    let textField = UITextField()
    textField.text = "지각"
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  private let absentText: UITextField = {
    let textField = UITextField()
    textField.text = "결석"
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initializeCalendarView()
  }
  
  convenience init(theme: MyTheme) {
    self.init()
    
    Style.themeLight()
    initializeCalendarView()
  }
  
  private func changeTheme() {
    myCollectionView.reloadData()
    
    monthView.lblName.textColor = Style.monthViewLblColor
    monthView.btnRight.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
    monthView.btnLeft.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)
    
    for i in 0..<7 {
      (weekdaysView.myStackView.subviews[i] as! UILabel).textColor = Style.weekdaysLblColor
    }
  }
  
  private func initializeCalendarView() {
    currentMonthIndex = Calendar.current.component(.month, from: Date())
    currentYear = Calendar.current.component(.year, from: Date())
    todaysDate = Calendar.current.component(.day, from: Date())
    firstWeekDayOfMonth = getFirstWeekDay()
    
    //for leap years, make february month of 29 days
    if currentMonthIndex == 2 && currentYear % 4 == 0 {
      numOfDaysInMonth[currentMonthIndex - 1] = 29
    }
    //end
    
    presentMonthIndex = currentMonthIndex
    presentYear = currentYear
    
    setupViews()
    
    myCollectionView.delegate = self
    myCollectionView.dataSource = self
    myCollectionView.register(dateCVCell.self, forCellWithReuseIdentifier: "Cell")
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return numOfDaysInMonth[currentMonthIndex - 1] + firstWeekDayOfMonth - 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! dateCVCell
    cell.backgroundColor = UIColor.clear
    if indexPath.item <= firstWeekDayOfMonth - 2 {
      todayCount += 1
      cell.isHidden = true
    } else {
      print("[Log] :", currentCount)
      if indexPath.row == todayCount + todaysDate {
        let calcDate = indexPath.row - firstWeekDayOfMonth + 2
        cell.isHidden = false
        cell.lbl.text = "\(calcDate)"
        cell.lbl.textColor = Style.activeCellLblColor
        cell.backgroundColor = Colors.lightGray
      } else {
        let calcDate = indexPath.row - firstWeekDayOfMonth + 2
        cell.isHidden = false
        cell.lbl.text = "\(calcDate)"
        cell.lbl.textColor = Style.activeCellLblColor
      }
      
      // 현재 요일 미만만 확인
      let monthIndex = String(format: "%02d", currentMonthIndex)
      let dayIndex = String(format: "%02d", Int(cell.lbl.text!)!)
      if shared.monthStateArr.keys.contains("\(currentYear)-\(monthIndex)") {
        if (shared.monthStateArr["\(currentYear)-\(monthIndex)"]?.keys.contains(dayIndex))! {
          let state = shared.monthStateArr["\(currentYear)-\(monthIndex)"]?[dayIndex]
          if state == "출석" {
            cell.lbl.backgroundColor = #colorLiteral(red: 0, green: 0.5894984603, blue: 0, alpha: 1)
          } else if state == "지각" {
            cell.lbl.backgroundColor = #colorLiteral(red: 0.9335912466, green: 0.8079068065, blue: 0, alpha: 1)
          } else {
            cell.lbl.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
          }
        } else {
          cell.lbl.backgroundColor = .clear
        }
      } else {
        cell.lbl.backgroundColor = .clear
      }
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    cell?.backgroundColor = Colors.darkRed
    let lbl = cell?.subviews[1] as! UILabel
    lbl.textColor = UIColor.white
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath)
    
    if indexPath.row == todayCount + todaysDate {
      // 현재 요일의 경우 lightGray로 배경 고정
      cell?.backgroundColor = Colors.lightGray
      let lbl = cell?.subviews[1] as! UILabel
      lbl.textColor = Style.activeCellLblColor
    } else {
      // 그 밖의 요일
      cell?.backgroundColor = UIColor.clear
      let lbl = cell?.subviews[1] as! UILabel
      lbl.textColor = Style.activeCellLblColor
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width / 7 - 8
    let height: CGFloat = 40
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 8.0
  }
  
  func getFirstWeekDay() -> Int {
    let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
    return day
  }
  
  func collectionReloadData() {
    let shared = Firebase.shared
    let shared2 = Fury.shared
    let monthIndex = String(format: "%02d", currentMonthIndex)
    let date = "\(currentYear)-\(monthIndex)"
    let userDefaults = UserDefaults.standard
    let uuid = userDefaults.value(forKey: "uuid") as! String
    shared.getAttension(date: date, uuid: uuid) { (result) in
      shared2.monthStateArr = ["": ["": ""]]
      shared2.monthStateArr = result
      print("[Log10]: ", result)
      DispatchQueue.main.async {
        self.myCollectionView.reloadData()
      }
    }
  }
  
  func didChangeMonth(monthIndex: Int, year: Int) {
    currentMonthIndex = monthIndex + 1
    currentYear = year
    
    //for leap year, make february month of 29 days
    if monthIndex == 1 {
      if currentYear % 4 == 0 {
        numOfDaysInMonth[monthIndex] = 29
      } else {
        numOfDaysInMonth[monthIndex] = 28
      }
    }
    //end
    firstWeekDayOfMonth = getFirstWeekDay()
    myCollectionView.reloadData()
  }
  
  func setupViews() {
    addSubview(monthView)
    monthView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    monthView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    monthView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    monthView.heightAnchor.constraint(equalToConstant: 35).isActive = true
    monthView.delegate = self
    
    addSubview(weekdaysView)
    weekdaysView.topAnchor.constraint(equalTo: monthView.bottomAnchor).isActive = true
    weekdaysView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    weekdaysView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    weekdaysView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
    addSubview(myCollectionView)
    myCollectionView.topAnchor.constraint(equalTo: weekdaysView.bottomAnchor, constant: 0).isActive = true
    myCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
    myCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    myCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    
    addSubview(attendanceView)
    attendanceView.topAnchor.constraint(equalTo: myCollectionView.bottomAnchor).isActive = true
    attendanceView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    attendanceView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    attendanceView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    
    addSubview(attendanceText)
    attendanceText.topAnchor.constraint(equalTo: myCollectionView.bottomAnchor).isActive = true
    attendanceText.leadingAnchor.constraint(equalTo: attendanceView.trailingAnchor, constant: 5).isActive = true
    attendanceText.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    addSubview(latingView)
    latingView.topAnchor.constraint(equalTo: myCollectionView.bottomAnchor).isActive = true
    latingView.leadingAnchor.constraint(equalTo: attendanceText.trailingAnchor, constant: 10).isActive = true
    latingView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    latingView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    
    addSubview(latingText)
    latingText.topAnchor.constraint(equalTo: myCollectionView.bottomAnchor).isActive = true
    latingText.leadingAnchor.constraint(equalTo: latingView.trailingAnchor, constant: 5).isActive = true
    latingText.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    
    addSubview(absentView)
    absentView.topAnchor.constraint(equalTo: myCollectionView.bottomAnchor).isActive = true
    absentView.leadingAnchor.constraint(equalTo: latingText.trailingAnchor, constant: 10).isActive = true
    absentView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    absentView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    
    addSubview(absentText)
    absentText.topAnchor.constraint(equalTo: myCollectionView.bottomAnchor).isActive = true
    absentText.leadingAnchor.constraint(equalTo: absentView.trailingAnchor, constant: 5).isActive = true
    absentText.heightAnchor.constraint(equalToConstant: 20).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class dateCVCell: UICollectionViewCell {
  
  let lbl: UILabel = {
    let label = UILabel()
    label.text = "00"
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = Colors.darkRed
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
    layer.cornerRadius = 5
    layer.masksToBounds = true
    
    setupViews()
  }
  
  func setupViews() {
    addSubview(lbl)
    lbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
    lbl.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    lbl.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    lbl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

