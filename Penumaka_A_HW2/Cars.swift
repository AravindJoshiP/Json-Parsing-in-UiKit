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

struct CarDetailsResponse: Codable{
    let data:[CarDetails]
}

struct CarDetails: Codable{
    let make: String?
    let model: String?
    let trim_description: String?
    let engine_type: String?
    let transmission: String?
    let drive_type: String?
}
