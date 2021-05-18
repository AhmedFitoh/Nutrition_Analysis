//
//  NutritionFactsViewModel.swift
//  Nutrition Analysis
//
//  Created by AhmedFitoh on 5/18/21.
//

import RxCocoa
import RxSwift

class NutritionFactsViewModel{
    
    var rows: Driver<[TotalNutrient]>

    init(details: NutritionDetailsModel) {
        self.rows = Observable.just(details.nutrients).asDriver(onErrorJustReturn: [])
    }
    
    
}
