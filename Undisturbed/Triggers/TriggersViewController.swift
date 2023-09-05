//
//  TriggersViewController.swift
//  Undisturbed
//
//  Created by Monica Qiu on 9/1/23.
//

import UIKit

class TriggersViewController: UIViewController {
    
    var triggers = [Trigger]()
    
    var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.5),
                        heightDimension: .fractionalWidth(0.5)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalWidth(0.5)
                    ),
                    subitems: [item, item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                
                return section
            })
        )
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Misophonic Triggers"
        
        collectionView.register(TriggerCollectionViewCell.self, forCellWithReuseIdentifier: TriggerCollectionViewCell.identifier)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        loadData()
    }
    
    private func loadData() {
        // mock
//        let ref = Database.database().reference()
//        if let userid = Auth.auth().currentUser?.uid {
////            let dict = ref.child("users/\(userid)/triggers") get data
//            triggers = []
//        }
        
        
        DispatchQueue.main.async {
            self.collectionView.reloadData() // refresh in main thread
            self.collectionView.layoutIfNeeded()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}

extension TriggersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        triggers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TriggerCollectionViewCell.identifier, for: indexPath) as? TriggerCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.configure(with: triggers[indexPath.row])
        return cell
    }
    
    
}
