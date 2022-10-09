//
//  SignUpViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 22/09/22.
//

import UIKit

class SignUpViewController: UIViewController {


    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signupTapped(_ sender: UIButton) {

    }
    
    @IBAction func alreadyHaveAccountTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}
