//
//  DetailCheckVC.swift
//  Chacha
//
//  Created by 차수연 on 26/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

enum MyTheme {
  case light
}

class DetailCheckVC: UIViewController {
  
  let attendView: UIImageView = {
    let v = UIImageView()
    v.image = UIImage(named: "calendar1")
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  let calenderView: CalendarView = {
    let v = CalendarView(theme: MyTheme.light)
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let shared = Firebase.shared
    let shared2 = Fury.shared
    let currentYear = Calendar.current.component(.year, from: Date())
    let currentMonthIndex = Calendar.current.component(.month, from: Date())
    let monthIndex = String(format: "%02d", currentMonthIndex)
    let date = "\(currentYear)-\(monthIndex)"
    let userDefaults = UserDefaults.standard
    let uuid = userDefaults.value(forKey: "uuid") as! String
    shared.getAttension(date: date, uuid: uuid) { (result) in
      shared2.monthStateArr = result
      DispatchQueue.main.async {
        self.calenderView.myCollectionView.reloadData()
      }
    }
    
    let guide = view.safeAreaLayoutGuide
    
    view.addSubview(attendView)
    attendView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    attendView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    attendView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    attendView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.4).isActive = true
    
    view.addSubview(calenderView)
    calenderView.topAnchor.constraint(equalTo: attendView.bottomAnchor, constant: 10).isActive = true
    calenderView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 12).isActive = true
    calenderView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -12).isActive = true
    calenderView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
  }
}

