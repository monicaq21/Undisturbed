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
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.value = 3
        return slider
    }()
    
    var disgustingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Disgusting"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray3
        return label
    }()
    
    var bearableLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Bearable"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.textColor = .systemGray3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(triggerLabel)
        contentView.addSubview(slider)
        contentView.addSubview(disgustingLabel)
        contentView.addSubview(bearableLabel)
        
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc private func sliderValueChanged() {
        let value = slider.value
        let nearestValue = floor(value + 0.5)
        slider.setValue(nearestValue, animated: false)
//        delegate.updatePreferenceValue(to: value) xxx
        updateBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        triggerLabel.frame = CGRect(x: 10, y: 0, width: contentView.width - 20, height: contentView.height / 2)
        
        let labelsWidth = (contentView.width - 20) / 2.2
        disgustingLabel.frame = CGRect(
            x: 10,
            y: triggerLabel.bottom + 20,
            width: labelsWidth,
            height: 20
        )
        bearableLabel.frame = CGRect(
            x: contentView.right - 10 - labelsWidth,
            y: triggerLabel.bottom + 20,
            width: labelsWidth,
            height: 20
        )
        
        slider.frame = CGRect(
            x: 10,
            y: disgustingLabel.bottom,
            width: contentView.width - 20,
            height: contentView.bottom - disgustingLabel.bottom
        )
        

    }
    
    override func prepareForReuse() {
        triggerLabel.text = nil
    }
    
    func configure(with model: Trigger) {
        triggerLabel.text = model.name
        slider.value = 2 // xxx change later
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        let value = slider.value
        
        DispatchQueue.main.async {
            if (value == 5) {
                self.contentView.backgroundColor = .blue
            } else if (value == 4) {
                self.contentView.backgroundColor = .green
            } else if (value == 3) {
                self.contentView.backgroundColor = .yellow
            } else if (value == 2) {
                self.contentView.backgroundColor = .orange
            } else if (value == 1) {
                self.contentView.backgroundColor = .red
            }
        }
        
    }
}
