//
//  Club.swift
//  Dicoding-Submission
//
//  Created by Novriansyah Amini on 13/06/21.
//

import Foundation

struct Club : Decodable {
    let status : Bool
    let data : ClubData
}

struct ClubData : Decodable{
    let name : String
    let seasonDisplay : String
    let season : Int
    let standings : [Team]
}

struct Team : Decodable {
    let team : TeamData
    let stats : [TeamStats]

    enum CodingKeys : String, CodingKey {
        case team = "team"
        case stats = "stats"
    }
}

struct TeamData : Decodable {
    let id : String
    let uid : String
    let location : String
    let name : String
    let abbreviation : String
    let displayName : String
    let shortDisplayName : String
    let isActive : Bool
    let logos : [TeamLogos]?
}

struct TeamLogos : Decodable {
    let href : String
    enum CodingKeys : String, CodingKey {
        case href = "href"
    }
}

struct TeamStats : Decodable{
    let name : String
    let displayName : String
    let shortDisplayName : String
    let description : String
    let abbreviation : String
    let type : String
    let displayValue : String
    
    enum CodingKeys : String, CodingKey {
        case name = "name"
        case displayName = "displayName"
        case shortDisplayName = "shortDisplayName"
        case description = "description"
        case abbreviation = "abbreviation"
        case type = "type"
        case displayValue = "displayValue"
    }
}
