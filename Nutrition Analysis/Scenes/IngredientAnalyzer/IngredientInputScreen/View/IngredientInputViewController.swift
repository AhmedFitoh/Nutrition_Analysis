//
//  IngredientInputViewController.swift
//  Nutrition Analysis
//
//  Created by AhmedFitoh on 5/14/21.
//

import UIKit
import RxSwift
import RxCocoa

class IngredientInputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    @IBOutlet weak var analyzeButton: UIButton!
    
    let viewModel = IngredientInputViewModel()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModelBindings()
    }
    
    // MARK: - UI
    
    private func setupUI(){
        setupIngredientsTextView()
    }

    private func setupIngredientsTextView(){
        ingredientsTextView.layer.borderWidth = 0.5
        ingredientsTextView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func updateButtonAvailability(isValid : Bool){
        analyzeButton.setTitleColor((isValid) ? .black : UIColor.black.withAlphaComponent(0.5), for: .normal)
        analyzeButton.isEnabled = isValid
    }

    
    // MARK: - ViewModel bindings
    
    private func viewModelBindings(){
        self.bindViews()
        self.bindStates()
    }

    private func bindViews(){
        titleTextField.rx.text
            .orEmpty
            .bind(to: viewModel.title)
            .disposed(by: disposeBag)
        
        ingredientsTextView.rx.text
            .orEmpty
            .bind(to: viewModel.ingredients)
            .disposed(by: disposeBag)

        analyzeButton.rx.tap
            .bind(to: viewModel.analyzeButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func bindStates(){
        self.viewModel.isValid
            .subscribe(onNext: { [weak self] (isValid) in
                self?.updateButtonAvailability(isValid: isValid)
            }).disposed(by: disposeBag)
        
        viewModel.ingredientsRequest
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] ingredientRequest in
                self?.navigateToSummaryScreen(ingredientRequest)
            }.disposed(by: disposeBag)
    }
}

// MARK: - Navigations
extension IngredientInputViewController{ 
    private func navigateToSummaryScreen(_ info: IngredientsRequestModel){
        let summaryViewController = IngredientSummaryViewController(info)
        navigationController?.pushViewController(summaryViewController, animated: true)
    }
}
