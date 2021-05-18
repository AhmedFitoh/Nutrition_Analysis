//
//  IngredientSummaryViewController.swift
//  Nutrition Analysis
//
//  Created by AhmedFitoh on 5/17/21.
//

import RxSwift
import RxCocoa

class IngredientSummaryViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fetchTotalNutritionButton: UIButton!
    
    var viewModel: IngredientSummaryViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - init
    
    convenience init(_ info: IngredientsRequestModel?) {
        self.init()
        self.viewModel = IngredientSummaryViewModel(info: info)
    }
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModelBindings()
    }
    
    
    // MARK: - UI
    
    private func setupUI(){
        setupTable()
        title = viewModel.info?.title
    }
    
    private func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
    }
    
    private func updateButtonAvailability(isValid : Bool){
        fetchTotalNutritionButton.setTitleColor((isValid) ? .black : UIColor.black.withAlphaComponent(0.5), for: .normal)
        fetchTotalNutritionButton.isEnabled = isValid
    }
    
    // MARK: - ViewModel bindings
    
    private func viewModelBindings(){
        bindViews()
        bindStates()
    }
    
    private func bindViews(){
        viewModel.rows
            .drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.lineBreakMode = .byWordWrapping
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = element
            }
            .disposed(by: disposeBag)
        
        fetchTotalNutritionButton.rx.tap
            .bind(to: viewModel.fetchNutritionTap)
            .disposed(by: disposeBag)
    }
    
    private func bindStates(){
        viewModel.details
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (nutritionDetails) in
                self?.navigateToDetailsScreen(nutritionDetails)
            }).disposed(by: disposeBag)
        
        viewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (error) in
                self?.showAlert(title: "Error", message: error?.localizedDescription, completion: nil)
            }).disposed(by: disposeBag)
        
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] loading in
                self?.updateButtonAvailability(isValid: !loading)
            }.disposed(by: disposeBag)
        
        
        viewModel.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
}

// MARK: - Navigations
extension IngredientSummaryViewController{
    private func navigateToDetailsScreen(_ details: NutritionDetailsModel?){
        let detailsViewController = NutritionFactsViewController(details!)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}


