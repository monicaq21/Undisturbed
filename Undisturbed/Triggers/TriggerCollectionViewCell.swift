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
    
    var slider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    var disgustingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Disgusting"
//        label.font = UIFont.systemFont(ofSize: 9)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .systemGray
        return label
    }()
    
    var bearableLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Bearable"
//        label.font = UIFont.systemFont(ofSize: 9)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .systemGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemMint
        contentView.addSubview(triggerLabel)
        contentView.addSubview(slider)
        contentView.addSubview(disgustingLabel)
        contentView.addSubview(bearableLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        triggerLabel.frame = CGRect(x: 10, y: 0, width: contentView.width - 20, height: contentView.height / 3 * 2)
        slider.frame = CGRect(x: 10, y: triggerLabel.bottom, width: contentView.width - 20, height: contentView.height / 3)
        
        let labelsWidth = slider.width / 4
        
        disgustingLabel.frame = CGRect(x: slider.left, y: slider.top - 20, width: labelsWidth, height: 20)
        bearableLabel.frame = CGRect(x: slider.right - labelsWidth, y: slider.top - 20, width: labelsWidth, height: 20)
    }
    
    override func prepareForReuse() {
        triggerLabel.text = nil
    }
    
    func configure(with model: Trigger) {
        triggerLabel.text = model.name
    }
}
