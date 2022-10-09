//
//  LoginViewController.swift
//  cyberApp
//
//  Created by Salomon Martinez on 22/09/22.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //checkUserInfo()
    }
    

    @IBAction func loginTapped(_ sender: UIButton) {
    }
    
    @IBAction func dontHaveAccount(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signup")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @IBAction func goToMain(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "main")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
}
