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
        }else{
            updatePersionData()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Person Data 을 Realm에 추가합니다.
    func addPersionData(){
        personData = PersonData()
        personData = inputDataToPersionData(db: personData!)
        //input Realm
        try? realm?.write {
            realm?.add((personData)!)
        }
    }
    
    //MARK: Person Data Update
    // Realm의 데이터 수정, 삭제가 있을 경우 1) Realm.Write()  2) Realm 에서 가져온 데이터의 값을 변경합니다.
    func updatePersionData(){
        try? realm?.write {
            personData = inputDataToPersionData(db: personData!)
        }
    }
    
    //MARK: Person Data에 Data을 저장하고, Realm에 저장합니다.
    func inputDataToPersionData(db : PersonData) -> PersonData{
        //Name
        if let name = txtUserName.text {
            db.userName = name
        }
        
        //Age
        if let age = txtUserAge.text{
            if age == ""{
                db.userAge = 0
            }else{
                db.userAge = Int(age)!
            }
        }
        
        //Email
        if let email = txtUserEmail.text{
            db.userEmail = email
        }
        return db
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
