//
//  ListPokemonViewController.swift
//  Nextzy_Assignment
//
//  Created by Prapawit Patthasirivichot on 15/2/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import UIKit

enum Section: Int,CaseIterable{
    case pokemonList,loadMore
}

class ListPokemonViewController: UIViewController {
    var viewModel = ShowListViewModel()
    var isLoadmore = true
    @IBOutlet weak var showListPokemonTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetup()
        testCall()
        //        collectionViewSetup()
        // Do any additional setup after loading the view.
    }
    
    private func tableViewSetup(){
        showListPokemonTableView.delegate = self
        showListPokemonTableView.dataSource = self
        showListPokemonTableView.register(UINib(nibName: "ShowPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "pokemonCell")
    }
    
    func testCall(){
        var indexChk = 0
        self.viewModel.callAPIResult { (ApiCallerObj) in
            for pokeIndex in ApiCallerObj.results!{
                self.viewModel.callApi(url: pokeIndex.url!) { (PokemonModel) in
                    indexChk += 1
                    self.viewModel.appendDatatoList(pokemon: PokemonModel)
                    
                    
                    if indexChk == 50{
                        for i in 0 ... 49{
                            self.viewModel.appendShowList(pokemon: self.viewModel.getDataList()[i])
                        }
                        self.viewModel.indexCounter = 49
                        self.showListPokemonTableView.reloadData()
                        
                        
                    }
                    
                }
                
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShowDetail"{
            if let destination = segue.destination as? ShowDetailViewController{
                let data = (sender as? PokemonModel)!
                destination.dataModel = data
            }
        }
    }
    
    
    
}

extension ListPokemonViewController: UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .pokemonList:
            print(self.viewModel.getShowList().count)
            return self.viewModel.getShowList().count
        case .loadMore:
            return isLoadmore ? 1 : 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch Section(rawValue: indexPath.section)! {
        case .pokemonList:
            if let cell = showListPokemonTableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? ShowPokemonTableViewCell{
                cell.setCell(url: viewModel.getShowList()[indexPath.row].sprites?.front_default ?? "https://thaigifts.or.th/wp-content/uploads/2017/03/no-image.jpg", name: viewModel.getShowList()[indexPath.row].name ?? "No Name")
                return cell
            }
        case .loadMore:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "loading", for: indexPath) as? UITableViewCell{
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty == false{
            self.isLoadmore = false
            viewModel.clearShowList()
            self.showListPokemonTableView.reloadData()
            viewModel.getDataList().filter { (PokemonModel) -> Bool in
                if PokemonModel.name?.contains(searchText.lowercased()) ?? false {
                    viewModel.appendShowList(pokemon: PokemonModel)
                    self.showListPokemonTableView.reloadData()
                }
                return false
            }
            
            
            
        }else{
            self.isLoadmore = true
            viewModel.clearShowList()
            for i in 0 ... 49{
                self.viewModel.appendShowList(pokemon: self.viewModel.getDataList()[i])
            }
            self.showListPokemonTableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == Section.loadMore.rawValue {
            updateData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toShowDetail", sender: viewModel.getShowList()[indexPath.row])
    }
    
    
    private func updateData(){
        if self.viewModel.indexCounter+19 < self.viewModel.getDataList().count{
            for i in  self.viewModel.indexCounter ... self.viewModel.indexCounter+19{
                self.viewModel.appendShowList(pokemon: self.viewModel.getDataList()[i])
            }
            self.viewModel.indexCounter += 19
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showListPokemonTableView.reloadData()
        }
    }
    
    
    
}
