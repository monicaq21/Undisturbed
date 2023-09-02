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
        
        collectionView.register(TriggerCollectionViewCell.self, forCellWithReuseIdentifier: TriggerCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemGray
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        loadData()
    }
    
    private func loadData() {
        // mock
        triggers.append(Trigger(name: "Wet Chewing"))
        triggers.append(Trigger(name: "Chalk Scratching"))
        triggers.append(Trigger(name: "Yawning"))
        triggers.append(Trigger(name: "Tapping"))
        triggers.append(Trigger(name: "Coughing"))
        
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
