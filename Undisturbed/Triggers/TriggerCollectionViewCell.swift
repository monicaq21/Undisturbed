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
        return label
    }()
    
    var bearableLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Bearable"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    var previousSliderValue: Int = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        contentView.addGradientBackground(colors: [.systemPink, .white])
        
        contentView.addSubview(triggerLabel)
        contentView.addSubview(slider)
        contentView.addSubview(disgustingLabel)
        contentView.addSubview(bearableLabel)
        
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc private func sliderValueChanged() {
        let value = slider.value
        let nearestValue = Int(floor(value + 0.5))
        
        if (nearestValue != previousSliderValue) {
            previousSliderValue = nearestValue
            slider.setValue(Float(nearestValue), animated: false)
            //        delegate.updatePreferenceValue(to: value) xxx
            updateBackgroundColor()
        }
        
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
        previousSliderValue = 2 // xxx change later
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        let value = slider.value
        
        DispatchQueue.main.async {
            var colors = [UIColor]()
            
            if (value == 5) {
                colors = [.systemBlue, .white]
            } else if (value == 4) {
                colors = [UIColor.systemBlue.withAlphaComponent(0.5), .white]
            } else if (value == 3) {
                colors = [UIColor.systemBlue.withAlphaComponent(0.5), UIColor.systemPink.withAlphaComponent(0.5)]
            } else if (value == 2) {
                colors = [UIColor.systemPink.withAlphaComponent(0.5), .white]
            } else if (value == 1) {
                colors = [UIColor.systemPink, .white]
            }
            
            self.contentView.replaceGradientBackground(colors: colors)
        }
        
    }
}
