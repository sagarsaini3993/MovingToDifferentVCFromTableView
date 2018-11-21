//
//  LoginViewController.swift
//  FirebaseExamples
//
//  Created by MacStudent on 2018-11-21.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var txtFieldUsername: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    @IBOutlet weak var txtFieldUsernameSU: UITextField!
    @IBOutlet weak var txtFieldPassSU: UITextField!
    
    
    var USERNAME = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   

    @IBAction func btnLoginPressed(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: txtFieldUsername.text!, password: txtFieldPassword.text!) {
            
            (user, error) in
            
            if (user != nil) {
                // 1. Found a user!
                print("User signed in! ")
                print("User id: \(user?.user.uid)")
                print("Email: \(user?.user.email)")
                self.USERNAME = (user?.user.email)!
                
                // 2. So send them to screen 2!
                self.performSegue(withIdentifier: "segueA", sender: nil)
            }
            else {
                // 1. A problem occured when looking up  the user
                // - doesn't meet password requirements
                // - user already exists
                print("ERROR!")
                print(error?.localizedDescription)
                
                // 2. Show the error in user interface
//                self.statusMessageLabel.text = error?.localizedDescription
            }
        }
        
    }
    
    @IBAction func btnSignupPressed(_ sender: UIButton) {
        
       
        Auth.auth().createUser(withEmail: txtFieldUsernameSU.text!, password: txtFieldPassSU.text!) {
            
            (user, error) in
            
            if (user != nil) {
                // 1. New user created!
                print("Created user: ")
                print("User id: \(user?.user.uid)")
                print("Email: \(user?.user.email)")
                
                
                //2. @TODO: You decide what you want to do next!
                // - do you want to send them to the next page?
                // - maybe ask them to fill in other forms?
                // - show a tutorial?
                
            }
            else {
                // 1. Error when creating a user
                print("ERROR!")
                print(error?.localizedDescription)
                
                // 2. Show the error in the UI
//                self.statusMessageLabel.text = error?.localizedDescription
                
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ChatViewController
        vc.userNAME = USERNAME
    }
    
    
}
