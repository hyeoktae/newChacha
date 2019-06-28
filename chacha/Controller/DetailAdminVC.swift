//
//  DetailAdminVC.swift
//  Chacha
//
//  Created by 차수연 on 26/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class DetailAdminVC: UIViewController {
  
  var adminState = false
  
  var cellArr = [StudentList]() {
    willSet{
      tableView.dataSource = nil
      tableView.delegate = nil
      tableView.reloadData()
      tableView.dataSource = self
      tableView.delegate = self
    }
  }
  
  private let reloadBtn: UIButton = {
    let btn = UIButton(type: .system)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle("새로고침", for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    btn.addTarget(self, action: #selector(didTapReloadBtn(_:)), for: .touchUpInside)
    btn.layer.borderWidth = 1
    return btn
  }()
  
  private let popBtn: UIButton = {
    let btn = UIButton(type: .system)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle("뒤로가기", for: .normal)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    btn.addTarget(self, action: #selector(didTapPopBtn(_:)), for: .touchUpInside)
    btn.layer.borderWidth = 1
    return btn
  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.rowHeight = 100
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
  }
  
  @objc private func didTapPopBtn(_ sender: UIButton) {
    dismiss(animated: true)
  }
  
  @objc private func didTapReloadBtn(_ sender: UIButton) {
    tableView.reloadData()
  }
  
  private func setupLayout() {
    view.addSubview(tableView)
    view.addSubview(popBtn)
    view.addSubview(reloadBtn)
    
    let guide = view.safeAreaLayoutGuide
    
    reloadBtn.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    reloadBtn.leadingAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    
    popBtn.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    popBtn.trailingAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    
    tableView.topAnchor.constraint(equalTo: reloadBtn.bottomAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
  }
}

extension DetailAdminVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellArr.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
    cell.textLabel?.text = cellArr[indexPath.row].name
    cell.detailTextLabel?.text = cellArr[indexPath.row].school
    return cell
  }
}

extension DetailAdminVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    guard adminState else { return nil }
    return indexPath
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    alertController(cellArr[indexPath.row].name, idx: indexPath.row)
  }
  
  private func alertController(_ name: String, idx: Int) {
    let alert = UIAlertController(title: "등록", message: "\(name)님을 관리자로 등록 하겠습니까?", preferredStyle: .alert)
    let addressChange = UIAlertAction(title: "예", style: .default) { _ in
      let oldData = self.cellArr[idx]
      let newData = StudentList(name: oldData.name, school: oldData.school, isAdmin: "1", uuid: oldData.uuid, add: oldData.add)
      Firebase.shared.setAdmin(data: newData)
    }
    let cancel = UIAlertAction(title: "취소", style: .cancel)
    
    alert.addAction(addressChange)
    alert.addAction(cancel)
    present(alert, animated: true)
  }
  
}
