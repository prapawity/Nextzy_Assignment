//
//  ShowDetailViewController.swift
//  Nextzy_Assignment
//
//  Created by Prapawit Patthasirivichot on 17/2/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import UIKit

class ShowDetailViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var exp: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var weight: UILabel!
    var dataModel: PokemonModel?
    var viewModel =  ShowDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        self.title = dataModel?.name!
        viewModel.downloadImg(url: dataModel?.sprites?.front_default ?? "https://thaigifts.or.th/wp-content/uploads/2017/03/no-image.jpg", img: img)
        name.text = dataModel?.name!
        id.text = "\(dataModel!.id!)"
        exp.text = "\(dataModel!.base_experience!)"
        weight.text = "\(dataModel!.weight!)"
    }

}
