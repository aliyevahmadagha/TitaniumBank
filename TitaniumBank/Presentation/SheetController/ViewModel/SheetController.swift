//
//  SheetController.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 21.12.24.
//

import Foundation
import UIKit

final class SheetController: BaseViewController {
    
    private lazy var sheetTable: UITableView = {
        let table = UITableView()
        table.rowHeight = 50
        return table
    }()
    
    private let viewModel:  SheetViewModel

    init(viewModel: SheetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureRestriction()
        setupTableView()
    }
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(sheetTable)
        
        sheetTable.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        
        sheetTable.fillSuperview()
    }
    
    fileprivate func setupTableView() {
        sheetTable.delegate = self
        sheetTable.dataSource = self
        sheetTable.register(cell: SheetCell.self)
    }
}

extension SheetController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: SheetCell.self, for: indexPath)
        let item = viewModel.getItem(index: indexPath.row)
        cell.configureCell(model: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pan = viewModel.getCardModel(index: indexPath.row)
        let type = viewModel.getCardType(index: indexPath.row)
        viewModel.callback?(pan, type)
        dismiss(animated: true)
    }
}




