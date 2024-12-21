//
//  MyCardsController.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 20.12.24.
//

import UIKit

final class MyCardsController: BaseViewController {
    
    private lazy var cardTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 50
        return table
    }()
    
    private let viewModel: MyCardsViewModel
    
    init(viewModel: MyCardsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        congigureViewModel()

    }
    
    @objc private func renewTapped() {
        viewModel.renewList()
        
    }
    
    fileprivate func setupTableView() {
        cardTableView.delegate = self
        cardTableView.dataSource = self
        cardTableView.register(cell: CardTableCell.self)
    }
    
    fileprivate func createBarButton() {
        let renewButton = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .plain, target: self, action: #selector(renewTapped))
        
        navigationItem.rightBarButtonItem = renewButton
    }
    
    fileprivate func congigureViewModel() {
        
        viewModel.listener = { [weak self] in
            guard let self = self else {return}
            
            self.cardTableView.reloadData()
            
            let num = viewModel.getCount()
            print(num)
        }
    }
    
    override func configureTargets() {
        super.configureTargets()
        createBarButton()
    }
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(cardTableView)
        
        cardTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        
        NSLayoutConstraint.activate([
            cardTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cardTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            cardTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            cardTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MyCardsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: CardTableCell.self, for: indexPath)
        
        let item = viewModel.getItem(index: indexPath.row)
        cell.configureCell(model: item)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            
            self.viewModel.deleteCard(index: indexPath.row)
            self.viewModel.delegate?.reload()
            
            let viewmodel = AddCardViewModel()
            viewmodel.listener?(.success)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
