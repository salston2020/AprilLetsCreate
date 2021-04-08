//
//  bookingCellTableViewCell.swift
//  Lets Create
//
//  Created by Sheena Alston on 4/7/21.
//

import UIKit

class bookingCellTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var quoteTextLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
