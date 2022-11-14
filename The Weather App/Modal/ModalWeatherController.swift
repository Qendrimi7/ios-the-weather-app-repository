//
//  ModalWeatherController.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 13.11.22.
//

import UIKit

class ModalWeatherController:
    UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UIScreen.main.bounds.width * 0.05
        layout.minimumInteritemSpacing = UIScreen.main.bounds.width * 0.05
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            ModalWeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: ControllerConstants.CollectionViewIdentifire.weatherCell
        )
        collectionView.backgroundColor = Theme.appTintColor
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = false
        collectionView.isUserInteractionEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Data
    private struct ControllerConstants {
        
        struct CollectionViewIdentifire {
            static let weatherCell: String = "CellConstants.CollectionViewIdentifire.weatherCell"
        }
        
        static var cellWidth: CGFloat = 68.5
        static let cellHeight: CGFloat = 150
        
        static let cellUIEdgeInsetsTop: CGFloat = 10
        static let cellUIEdgeInsetsLeft: CGFloat = ((UIScreen.main.bounds.width * 0.05) / 2.0)
        static let cellUIEdgeInsetsBottom: CGFloat = 10
        static let cellUIEdgeInsetsRight: CGFloat = ((UIScreen.main.bounds.width * 0.05) / 2.0)
    }
    
    private let model: APIResponseObject.WeatherDataResponse
    private var viewModel: ModalWeatherViewModel = ModalWeatherViewModel()
    
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
    
        view.addSubview(collectionView)
        collectionView
            .leadingAnchor(equalTo: view.leadingAnchor, constant: 20)
            .topAnchor(equalTo: seperatorView.bottomAnchor, constant: 10)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: 20)
            .heightAnchor(constant: 150)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        countryAndCityLabel.text = getCountryNameOrCity(model: model)
        if let unwrappedModeList = model.list?.first {
            maxTemperatureLabel.text = viewModel.getTempMax(model: unwrappedModeList)
            currentWeatherImageView.image = UIImage(named: viewModel.getImageTemperatureName(model: unwrappedModeList))
        }
        
        setupContent()
    }
    
    private func setupContent() {
        guard let unwrappedList = model.list else { return }
        
        var nextFourDaysWeather = unwrappedList.uniqueElements()
        nextFourDaysWeather.removeFirst()
    
        nextFourDaysWeather.forEach { item in
            viewModel.appendCollections(items: ModalWeatherModel(
                weekday: viewModel.getWeekDay(timeInterval: item.dt),
                currentWeatherImageName: viewModel.getImageTemperatureName(model: item),
                maxAndMinTemperature: viewModel.getTempMax(model: item)
            ))
        }
        updateViews()
    }
    
    private func updateViews() {
        collectionView.reloadData()
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
    
    func getCountryNameOrCity(model: APIResponseObject.WeatherDataResponse) -> String? {
        guard let unwrappedCity = model.city else { return nil }
        return unwrappedCity.name
    }
    
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.getNumberOfItemsInSection()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ControllerConstants.CollectionViewIdentifire.weatherCell,
            for: indexPath
        ) as! ModalWeatherCollectionViewCell
        
        let model = viewModel.getModel(at: indexPath.row)
        cell.configureCell(
            weekdayString: model.weekday,
            currentWeatherImageNameString: model.currentWeatherImageName,
            maxAndMinTemperatureString: model.maxAndMinTemperature
        )
    
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: ControllerConstants.cellWidth,
            height: ControllerConstants.cellHeight
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: ControllerConstants.cellUIEdgeInsetsTop,
            left: ControllerConstants.cellUIEdgeInsetsLeft,
            bottom: ControllerConstants.cellUIEdgeInsetsBottom,
            right: ControllerConstants.cellUIEdgeInsetsRight
        )
    }
    
}
