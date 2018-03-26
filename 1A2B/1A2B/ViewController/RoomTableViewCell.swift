//
//  RoomTableViewCell.swift
//  1A2B
//
//  Created by JeremyXue on 2018/3/23.
//  Copyright © 2018年 JeremyXue. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    
    let repeatRoomIdentifer = "enterRepeatRoom"
    
    @IBOutlet weak var gameModeLabel: UILabel!
    
    @IBAction func enterRoom(_ sender: UIButton) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
