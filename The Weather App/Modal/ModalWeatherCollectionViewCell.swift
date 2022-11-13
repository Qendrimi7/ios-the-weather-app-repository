//
//  ModalWeatherCollectionViewCell.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 13.11.22.
//

import UIKit

class ModalWeatherCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Subviews
    private let weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "OpenSans-Semibold", size: 18)
        label.textColor = Theme.descriptionLabelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let maxAndMinTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "OpenSans-Semibold", size: 14)
        label.textColor = Theme.secondaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        weekdayLabel.text = nil
        currentWeatherImageView.image = nil
        maxAndMinTemperatureLabel.text = nil
    }
    
    // MARK: - Setup
    private func setup() {
        setupViews()
    }
    
    // MARK: - Setup views
    private func setupViews() {
        addSubview(weekdayLabel)
        weekdayLabel
            .leadingAnchor(equalTo: leadingAnchor, constant: 2)
            .topAnchor(equalTo: topAnchor, constant: 2)
            .trailingAnchor(equalTo: trailingAnchor, constant: 2)
        
        addSubview(currentWeatherImageView)
        currentWeatherImageView
            .topAnchor(equalTo: weekdayLabel.bottomAnchor, constant: 2)
            .centerHorizontal(equalTo: weekdayLabel.centerXAnchor)
            .centerVertical(equalTo: centerYAnchor)
            .widthAnchor(constant: 35)
            .heightAnchor(constant: 35)
        
        addSubview(maxAndMinTemperatureLabel)
        maxAndMinTemperatureLabel
            .leadingAnchor(equalTo: leadingAnchor, constant: 2)
            .topAnchor(equalTo: currentWeatherImageView.bottomAnchor, constant: 2)
            .trailingAnchor(equalTo: trailingAnchor, constant: 2)
            .bottomAnchor(equalTo: bottomAnchor, constant: 2)
            
    }
    
    func configureCell(
        weekdayString: String,
        currentWeatherImageNameString: String,
        maxAndMinTemperatureString: String
    ) {
        weekdayLabel.text = weekdayString
        currentWeatherImageView.image = UIImage(named: currentWeatherImageNameString)
        maxAndMinTemperatureLabel.text = maxAndMinTemperatureString
    }
        
}
