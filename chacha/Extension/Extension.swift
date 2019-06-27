//
//  Extension.swift
//  chacha
//
//  Created by hyeoktae kwon on 2019/06/27.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import Foundation

//get first day of the month
extension Date {
  var weekday: Int {
    return Calendar.current.component(.weekday, from: self)
  }
  var firstDayOfTheMonth: Date {
    return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
  }
}

//get date from string
extension String {
  static var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
  var date: Date? {
    return String.dateFormatter.date(from: self)
  }
}
