//
//  HomeController.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import UIKit

final class HomeController: BaseViewController {
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let design = UICollectionViewFlowLayout()
        let width = view.frame.size.width - 48
        design.scrollDirection = .horizontal
        design.itemSize = CGSize(width: width, height: 250)
        design.minimumLineSpacing = 0
        design.minimumInteritemSpacing = 0
        return design
    }()
    
    private lazy var cardCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.layer.cornerRadius = 25
        collection.isPagingEnabled = true
        return collection
    }()
    
    private lazy var cardStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    private lazy var transferButton: UIButton = {
        let button = ReusableButton(title: "⇄", onAction: transferButtonClicked, cornerRad: 24, bgColor: .lightGray, titleColor: .black)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = ReusableButton(title: "+", onAction: addButtonClicked, cornerRad: 24, bgColor: .lightGray, titleColor: .black)
        return button
    }()
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: .reloadDataNotification, object: nil)
    }
    
    fileprivate func configureButton() {
        
        guard viewModel.getListCount() >= 2 else {
            transferButton.isHidden = true
            return
        }
        transferButton.isHidden = false
    }
    
    @objc func reloadCollectionView() {
        cardCollection.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc fileprivate func transferButtonClicked() {
        let viewModel = TransferViewModel()
        let controller = TransferController(viewModel: viewModel)
        
        viewModel.success = { [weak self] state in
            guard let self = self else {return}

            if state == .success {
                cardCollection.reloadData()
            }
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc fileprivate func addButtonClicked() {
        let viewModel = AddCardViewModel()
        let controller = AddCardController(viewModel: viewModel)
        
        viewModel.listener = { [weak self] state in
            guard let self = self else {return}
            
            switch state {
            case .success:
                self.cardCollection.reloadData()
            case .loading:
                print("loading")
            case .loaded:
                print("loaded")
            case .error(let message):
                print(message)
            }
        }
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    fileprivate func setupCollectionView() {
        cardCollection.delegate = self
        cardCollection.dataSource = self
        cardCollection.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
    }
    
    override func configureView() {
        super.configureView()
        title = "Home"
        view.addSubview(cardCollection)
        view.addSubview(cardStack)
        cardStack.addArrangedSubview(transferButton)
        cardStack.addArrangedSubview(addButton)
        
        cardCollection.translatesAutoresizingMaskIntoConstraints = false
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        transferButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        
        NSLayoutConstraint.activate([
            cardCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            cardCollection.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            cardCollection.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            cardCollection.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            cardStack.topAnchor.constraint(equalTo: cardCollection.bottomAnchor, constant: 48),
            cardStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            transferButton.heightAnchor.constraint(equalToConstant: 48),
            transferButton.widthAnchor.constraint(equalToConstant: 48),
            addButton.heightAnchor.constraint(equalToConstant: 48),
            addButton.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        configureButton()
        return viewModel.getListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        let item = viewModel.getItem(index: indexPath.row)
        cell.configureCell(model: item)
        
        return cell
        
    }
}


