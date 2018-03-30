//
//  AddCollectionViewCell.swift
//  Tab Selections
//
//  Created by Hitesh Agarwal on 28/06/17.
//  Copyright © 2017 Finoit Technologies. All rights reserved.
//

import UIKit
protocol OptionCollectionViewCellDelegate {
    func passBackAddAction(index: Int)
}

class OptionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var customContentView: UIView!
    
    var delegate: OptionCollectionViewCellDelegate?
    var index = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customContentView.layer.cornerRadius = 14
        // Initialization code
    } 
    @IBAction func actionAdd(_ sender: Any) {
        delegate?.passBackAddAction(index: self.index)
    }
}
