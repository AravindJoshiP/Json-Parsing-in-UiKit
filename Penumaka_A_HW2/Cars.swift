//
//  Cars.swift
//  Penumaka_A_HW2
//
//  Created by Aravind Joshi Penumaka on 4/28/26.
//

import Foundation

struct Cars: Codable{
    let data: [Car]
}

struct Car: Codable{
    let id: Int?
    let year: Int?
    let make: String?
    let model: String?
    let trim: String?
    let bodyType: String?
    let fuelType: String?
}
