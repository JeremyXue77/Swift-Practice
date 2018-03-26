//
//  TableViewCell.swift
//  1A2B
//
//  Created by JeremyXue on 2018/3/21.
//  Copyright © 2018年 JeremyXue. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var recordAB: UILabel!
    @IBOutlet weak var guessNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
