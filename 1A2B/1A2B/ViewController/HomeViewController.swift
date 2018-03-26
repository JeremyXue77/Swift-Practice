//
//  HomeViewController.swift
//  1A2B
//
//  Created by JeremyXue on 2018/3/21.
//  Copyright © 2018年 JeremyXue. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {



    @IBOutlet weak var userName: UITextField!
    
    @IBAction func selectedNormalMode(_ sender: Any) {
        
    }
    
    @IBAction func selectedRepeatMode(_ sender: UIButton) {
        

    }
    
    
    @IBAction func saveUserName(_ sender: UIButton) {
    
        let alert = UIAlertController(title: "名稱", message: "名稱是否輸入正確", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: { (finish) in
            UserDefaults.standard.set(self.userName.text, forKey: "userName")
        }))
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = UserDefaults.standard.string(forKey: "userName")

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

}
