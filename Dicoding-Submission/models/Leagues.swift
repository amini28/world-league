//
//  Leagues.swift
//  Dicoding-Submission
//
//  Created by Novriansyah Amini on 12/06/21.
//

import Foundation

struct Leagues : Decodable {
    let data : [LeaguesData]
    let status : Bool
}

struct LeaguesData : Identifiable, Decodable {
    var id : String
    let slug : String
    let abbr : String
    let name : String
    let logos : LeaguesLogo
}

struct LeaguesLogo : Decodable {
    let light : String
    let dark : String
}
