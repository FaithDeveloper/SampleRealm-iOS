//
//  IndexTableViewController.swift
//  SampleRealm
//
//  Created by MAC on 2018. 1. 17..
//  Copyright © 2018년 MAC. All rights reserved.
//

import UIKit
import RealmSwift

class IndexTableViewController: UITableViewController {
    
    var personData : Results<PersonData>?
    //Realm에 저장된 데이터를 가져옵니다.
    let realm = try? Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Realm 저장 위치 보여줌
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

        //가져온 데이터를 리스트형태로 배치합니다. User Name 이름을 오른차순으로 정렬합니다.
        personData = realm?.objects(PersonData.self).sorted(byKeyPath: "userName", ascending: true)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: 삭제
    // Realm의 데이터 삭제는 1.realm.write(), realm.delete 순으로 진행된다.
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "삭제") { (action, index) in
            do{
                try self.realm?.write{
                    self.realm?.delete(self.personData![indexPath.row])
                    self.tableView.reloadData()
                }
            } catch{
                print("\(error)")
            }
        }
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction]
    }
    
    //MARK: 클릭 가능 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: 셀 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = personData?.count {
            return count
        }else {
            return 1
        }
    }
    
    //MARK: 셀 정보 입력
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let db = personData?[indexPath.row]
        
        cell.userName.text = db?.userName
        cell.userAge.text = String(describing: db?.userAge)
        cell.userEmail.text = db?.userEmail
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = personData?[indexPath.row]
        performSegue(withIdentifier: "updatePersonDataSegue", sender: data)
    }
    
    //MARK: User Data 입력 화면으로 이동
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updatePersonDataSegue"{
            if let userDataViewController = segue.destination as? InputViewController {
                if let personData = sender as? PersonData {
                    userDataViewController.personData = personData
                }
            }
        }
    }
}
