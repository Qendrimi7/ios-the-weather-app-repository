//
//  CurrentWeatherTableViewCell.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {

    // MARK: - Subviews
    private let weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(
            ofSize: 18,
            weight: .semibold
        )
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countryAndCityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(
            ofSize: 18,
            weight: .semibold
        )
        label.textColor = .black
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
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(
            ofSize: 18,
            weight: .semibold
        )
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        weekdayLabel.text = nil
        countryAndCityLabel.text = nil
        currentWeatherImageView.image = nil
        maxTemperatureLabel.text = nil
    }
    
    // MARK: - Setup
    private func setup() {
        setupViews()
    }
    
    // MARK: - Setup views
    private func setupViews() {
        contentView.addSubview(weekdayLabel)
        weekdayLabel.leadingAnchor(equalTo: leadingAnchor, constant: 16)
        weekdayLabel.topAnchor(equalTo: topAnchor, constant: 16)
        weekdayLabel.heightAnchor(constant: 50)
        
        contentView.addSubview(countryAndCityLabel)
        countryAndCityLabel.leadingAnchor(equalTo: leadingAnchor, constant: 16)
        countryAndCityLabel.topAnchor(equalTo: weekdayLabel.bottomAnchor, constant: 8)
        countryAndCityLabel.heightAnchor(constant: 25)
        countryAndCityLabel.bottomAnchor(equalTo: bottomAnchor, constant: 16)

        contentView.addSubview(currentWeatherImageView)
        currentWeatherImageView.trailingAnchor(equalTo: trailingAnchor, constant: 16)
        currentWeatherImageView.topAnchor(equalTo: topAnchor, constant: 16)
        currentWeatherImageView.widthAnchor(constant: 50)
        currentWeatherImageView.heightAnchor(constant: 50)
        
        contentView.addSubview(maxTemperatureLabel)
        maxTemperatureLabel.trailingAnchor(equalTo: trailingAnchor, constant: 16)
        maxTemperatureLabel.topAnchor(equalTo: currentWeatherImageView.bottomAnchor, constant: 8)
        maxTemperatureLabel.widthAnchor(constant: 50)
        maxTemperatureLabel.heightAnchor(constant: 25)
        maxTemperatureLabel.bottomAnchor(equalTo: bottomAnchor, constant: 16)
    }
    
    // MARK: - Configure cell
    func configureCell(
        weekdayString: String?,
        countryAndCityString: String?,
        currentWeatherImageString: String,
        maxTemperatureString: String?
    ) {
        weekdayLabel.text = weekdayString
        countryAndCityLabel.text = countryAndCityString
        currentWeatherImageView.image = UIImage(named: currentWeatherImageString)
        maxTemperatureLabel.text = maxTemperatureString
    }
    
}
