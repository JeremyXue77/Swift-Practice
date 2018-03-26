//
//  ViewController.swift
//  1A2B
//
//  Created by JeremyXue on 2018/3/20.
//  Copyright © 2018年 JeremyXue. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {

    
    var playerName = UserDefaults.standard.string(forKey: "userName")
    
    var ref:DatabaseReference?
    
    var handle:DatabaseHandle?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordAArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordTableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cell.guessNumber.text = "\(recordQArray[indexPath.row])"
        cell.recordAB.text = recordAArray[indexPath.row]
        
        return cell
    }
    
    
    // 元件宣告
    
    @IBOutlet weak var recordTableView: UITableView!
    @IBOutlet weak var inputNumber: UILabel!
    @IBOutlet weak var ansLabel1: UILabel!
    @IBOutlet weak var ansLabel2: UILabel!
    @IBOutlet weak var ansLabel3: UILabel!
    @IBOutlet weak var ansLabel4: UILabel!
    
    var enterRoom:Int?
    var roomNumber:Int!
    var random = false
    
    var randomRoomNumber = Int(arc4random() % 1000)
    
    var randomNumber = Int(arc4random() % 10)
    
    var ansArray = [Int]()
    var ansArray2 = [Int]()
    var numberArray = [Int]()
    
    // 紀錄刪除格數 Array
    var removeArray = [Int]()
    
    // 複製 ansArray 代替刪除
    var checkArray = [Int]()
    
    // TableView 顯示資訊
    var recordQArray = [String]()
    var recordAArray = [String]()
    
    var randomArray = [Int]()
    
    var A = 0
    var B = 0
    
    @IBAction func okAction(_ sender: UIButton) {
        
        if numberArray.count == 4 {
            
            ref?.child("Room/Repeat/Number/\(roomNumber!)/Guess Number").childByAutoId().setValue(inputNumber.text)
            
            checkArray = ansArray
            
            for a in 0..<ansArray.count {
                for q in 0..<numberArray.count {
                    if numberArray[q] == ansArray[a] && q == a {
                        A += 1
                        removeArray.append(a)
                    }
                }
            }
            
            for i in 0..<removeArray.count {
                checkArray.remove(at: removeArray[i] - i)
                numberArray.remove(at: removeArray[i] - i)
            }
            
            removeArray = []
            
            for a in 0..<checkArray.count {
                for q in 0..<numberArray.count {
                    if numberArray[q] == checkArray[a]  {
                        B += 1
                        numberArray[q] = -2
                        break
                    }
                }
                checkArray[a] = -1
            }
            
            // Firebase
            ref?.child("Room/Repeat/Number/\(roomNumber!)/Result").childByAutoId().setValue("\(A)A,\(B)B")
            
            removeArray = []
            numberArray = []
            inputNumber.text = ""
            A = 0
            B = 0
            
        } else {
            let alert = UIAlertController(title: "輸入錯誤", message: "請輸入 4 個數字", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        if numberArray.count >= 1 {
            numberArray.remove(at: numberArray.count - 1 )
        } else {
            inputNumber.text = ""
        }
        inputNumber.text = "\(numberArray)"
    }
    
    
    @IBAction func numberSelected(_ sender: UIButton) {
        if numberArray.count < 4 {
            numberArray.append(sender.tag)
            inputNumber.text? = "\(numberArray)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        if self.enterRoom != nil {
            self.roomNumber = self.enterRoom!
        } else {
            self.roomNumber = self.randomRoomNumber
        }

    
        ref?.child("Room/Repeat/Number/\(roomNumber!)").setValue(roomNumber)
        
        handle = ref?.child("Room/Repeat/Number/\(roomNumber!)/Guess Number").observe(DataEventType.childAdded, with: { (snapshot) in
            if let number = snapshot.value as? String {
                self.recordQArray.append(number)
                self.recordTableView.reloadData()
            }
        })
        
        handle = ref?.child("Room/Repeat/Number/\(roomNumber!)/Result").observe(DataEventType.childAdded, with: { (snapshot) in
            if let message = snapshot.value as? String {
                self.recordAArray.append(message)
                self.recordTableView.reloadData()
            }
        })
        
        if playerName != "" {
            playerName = UserDefaults.standard.string(forKey: "userName")
        } else {
            playerName = "Player\((arc4random() % 100) + 1) "
        }
        
        
        ref?.child("Room/Repeat/Number/\(roomNumber!)/Player").childByAutoId().setValue(playerName!)
        
        inputNumber.text = ""
        recordTableView.dataSource = self
        recordTableView.delegate = self
        
        
        
        if random == false {
            randomNum()
            
        } else {
            for i in 0...3 {
                handle = ref?.child("Room/Repeat/Number/\(roomNumber!)/Answer/\(i)").observe(DataEventType.childChanged, with: { (snapShot) in
                    print(snapShot.value)
                    self.ansArray2.append(snapShot.value as! Int)
                    print(self.ansArray2)
                })
            }
            
            
        }
        
        ref?.child("Room/Repeat/Number/\(roomNumber!)/Answer").setValue(ansArray)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomNum() {
        if ansArray.count < 4 {
            ansArray.append(Int(arc4random() % 10))
            randomNum()
        }
        random = true
    }

}

