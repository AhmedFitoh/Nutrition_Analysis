//
//  IngredientInputViewModel.swift
//  Nutrition Analysis
//
//  Created by AhmedFitoh on 5/14/21.
//

import RxCocoa
import RxSwift

class IngredientInputViewModel {
    
    var title = PublishSubject<String>()
    var ingredients = PublishSubject<String>()
    var ingredientsRequest = PublishRelay<IngredientsRequestModel>()
    
    var analyzeButtonTapped = PublishSubject<Void>()
    
    var isValid: Observable<Bool>{
        return  Observable<Bool>.combineLatest(title.asObservable().startWith(""),
                                               ingredients.asObservable().startWith(""),
                                               resultSelector: { (title, ingredients) -> Bool in
            return !(title.isEmpty || ingredients.isEmpty)
        })
    }
    
    private let disposeBag = DisposeBag()
    
    init() {
        makeSubscriptions()
    }
    
    private func makeSubscriptions(){
        analyzeButtonTapped
            .withLatestFrom(Observable.combineLatest(title, ingredients))
            .subscribe { [weak self] (title, ing) in
             guard let self = self else {return}
             let ingredientsSplitted = ing.split(separator: "\n").map(String.init)
             let request = IngredientsRequestModel(title: title, ingr: ingredientsSplitted)
            self.ingredientsRequest.accept(request)
        }.disposed(by: disposeBag)

    }
}
