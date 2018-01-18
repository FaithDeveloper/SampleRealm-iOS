//
//  InputViewController.swift
//  SampleRealm
//
//  Created by MAC on 2018. 1. 17..
//  Copyright © 2018년 MAC. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController{
    // segue에서 데이터가 포함되고 넘어왔을 시 데이터를 저장하게 됩니다.
    // 만약 segue에 데이터가 포함되어 있지 않는다면 nil로 오게됩니다.
    var personData : PersonData?
    
     let realm = try? Realm()
    
    @IBAction func txtEmailFieldPrimaryActionTriggered(_ sender: Any) {
        txtUserEmail.resignFirstResponder()
        saveData()
    }
    @IBAction func txtNameFieldPrimaryActionTriggered(_ sender: Any) {
        txtUserName.resignFirstResponder()
        txtUserAge.becomeFirstResponder()
    }
    @IBAction func actionInputData(_ sender: Any){
       saveData()
    }
    
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtUserAge: UITextField!
    @IBOutlet var txtUserEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 데이터 저장
    func saveData(){
        if personData == nil{
           addPersionData()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Person Data 을 Realm에 추가합니다.
    func addPersionData(){
        personData = PersonData()
        inputDataToPersionData(db: personData!)
        //input Realm
        try? realm?.write {
            realm?.add((personData)!)
        }
    }
    
    //MARK: Person Data Update
    // Realm의 데이터 수정, 삭제가 있을 경우 1) Realm.Write()  2) Realm.add 형태로 진행합니다.
    func updatePersionData(){
        let db = realm?.objects(PersonData.self).filter("userName = %@", personData?.userName)

        if let data =  db?.first {
            try? realm?.write {
                inputDataToPersionData(db: data)
                realm?.add((personData)!, update: true)
            }
        }
    }
    
    //MARK: Person Data에 Data을 저장하고, Realm에 저장합니다.
    func inputDataToPersionData(db : PersonData){
        //Name
        if let name = txtUserName.text {
            personData?.userName = name
        }
        
        //Age
        if let age = txtUserAge.text{
            if age == ""{
                personData?.userAge = 0
            }else{
                personData?.userAge = Int(age)!
            }
        }
        
        //Email
        if let email = txtUserEmail.text{
            personData?.userEmail = email
        }
        
    }
    
    //MARK: LoadData
    func loadData(){
        if let db = personData {
            txtUserName.text = db.userName
            txtUserAge.text = String(describing: db.userAge)
            txtUserEmail.text = db.userEmail
        }
    }
    
   
    
}
