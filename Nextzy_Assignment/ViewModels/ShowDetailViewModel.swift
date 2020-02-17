//
//  ShowDetailViewModel.swift
//  Nextzy_Assignment
//
//  Created by Prapawit Patthasirivichot on 17/2/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
class ShowDetailViewModel{
    
}

extension ShowDetailViewModel: ImgLoader{
    func downloadImg(url: String, img: UIImageView) {
        img.kf.setImage(with:URL(string: url), placeholder: nil, options: nil, progressBlock: nil) { result in
        }
    }
    
    
}
