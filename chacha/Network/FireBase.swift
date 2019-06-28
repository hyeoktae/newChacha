//
//  FireBase.swift
//  Chacha
//
//  Created by hyeoktae kwon on 2019/06/25.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation


final class Firebase {
  static let shared = Firebase()
  
  private var db: Firestore!
  private let settings = FirestoreSettings()
  
  // Firebase 초기화
  func firebaseInitialize() {
    FirebaseApp.configure()
    Firestore.firestore().settings = settings
    db = Firestore.firestore()
  }
  
  // 출결 정보 가져오기
  func getAttension(date: String, uuid: String, completion: @escaping ([String: [String: String]]) -> () ) {
    var stateArr = [String: [String: String]]()
    let docRef = db.collection("attend")
                   .document("2019-06")
                   .collection("3D3F657B-00A1-43B3-8524-DDAAA0D28B54")
    
    docRef.getDocuments { (querySnapshot, error) in
      if let error = error {
        print("Error getting documents: \(error.localizedDescription)")
      } else {
        for document in querySnapshot!.documents {
          let data = document.data()
          let dateArr = document.documentID.components(separatedBy: "-")
          
          if stateArr.keys.contains("2019-06") {
            if (stateArr["2019-06"]?.keys.contains(dateArr[2]))! {
              stateArr["2019-06"]![dateArr[2]]?.append(data["state"] as! String)
            } else {
              stateArr["2019-06"]![dateArr[2]] = (data["state"] as! String)
            }
          } else {
            stateArr["2019-06"] = [dateArr[2]: data["state"] as! String]
          }
          
//          print("[Log3] dateArr:", dateArr[2])
//          print("[Log3] dataState:", data["state"] as! String)
//          shared.monthStateArr["2019-06"]?.append(data["state"] as! String)
//          shared.monthStateArr["2019-06"]?.append(data["state"] as! String)
        }
        completion(stateArr)
      }
    }
  }
  
  // admin 정보 가져오기
  func getAdminData(uuid: String, completion: @escaping (String) -> ()) {
    let docRef = db.collection("admin").document(uuid)
    var result = ""
    
    docRef.getDocument { (document, error) in
      print("document: ", document?.data())
      guard error == nil else { print("error", error?.localizedDescription); return }
      
      if let document = document, document.exists {
        
        let dataDic = document.data() as! [String: String]
        print("실행", dataDic)
        
        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
        
        if uuid == dataDic["uuid"] {
          print("관리자입니다!@#!@#.")
          result = "관리자"
        } else {
          print("학생.")
          result = "학생"
        }
        completion(result)
        print("Document data: \(dataDescription)")
      } else {
        print("Document does not exist")
        result = "학생"
        completion(result)
      }
    }
    print("[Log] : ", result)
  }
  
  // 오늘 지각인지 아닌지 검사
  func registerCheck(uuid: String, name: String, school: String, state: StateOfCheck, today: String, completion: @escaping () -> ()) {
    var stateString = String()
    switch state {
    case .check:
      stateString = "출석"
    case .late:
      stateString = "지각"
    case .none:
      stateString = "결석"
    }
    
    let documentText = String(today.dropLast(3))
    db.collection("attend").document(documentText).collection(uuid).document(today).setData(([
      "uuid": uuid,
      "name": name,
      "School": school,
      "state": stateString
      ])) {
        guard $0 != nil else { return }
        completion()
    }
  }
  
  // Student 추가
  func addStudent(name: String, uuid: String, address: String?, school: String) {
    db.collection("student").document(uuid).setData([
      "name": name,
      "uuid": uuid,
      "address": address ?? "",
      "school": school
    ]) { err in
      if let err = err {
        print("Error writing document: \(err)")
      } else {
        print("Document successfully written!")
      }
    }
  }
  
  // 비콘 추가 3단 비동기 토나와 ㅅㅂ 더좋은 방법이 있을꺼야 찾아보던가
  func addBeacons(_ beacons: [beaconInfo]?, completion: @escaping (Result<Bool, Fail>) -> ()) {
    guard let beacons = beacons else {completion(.failure(.noData)); return }
    let name = beacons.map { $0.name }
    let location = beacons.map { $0.location }
    let uuid = beacons.map { $0.uuid }
    
    self.db.collection("beacon").document("uuid").setData(["uuid" : uuid], completion: { (error) in
      guard error == nil else { completion(.failure(.uploadFail)); return }
      
      self.db.collection("beacon").document("name").setData(["name" : name], completion: { (error) in
        guard error == nil else { completion(.failure(.uploadFail)); return }
        
        self.db.collection("beacon").document("location").setData(["location" : location], completion: { (error) in
          guard error == nil else { completion(.failure(.uploadFail)); return }
          completion(.success(true))
        })
      })
    })
  }
  
  // 파베에 있는 데이터 긁어오기 파싱하는것 처럼 하면되는데
  // 더 좋은 방법이 있을껀데... 난 모르거쑴
  func getBeacons(completion: @escaping (Result<Bool, Fail>) -> ()) {
    var uuid = [String]()
    var name = [String]()
    var location = [String]()
    var downloadBeacons = [beaconInfo]()
    
    self.db.collection("beacon").getDocuments { (snap, err) in
      guard err == nil else { return completion(.failure(.networkError)) }
      guard let documents = snap?.documents else { return completion(.failure(.downloadFail)) }
      
      
      for document in documents {
        if let inUUID = document.data()["uuid"] as? [String] {
          uuid = inUUID
        }
        if let inName = document.data()["name"] as? [String] {
          name = inName
        }
        if let inLocation = document.data()["location"] as? [String] {
          location = inLocation
        }
      }
      
      guard uuid.count != 0 else { return completion(.failure(.noData)) }
      
      print("uuid: ", uuid)
      print("location: ", location)
      print("name: ", name)
      
      for idx in 0 ..< uuid.count {
        downloadBeacons.append(beaconInfo(uuid: uuid[idx], name: name[idx], location: location[idx]))
      }
      
      IBeacon.shared.downloadBeacons = downloadBeacons
      
      completion(.success(true))
    }
  }
}
