//
//  PokemonModel.swift
//  Nextzy_Assignment
//
//  Created by Prapawit Patthasirivichot on 15/2/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import Foundation

struct ApiCallerObj: Decodable {
    let results: [PokemonURL]?
}

struct PokemonURL: Decodable {
    let name: String?
    let url: String?
}

struct PokemonModel: Decodable {
    let name:String?
    let sprites : Sprites?
    let id: Int?
    let base_experience: Int?
    let weight: Int?
}

struct Sprites: Decodable {
    let front_default: String?
}

struct Pokemon: Decodable {
    let name: String?
    let url: String?
}
