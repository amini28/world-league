//
//  Seasons.swift
//  Dicoding-Submission
//
//  Created by Novriansyah Amini on 13/06/21.
//

import Foundation

struct Seasons : Decodable {
    let status : Bool
    let data : SeasonsData
}

struct SeasonsData : Decodable {
    let desc : String
    let seasons : [SeasonsDetail]
}

struct SeasonsDetail : Decodable {
    let year : Int
    
    enum CodingKeys : String, CodingKey {
        case year
    }
}
