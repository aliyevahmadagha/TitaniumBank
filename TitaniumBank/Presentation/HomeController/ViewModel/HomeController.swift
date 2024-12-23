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
    
    lazy var cardStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    lazy var transferButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(transferButtonClicked), for: .touchUpInside)
        button.setTitle("⇄", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 24
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 24
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
        
        viewModel.findPath()
    }
    
    
    @objc fileprivate func transferButtonClicked() {
        let controller = TransferController(viewModel: TransferViewModel())
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
        viewModel.getListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        let item = viewModel.getItem(index: indexPath.row)
        cell.configureCell(model: item)
        
        return cell
        
    }
}


