//
//  SplashAnimationController.swift
//  The Weather App
//
//  Created by Qëndrim Mjeku on 12.11.22.
//

import UIKit
import Lottie

class SplashAnimationController: UIViewController {

    // MARK: - Subviews
    private let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView()
        animationView.backgroundBehavior = .forceFinish
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    // MARK: - Data
    private var coordinator: SplashAnimationCoordinator!
    private let animationName: String
    private var loopMode = LottieLoopMode.playOnce
    private var fromProgress: AnimationProgressTime = 0
    private var toProgress: AnimationProgressTime = 1
    
    // MARK: - Lifecycle
    init(_ animationName: String) {
      self.animationName = animationName
      super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Setup coordinator
    private func setupCoordinator() {
        guard let navigationController = navigationController else { return }
        coordinator = SplashAnimationCoordinator(presenter: navigationController)
    }
    
    // MARK: - Setup
    private func setup() {
        setupCoordinator()
        setupViews()
    }
    
    // MARK: - Setup views
    private func setupViews() {
        view.backgroundColor = Theme.launchBackgroundColor
        let animation = LottieAnimation.named(animationName)
        animationView.animation = animation
        
        view.addSubview(animationView)
        animationView
            .leadingAnchor(equalTo: view.leadingAnchor, constant: 50)
            .topAnchor(equalTo: view.topAnchor, constant: 50)
            .trailingAnchor(equalTo: view.trailingAnchor, constant: 50)
            .bottomAnchor(equalTo: view.bottomAnchor, constant: 50)
        
        playAnimation()
    }
    
    private func playAnimation() {
        animationView.play(
            fromProgress: fromProgress,
            toProgress: toProgress,
            loopMode: loopMode
        ) { [weak self] isCompleted in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async { [weak strongSelf] in
                guard let strongSelf = strongSelf else { return }
                strongSelf.coordinator.goToHomeController()
            }
        }
    }

}
