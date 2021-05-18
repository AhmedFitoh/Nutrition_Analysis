//
//  NutritionFactsViewController.swift
//  Nutrition Analysis
//
//  Created by AhmedFitoh on 5/18/21.
//

import RxCocoa
import RxSwift

class NutritionFactsViewController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!

    var viewModel: NutritionFactsViewModel!
    private let disposeBag = DisposeBag()

    // MARK: - init
    
    convenience init(_ details: NutritionDetailsModel) {
        self.init()
        self.viewModel = NutritionFactsViewModel(details: details)
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
    }
    
    private func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
    }
 
    // MARK: - ViewModel bindings
    
    private func viewModelBindings(){
        bindViews()
    }
    
    private func bindViews(){
        viewModel.rows
            .drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.lineBreakMode = .byWordWrapping
                cell.textLabel?.numberOfLines = 0
                cell.textLabel?.text = "\(element.label): \(element.quantity) \(element.unit)"
                
            }
            .disposed(by: disposeBag)
    }
    
}

