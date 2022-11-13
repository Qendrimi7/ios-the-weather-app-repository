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
        let tableView = UITableView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.backgroundColor = Theme.appTintColor
        tableView.isUserInteractionEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        static let defaultTableViewRowHeight: CGFloat = 200
        
    }
    
    enum DataLoadingStatus {
        case loading(Bool)
        case loaded(Error?)
    }
    
    private var coordinator: HomeCoordinator!
    private var viewModel: HomeViewModel = HomeViewModel()
    
    // MARK: - Lifecycle
    deinit {
        operationQueue.cancelAllOperations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // MARK: - Setup
    private func setup() {
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
                break
                
            case .success(let response):
                print(response)
            }
        }
    }
    
    // MARK: - Setup coordinator
    private func setupCoordinator() {
        guard let navigationController = navigationController else { return }
        coordinator = HomeCoordinator(presenter: navigationController)
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
    }
    
    // MARK: - Update views
    private func updateViews() {
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
        return 1
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 1
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
       return UITableViewCell()
        
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
