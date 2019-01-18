//
//  TodoListTableViewCell.swift
//  TODOTask
//
//  Created by Mac on 27/10/1940 Saka.
//  Copyright © 1940 Mac. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
 
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
