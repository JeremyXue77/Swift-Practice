//
//  ViewController.swift
//  1A2B
//
//  Created by JeremyXue on 2018/3/20.
//  Copyright © 2018年 JeremyXue. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {
    
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
    
    
    var randomNumber = Int(arc4random() % 10)
    
    var ansArray = [Int]()
    var numberArray = [Int]()
    
    // 紀錄刪除格數 Array
    var removeArray = [Int]()
    
    // 複製 ansArray 代替刪除
    var checkArray = [Int]()
    
    // TableView 顯示資訊
    var recordQArray = [[Int]]()
    var recordAArray = [String]()
    
    var A = 0
    var B = 0
    
    @IBAction func okAction(_ sender: UIButton) {
        
        checkArray = ansArray
        recordQArray.append(numberArray)
        
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
                }
            }
            checkArray[a] = -1
        }
        
        recordAArray.append("\(A)A,\(B)B")
        
        recordTableView.reloadData()
        print("\(A)A,\(B)B")
        
        removeArray = []
        numberArray = []
        A = 0
        B = 0
        
        clearAction(sender)
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        numberArray = []
        inputNumber.text = ""
    }
    
    
    @IBAction func numberSelected(_ sender: UIButton) {
        if numberArray.count < 4 {
            numberArray.append(sender.tag)
            inputNumber.text? += String(sender.tag)
        }
        
        print(numberArray)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordTableView.dataSource = self
        recordTableView.delegate = self
        inputNumber.text = ""
        reset()
        print(ansArray)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//        不重複數字題目
        func random() {
            randomNumber = Int(arc4random() % 10)
            for number in ansArray {
                if number != randomNumber {
                    ansArray.append(randomNumber)
                } else {
                    randomNumber = Int(arc4random() % 10)
                    return
                }
                let setArray = Set(ansArray)
                ansArray = Array(setArray)
            }
        }
    
        func reset() {
            ansArray.append(randomNumber)
            while ansArray.count < 4 {
                random()
            }
        }
    
    
    //    重複數字
//    func randomNum() {
//        if ansArray.count < 4 {
//            ansArray.append(Int(arc4random() % 10))
//            randomNum()
//        }
//    }
    
}


