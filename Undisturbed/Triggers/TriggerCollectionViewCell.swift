//
//  TriggerCollectionViewCell.swift
//  Undisturbed
//
//  Created by Monica Qiu on 9/1/23.
//

import UIKit

class TriggerCollectionViewCell: UICollectionViewCell {
    static let identifier = "TriggerCollectionViewCell"
    
    var triggerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemMint
        contentView.addSubview(triggerLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        triggerLabel.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)
    }
    
    override func prepareForReuse() {
        triggerLabel.text = nil
    }
    
    func configure(with model: Trigger) {
        triggerLabel.text = model.name
    }
}
