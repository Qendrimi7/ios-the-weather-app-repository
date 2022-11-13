//
//  HomeController.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit
import Alamofire

class HomeController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource {

    // MARK: - Subviews
    private lazy var tableView: UITableView = {
        let tableView: UITableView

        tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: CGFloat.leastNonzeroMagnitude))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: CGFloat.leastNonzeroMagnitude))
        tableView.estimatedRowHeight = 44
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        tableView.register(
            CurrentWeatherTableViewCell.self,
            forCellReuseIdentifier: ControllerConstants.TableViewIdentifires.currentWeatherCell
        )
        return tableView
    }()
    
    private let spinnerView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Data
    private struct ControllerConstants {
        struct TableViewIdentifires {
            static let currentWeatherCell: String = "ControllerConstants.TableViewIdentifire.currentWeatherCell"
        }
        static let defaultTableViewRowHeight: CGFloat = 125
        
    }
    
    enum DataLoadingStatus {
        case loading(Bool)
        case loaded(Error?)
    }
    
    private var coordinator: HomeCoordinator!
    private var viewModel: HomeViewModel = HomeViewModel()
    private var dataLoadingStatus: DataLoadingStatus = .loaded(nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupNavigationAppearance()
        setupCoordinator()
        setupViews()
        Task {
            let getHomeContentResponse = await getHomeContent(
                alamofireParametersConvertible:
                    APIRequestObject.GetWeatherData(
                        lat: 42.6026,
                        lon: 20.9030,
                        appid: "7113867439c2da0f9bdce128003d8e02"
                    ),
                otherHeaders: [:]
            )
            
            switch getHomeContentResponse {
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.dataLoadingStatus = .loaded(error)
                    strongSelf.updateViews()
                }
                
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.dataLoadingStatus = .loaded(nil)
                    strongSelf.viewModel.appendSections(response: [response])
                    strongSelf.updateViews()
                }
            }
        }
    }
    
    // MARK: - Setup coordinator
    private func setupCoordinator() {
        guard let navigationController = navigationController else { return }
        coordinator = HomeCoordinator(presenter: navigationController)
    }
    
    // MARK: - Setup Navigation Appearance
    private func setupNavigationAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    // MARK: - Setup views
    private func setupViews() {
        title = "superb"
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView
            .leadingAnchor(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            .topAnchor(equalTo: view.safeAreaLayoutGuide.topAnchor)
            .trailingAnchor(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            .bottomAnchor(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        tableView.delegate = self
        tableView.dataSource = self
        setupBackButton()
        
        view.addSubview(spinnerView)
        spinnerView
            .leadingAnchor(equalTo: view.leadingAnchor)
            .topAnchor(equalTo: view.topAnchor)
            .trailingAnchor(equalTo: view.trailingAnchor)
            .bottomAnchor(equalTo: view.bottomAnchor)
    }
    
    // MARK: - Update views
    private func updateViews() {
        switch dataLoadingStatus {
        case .loading(let isFirstTime):
            if isFirstTime {
                spinnerView.startAnimating()
            }
            tableView.setEmptyView(nil)
            
        case .loaded(let error):
            spinnerView.stopAnimating()
            tableView.setEmptyView(nil)
            
            if let error = error {
                switch error {
                case URLError.Code.notConnectedToInternet:
                    tableView.setEmptyView(EmptyStateView(
                        image: nil,
                        title: "Internet Connection",
                        description: NSAttributedString(string: "Not connected to Internet"))
                    )
                    
                default:
                    tableView.setEmptyView(EmptyStateView(
                        image: nil,
                        title: "Error",
                        description: NSAttributedString(string: error.localizedDescription))
                    )
                }
                
            }
        }
        tableView.reloadData()
    }
    
    private func getHomeContent(
        alamofireParametersConvertible: AlamofireParametersConvertible,
        otherHeaders: HTTPHeaders
    ) async -> Swift.Result<APIResponseObject.WeatherDataResponse, Error> {
        do {
            return try await withCheckedThrowingContinuation { continuation in
                HomeAPI.getHomeContent(
                    alamofireParametersConvertible: alamofireParametersConvertible,
                    otherHeaders: otherHeaders
                ) { (dataResponse, result) in
                    switch result {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                        
                    case .success(let responseModel):
                        continuation.resume(returning: .success(responseModel))
                    }
                }
            }
            
        } catch {
            return .failure(error)
        }
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionsCount()
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ControllerConstants.TableViewIdentifires.currentWeatherCell,
            for: indexPath
        ) as! CurrentWeatherTableViewCell

        let model = viewModel.section(at: indexPath.section)
        cell.configureCell(
            weekdayString: viewModel.getDayName(interval: model.dt),
            countryAndCityString: model.name,
            currentWeatherImageString: viewModel.getImageTemperatureName(model: model.weather?.first),
            maxTemperatureString: viewModel.getTempMax(model: model.main)
        )
        
       return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return ControllerConstants.defaultTableViewRowHeight
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
    }
    
}
