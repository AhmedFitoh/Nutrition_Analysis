//
//  NutritionDetailsModel.swift
//  Nutrition Analysis
//
//  Created by AhmedFitoh on 5/14/21.
//

import Foundation

// MARK: - NutritionDetailsModel
struct NutritionDetailsModel: Codable {
    let uri: String?
    let yield, calories: Int?
    let dietLabels, healthLabels: [String]?
    let totalNutrients: [String: TotalNutrient]?
    var nutrients: [TotalNutrient] {
        totalNutrients?.values.compactMap{$0} ?? []
    }
}

// MARK: - TotalNutrient
struct TotalNutrient: Codable {
    let label: String
    let quantity: Double
    let unit: String
}
