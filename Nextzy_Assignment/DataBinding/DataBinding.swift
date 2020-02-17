//
//  DataBinding.swift
//  Nextzy_Assignment
//
//  Created by Prapawit Patthasirivichot on 15/2/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import Foundation
import UIKit
protocol ApiCaller {
    func callApi(url: String,completion: @escaping (PokemonModel) -> Void)
    func callAPIResult(completion: @escaping (ApiCallerObj) -> Void)
}

protocol ImgLoader {
    func downloadImg(url: String, img: UIImageView)
}

