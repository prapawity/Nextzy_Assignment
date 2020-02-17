//
//  ShowListModel.swift
//  Nextzy_Assignment
//
//  Created by Prapawit Patthasirivichot on 15/2/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import Foundation
import Alamofire
class ShowListViewModel{
    var indexCounter: Int = 0
    private var dataList: [PokemonModel] = []
    private var showList: [PokemonModel] = []
    var testList: [PokemonModel] = []
    public func getDataList() -> [PokemonModel]{
        return self.dataList
    }
    
    public func getShowList() -> [PokemonModel]{
        return self.showList
    }
    
    public func appendDatatoList(pokemon: PokemonModel){
        self.dataList.append(pokemon)
    }
    
    public func appendShowList(pokemon: PokemonModel){
        self.showList.append(pokemon)
    }
    
    public func getDataListFromIndex(index: Int) -> PokemonModel{
        return dataList[index]
    }
    
    public func clearShowList(){
        self.showList = []
    }
    
    public func addIndexShowList(){
        for i in indexCounter ... indexCounter+9{
            showList.append(dataList[i])
        }
        indexCounter += 9
    }
    
}

extension ShowListViewModel: ApiCaller{

    
    func callApi(url: String, completion: @escaping (PokemonModel) -> Void) {
        AF.request(url).responseJSON{
            (response) in
            do{
                let pokemon = try JSONDecoder().decode(PokemonModel.self, from: response.data!)
                completion(pokemon)
            }catch{
                print("error")
            }
        }
    }
    
    func callAPIResult(completion: @escaping (ApiCallerObj) -> Void){
        let path = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=2000"
        AF.request(path).responseJSON{
            (response) in
            do{
                let pokemon = try JSONDecoder().decode(ApiCallerObj.self, from: response.data!)
                completion(pokemon)
            }catch{
                print("error")
            }
        }
    }
    
}
