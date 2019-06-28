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
  
  let calenderView: CalendarView = {
    let v = CalendarView(theme: MyTheme.light)
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
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
    view.addSubview(calenderView)
    calenderView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10).isActive = true
    calenderView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 12).isActive = true
    calenderView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -12).isActive = true
    calenderView.heightAnchor.constraint(equalToConstant: 500).isActive = true
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
  }
}

