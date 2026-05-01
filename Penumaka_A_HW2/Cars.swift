//
//  Cars.swift
//  Penumaka_A_HW2
//
//  Created by Aravind Joshi Penumaka on 4/28/26.
//

import Foundation

struct CarMakeResponse: Codable {
    let data: [CarMake]
}

struct CarMake: Codable {
    let id: Int?
    let name: String?
}

struct CarResponse: Codable {
    let data: [Car]
}

struct Car: Codable {
    let id: Int?
    let make: String?
    let name: String?
}
