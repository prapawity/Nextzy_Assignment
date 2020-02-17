//
//  ShowPokemonTableViewCell.swift
//  Nextzy_Assignment
//
//  Created by Prapawit Patthasirivichot on 17/2/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import UIKit
import LoadingPlaceholderView
import Kingfisher
class ShowPokemonTableViewCell: UITableViewCell {
    let loadingPlace = LoadingPlaceholderView()
    @IBOutlet weak var showUIView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadingPlace.cover(showUIView, animated: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setCell(url:String,name:String){
        self.img.kf.setImage(with:URL(string: url), placeholder: nil, options: nil, progressBlock: nil) { result in
            self.name.text = name
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loadingPlace.uncover(animated: true)
            }
        }
    }
    
}
