//
//  chatCell.swift
//  parse-chat
//
//  Created by Sandra Luo on 2/23/18.
//  Copyright © 2018 Sandra Luo. All rights reserved.
//

import UIKit

class chatCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
