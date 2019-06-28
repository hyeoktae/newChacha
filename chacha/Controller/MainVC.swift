//
//  MainVC.swift
//  Chacha
//
//  Created by hyeoktae kwon on 2019/06/25.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

final class MainVC: UIViewController {
  let shared = Firebase.shared
  // private 안됨 appdelegate에서 사용
  var myUUID = UserDefaults.standard.string(forKey: "uuid")
  
  private let mainView = MainView()
  
  private let registerVC = RegisterVC()
//  private let checkVC = CheckVC()
  private let detailCheckVC = DetailCheckVC()
  private let adminVC = AdminVC()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "mainVC"
    view.backgroundColor = .white
    mainView.delegate = self
    setupMainView()
    
    print("mainVC_uuid: ", myUUID)
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //학생인지 관리자인지 체크
    firstRunApp()
  }
  
  // uuid 관리자이면 관리자 페이지 띄움
  private func firstRunApp() {
    guard let myUUID = myUUID else { return }
    shared.getAdminData(uuid: myUUID) {
      print("firstRunApp 에서: ", $0)
      guard $0 == "관리자" else { return }
      self.present(self.adminVC, animated: true)
    }
  }
  
  private func setupMainView() {
    view.addSubview(mainView)
    let guide = view.safeAreaLayoutGuide
    mainView.translatesAutoresizingMaskIntoConstraints = false
    mainView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    mainView.widthAnchor.constraint(equalTo: guide.widthAnchor).isActive = true
    mainView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.8).isActive = true
  }
  
  private func alertController() {
    let alert = UIAlertController(title: "설정", message: "설정하기", preferredStyle: .actionSheet)
    let addressChange = UIAlertAction(title: "집주소 변경", style: .default) { _ in
      print("addressChange")
    }
    let pushAlarm = UIAlertAction(title: "푸시 알림 설정 [예]", style: .default) { _ in
      print("pushAlarm")
    }
    let cancel = UIAlertAction(title: "취소", style: .cancel)
    
    alert.addAction(addressChange)
    alert.addAction(pushAlarm)
    alert.addAction(cancel)
    present(alert, animated: true)
  }
}


extension MainVC: MainViewDelegate {
  //attendButton 누를 시 CheckVC로 이동
  func attendCheck() {
    print("didTapAttendButtonDelegate")
    let checkVC = CheckVC()
    let tabBarController = UITabBarController()
    let checkNavi = UINavigationController(rootViewController: checkVC)
    let detailCheckNavi = UINavigationController(rootViewController: detailCheckVC)
    
    checkVC.tabBarItem = UITabBarItem(title: "오늘", image: UIImage(named: "today"), selectedImage: UIImage(named: "clock"))
    detailCheckVC.tabBarItem = UITabBarItem(title: "전체", image: UIImage(named: "calendar"), selectedImage: UIImage(named: "calendar"))
    tabBarController.viewControllers = [checkNavi, detailCheckNavi]
    
    navigationController?.pushViewController(tabBarController, animated: true)
  }
  
  //settingButton 누를 시 action Sheet
  func setting() {
    print("didTapSettingButtonDelegate")
    alertController()
    
  }
  
}
