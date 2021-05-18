//
//  Networking.swift
//  Nutrition Analysis
//
//  Created by AhmedFitoh on 5/14/21.
//

import Foundation
import RxSwift
import RxCocoa

final class Networking {
   
    func analyzeIngredients(with requestInfo: IngredientsRequestModel) -> Observable<NutritionDetailsModel?> {
        let url = URL(string: baseUrl + "nutrition-details?app_id=\(appID)&app_key=\(appKey)")!
        var request = URLRequest(url: url)
        request.httpBody = try? JSONEncoder().encode(requestInfo)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")        
        return URLSession.shared.rx.data(request: request)
            .map { data -> NutritionDetailsModel? in
                guard let response = try? JSONDecoder().decode(NutritionDetailsModel.self, from: data) else { return nil }
                return response
            }
    }
}
