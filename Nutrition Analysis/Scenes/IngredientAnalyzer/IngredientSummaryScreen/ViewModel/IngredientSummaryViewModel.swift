//
//  IngredientSummaryViewModel.swift
//  Nutrition Analysis
//
//  Created by AhmedFitoh on 5/17/21.
//

import RxCocoa
import RxSwift

class IngredientSummaryViewModel {
    var info: IngredientsRequestModel?
    var rows: Driver<[String]>
    
    var isLoading = BehaviorRelay<Bool>(value: false)
    var details = PublishSubject<NutritionDetailsModel?>()
    var error = PublishSubject<Error?>()
    
    var fetchNutritionTap = PublishSubject<Void>()

    private let api = Networking()
    private let disposeBag = DisposeBag()

    init(info: IngredientsRequestModel?) {
        self.info = info
        self.rows = Observable.just(info?.ingr ?? []).asDriver(onErrorJustReturn: [])
        makeSubscriptions()
    }
    
    private func makeSubscriptions(){
        fetchNutritionTap.do(onNext: {
            self.isLoading.accept(true)
        }).flatMap { [weak self] details -> Observable<NutritionDetailsModel> in
            return (self?.api.analyzeIngredients(with: self!.info!).catch({ error -> Observable<NutritionDetailsModel?> in
                self?.error.onNext(error)
                self?.isLoading.accept(false)
                return Observable.empty()
            }) ?? Observable.empty()).compactMap { $0 }
        }.subscribe {[weak self] data in
            self?.details.on(.next(data.element))
            self?.isLoading.accept(false)
        }.disposed(by: disposeBag)
    }

}
