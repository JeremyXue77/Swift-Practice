//
//  RoomTableViewController.swift
//  1A2B
//
//  Created by JeremyXue on 2018/3/23.
//  Copyright © 2018年 JeremyXue. All rights reserved.
//

import UIKit
import Firebase

class RoomTableViewController: UITableViewController {
    
    var selectedIndexPath:Int?
    
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    
    var normalRoom = [String]()
    var repeatRoom = [Int]()
    
    var answerArray = [[Int]]()
    
    var roomNumber:Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        answerArray = []
        
        ref = Database.database().reference()
        
        
        handle = ref?.child("Room/Repeat/Number").observe(DataEventType.childAdded, with: { (snapShot) in
            if let room = snapShot.value as? Int {
                print("接收到重複房間")
                self.repeatRoom.append(room)
                self.tableView.reloadData()
            }
        })
        
        for i in repeatRoom {
            handle = ref?.child("Room/Repeat/Number/\(i)/Answer").observe(DataEventType.childAdded, with: { (snapShot) in
                self.answerArray.append([snapShot.value as! Int] )
                print("add")
                print(self.answerArray)
            })
        }
        
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        } else {
            return repeatRoom.count
        }
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RoomTableViewCell
        
        if indexPath == [0,indexPath.row] {
            cell.gameModeLabel.text = "test普通模式"
            cell.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        } else {
            cell.gameModeLabel.text = "\(repeatRoom[indexPath.row])號房"
            cell.backgroundColor = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == [0,indexPath.row] {
            
        } else {
            roomNumber = self.repeatRoom[indexPath.row]
            selectedIndexPath = indexPath.row
            
                    
           
            performSegue(withIdentifier: "goToRepeat", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRepeat" {
            let repeatVC = segue.destination as! ViewController
            repeatVC.enterRoom = roomNumber
            repeatVC.random = true
        }
    }
    
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
