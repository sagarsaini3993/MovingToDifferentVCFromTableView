//
//  CollegeViewController.swift
//  FirebaseExamples
//
//  Created by MacStudent on 2018-11-21.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CollegeViewController: UIViewController {

    @IBOutlet weak var txtFieldName: UITextField!
    
    @IBOutlet weak var txtFieldStudentID: UITextField!
    
    @IBOutlet weak var txtFieldProgram: UITextField!
    
    @IBOutlet weak var txtFieldSearch: UITextField!
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnSave(_ sender: UIButton) {
        
        let detail = db.collection("students")
        detail.document("AB").setData(["name":txtFieldName.text!,
                                     "studentId":txtFieldStudentID.text!,
                                     "program":txtFieldProgram.text!
            ])
        
    }
    
    @IBAction func btnGetData(_ sender: UIButton) {
        
        db.collection("students").getDocuments() {
            (querySnapshot, err) in
            
            // MARK: FB - Boilerplate code to get data from Firestore
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
    }
    
    
    @IBAction func btnSearch(_ sender: UIButton) {
        
        
        let songsRef = db.collection("students").whereField("name", isEqualTo: txtFieldSearch.text!)
        
        print("Querying database")
        
        songsRef.getDocuments() {
            (snapshot, error) in
            
            if (error != nil) {
                print("Error getting results from query")
                print(error?.localizedDescription)
            }
            else {
                print("Got something!")
                print("Num items in database matching query: \(snapshot!.count)")
                
                // 1. Get one result from database
                let results = snapshot!.documents
                let data = results[0].data()
                print(data["name"]!)
            }
        
        }
        
        
    }
    
    
}
