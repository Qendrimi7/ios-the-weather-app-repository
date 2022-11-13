//
//  ModalWeatherController.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 13.11.22.
//

import UIKit

class ModalWeatherController:
    UIViewController,
    UIViewControllerTransitioningDelegate {
    
    // MARK: - Subviews
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "OpenSans-Semibold", size: 70)
        label.textColor = Theme.titleLabelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countryAndCityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "OpenSans-Semibold", size: 20)
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
    
    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.primaryColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let model: APIResponseObject.WeatherDataResponse
    
    // MARK: - Lifecycle
    init(_ model: APIResponseObject.WeatherDataResponse) {
      self.model = model
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        modalPresentationStyle = .custom
        transitioningDelegate = self
        setupViews()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(maxTemperatureLabel)
        maxTemperatureLabel
            .leadingAnchor(equalTo: view.leadingAnchor, constant: 25)
            .topAnchor(equalTo: view.topAnchor, constant: 25)
            .trailingAnchor(equalTo: view.centerXAnchor)
            .heightAnchor(constant: 70)
        
        view.addSubview(countryAndCityLabel)
        countryAndCityLabel
            .leadingAnchor(equalTo: view.leadingAnchor, constant: 25)
            .topAnchor(equalTo: maxTemperatureLabel.bottomAnchor, constant: 10)
            .trailingAnchor(equalTo: view.centerXAnchor)
            .heightAnchor(constant: 25)
        
        view.addSubview(currentWeatherImageView)
        currentWeatherImageView.trailingAnchor(equalTo: view.trailingAnchor, constant: 25)
                                .centerVertical(equalTo: maxTemperatureLabel.centerYAnchor, constant: 10)
                                .widthAnchor(constant: 75)
                                .heightAnchor(constant: 75)
        
        view.addSubview(seperatorView)
        seperatorView
            .leadingAnchor(equalTo: view.leadingAnchor, constant: 25)
            .topAnchor(equalTo: countryAndCityLabel.bottomAnchor, constant: 10)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: 25)
            .heightAnchor(constant: 0.5)
    
        
        maxTemperatureLabel.text = getTempMax(model: model.main)
        countryAndCityLabel.text = model.name
        currentWeatherImageView.image = UIImage(named: getImageTemperatureName(model: model.weather?.first))
    }
    
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        
        let controller: UISheetPresentationController = .init(presentedViewController: presented, presenting: presenting)
        let modalViewDente: UISheetPresentationController.Detent = ._detent(withIdentifier: "ModalViewDente", constant: 300.0)
        
        controller.detents = [modalViewDente]
        controller.prefersGrabberVisible = true
        
        return controller
    }
    
    func getTempMax(model: APIResponseObject.Main?) -> String? {
        guard let unwrappedModel = model,
              let unwrappedTempMax = unwrappedModel.tempMax else { return nil }
        
        return "\(Int(unwrappedTempMax - 273.15))°C"
    }
    
    func getImageTemperatureName(model: APIResponseObject.Weather?) -> String {
        guard let unwrappedModel = model,
              let unwrappedID = unwrappedModel.id else { return "default_icone" }
        
        switch unwrappedID {
        case 804:
            //overcast clouds
            return "cloudy"
        case 803:
            //broken clouds
            return "cloudy"
        case 802:
            //scattered clouds
            return "partly_cloudy"
        case 801:
            //few clouds
            return "partly_cloudy"
        case 800:
            //clear sky
            return "sunny"
        default:
            return "default_icone"
            
        }
    }
}
