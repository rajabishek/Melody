//
//  MusicVideoTableViewCell.swift
//  Melody
//
//  Created by Raj Abishek on 13/03/16.
//  Copyright © 2016 Raj Abishek. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var musicVideo: MusicVideo? {
        didSet {
            rankTextLabel.text = "\(musicVideo!.rank)"
            nameTextLabel.text = musicVideo!.name
            musicVideoImageView.image = UIImage(named: "noImage")
        }
    }
    
    
    @IBOutlet weak var musicVideoImageView: UIImageView!
    
    @IBOutlet weak var rankTextLabel: UILabel!
    
    @IBOutlet weak var nameTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
