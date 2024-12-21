//
//  SettingsController.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import UIKit

final class SettingsController: BaseViewController {
    
    private lazy var settingsTableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 50
        return table
    }()
    
    private let viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func configureView() {
        super.configureView()
        title = "Settings"
        view.addSubview(settingsTableView)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func setupTableView() {
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(cell: SettingsTableCell.self)
    }
    
    
    override func configureRestriction() {
        super.configureRestriction()
        settingsTableView.fillSuperviewSafeAreaLayoutGuide()
    }

}

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: SettingsTableCell.self, for: indexPath)
        
        cell.configureLabel(item: viewModel.getItem(index: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            
            if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                scene.changeRooterToLoginController()
            }
        case 1:
            let controller = MyCardsController(viewModel: MyCardsViewModel())
            navigationController?.pushViewController(controller, animated: true)
        default:
            break
        }
    }
        
}
