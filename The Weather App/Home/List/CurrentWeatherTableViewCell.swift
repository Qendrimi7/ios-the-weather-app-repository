//
//  CurrentWeatherTableViewCell.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit

protocol CurrentWeatherTableViewCellDelegate: AnyObject {
    
    func currentWeatherTableViewCell(
        _ cell: CurrentWeatherTableViewCell,
        didSelectItem model: APIResponseObject.WeatherDataResponse
    )
    
}

class CurrentWeatherTableViewCell: UITableViewCell {

    // MARK: - Subviews
    private let weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "OpenSans-Bold", size: 35)
        label.textColor = Theme.titleLabelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countryAndCityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "OpenSans-Semibold", size: 16)
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
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "OpenSans-Semibold", size: 18)
        label.textColor = Theme.secondaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var model: APIResponseObject.WeatherDataResponse?
    weak var delegate: CurrentWeatherTableViewCellDelegate?
    
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
        weekdayLabel.leadingAnchor(equalTo: leadingAnchor, constant: 20)
        weekdayLabel.heightAnchor(constant: 50)
        
        contentView.addSubview(countryAndCityLabel)
        countryAndCityLabel.leadingAnchor(equalTo: leadingAnchor, constant: 20)
        countryAndCityLabel.topAnchor(equalTo: weekdayLabel.bottomAnchor, constant: 10)
        countryAndCityLabel.heightAnchor(constant: 25)

        contentView.addSubview(currentWeatherImageView)
        weekdayLabel.centerVertical(equalTo: currentWeatherImageView.centerYAnchor)
        currentWeatherImageView.trailingAnchor(equalTo: trailingAnchor, constant: 30)
        currentWeatherImageView.topAnchor(equalTo: topAnchor, constant: 20)
        currentWeatherImageView.widthAnchor(constant: 30)
        currentWeatherImageView.heightAnchor(constant: 30)
        
        contentView.addSubview(maxTemperatureLabel)
        maxTemperatureLabel.topAnchor(equalTo: currentWeatherImageView.bottomAnchor, constant: 4)
        maxTemperatureLabel.widthAnchor(constant: 50)
        maxTemperatureLabel.heightAnchor(constant: 25)
        maxTemperatureLabel.centerHorizontal(equalTo: currentWeatherImageView.centerXAnchor)
        maxTemperatureLabel.bottomAnchor(equalTo: bottomAnchor, constant: 16)
        countryAndCityLabel.centerVertical(equalTo: maxTemperatureLabel.centerYAnchor)
        
        let tapGesture = UITapGestureRecognizer(target: self, action:  #selector(presentModal))
        currentWeatherImageView.addGestureRecognizer(tapGesture)
        selectionStyle = .none
    }
    
    // MARK: - Configure cell
    func configureCell(
        weatherDataResponse: APIResponseObject.WeatherDataResponse,
        weekdayString: String?,
        countryAndCityString: String?,
        currentWeatherImageString: String,
        maxTemperatureString: String?
    ) {
        model = weatherDataResponse
        weekdayLabel.text = weekdayString
        countryAndCityLabel.text = countryAndCityString
        currentWeatherImageView.image = UIImage(named: currentWeatherImageString)
        maxTemperatureLabel.text = maxTemperatureString
    }
    
    @objc
    private func presentModal(sender : UITapGestureRecognizer)  {
        guard let unwrappedModel = model else { return }
        delegate?.currentWeatherTableViewCell(self, didSelectItem: unwrappedModel)
    }
    
}
