//
//  HomeController.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit

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
    private lazy var operationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Get weather data"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
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
        getHomeContent()
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
    
    private func getHomeContent() {
        let operation = GetHomeContentOperation(apiRequestObject: APIRequestObject.GetWeatherData(
            lat: 42.6026,
            lon: 20.9030,
            appid: "7113867439c2da0f9bdce128003d8e02"
        ))
        
        var backgroundTask: UIBackgroundTaskIdentifier!
        
        backgroundTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            operation.cancel()
        })
        
        operation.completionBlock = {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            
            guard let result = operation.result else { return }
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.showAlertWithMessage(title: "Error", message: error.localizedDescription)
                }
                
            case .success(let model):
                DispatchQueue.main.async { [weak self] in
                    print(model)
                }
            }
        }
        
        operationQueue.addOperation(operation)
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
