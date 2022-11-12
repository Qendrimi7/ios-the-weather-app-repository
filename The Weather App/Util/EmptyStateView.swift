//
//  EmptyStateView.swift
//  The Weather App
//
//  Created by Qendrim Mjeku on 12.11.22.
//

import UIKit

class EmptyStateView: UIView {
    
    // MARK: - Subviews
    private let contentEmptyView: UIView = {
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.isUserInteractionEnabled = true
        emptyView.backgroundColor = UIColor.clear
        return emptyView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = true
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.lightGray
        textView.textAlignment = .center
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    private var image: UIImage?
    private var title: String?
    private var emptyStateDescription: NSAttributedString?
    
    //MARK: - Lifecycle
    @available(*, unavailable)
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(
        image: UIImage?,
        title: String?,
        description: NSAttributedString?
    ) {
        self.image = image
        self.title = title
        self.emptyStateDescription = description
        super.init(frame: .zero)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        addSubview(contentEmptyView)
        layoutContentView()
        
        setupContent(
            image: image,
            title: title,
            description: emptyStateDescription
        )
        
        if let _ = image,
           let _ = title,
           let _ = emptyStateDescription {
            contentEmptyView.addSubview(imageView)
            contentEmptyView.addSubview(titleLabel)
            contentEmptyView.addSubview(descriptionTextView)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentEmptyView.topAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 250),
                imageView.centerXAnchor.constraint(equalTo: contentEmptyView.centerXAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 250),
                
                titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
                titleLabel.leadingAnchor.constraint(equalTo: contentEmptyView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: contentEmptyView.trailingAnchor),
                
                descriptionTextView.leadingAnchor.constraint(equalTo: contentEmptyView.leadingAnchor),
                descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                descriptionTextView.trailingAnchor.constraint(equalTo: contentEmptyView.trailingAnchor),
                descriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
                descriptionTextView.bottomAnchor.constraint(equalTo: contentEmptyView.bottomAnchor)
            ])
            
        } else if image == nil,
                  let _ = title,
                  let _ = emptyStateDescription {
            
            contentEmptyView.addSubview(titleLabel)
            contentEmptyView.addSubview(descriptionTextView)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: contentEmptyView.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: contentEmptyView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: contentEmptyView.trailingAnchor),
                
                descriptionTextView.leadingAnchor.constraint(equalTo: contentEmptyView.leadingAnchor),
                descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                descriptionTextView.trailingAnchor.constraint(equalTo: contentEmptyView.trailingAnchor),
                descriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
                descriptionTextView.bottomAnchor.constraint(equalTo: contentEmptyView.bottomAnchor)
            ])
            
        } else if image == nil,
                  let _ = title,
                  emptyStateDescription == nil {
            
            contentEmptyView.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: contentEmptyView.topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: contentEmptyView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: contentEmptyView.trailingAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: contentEmptyView.bottomAnchor)
            ])
            
        } else if let _ = image,
                  title == nil,
                  let _ = emptyStateDescription {
            
            contentEmptyView.addSubview(imageView)
            contentEmptyView.addSubview(descriptionTextView)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentEmptyView.topAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 250),
                imageView.centerXAnchor.constraint(equalTo: contentEmptyView.centerXAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 250),
                
                descriptionTextView.leadingAnchor.constraint(equalTo: contentEmptyView.leadingAnchor),
                descriptionTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
                descriptionTextView.trailingAnchor.constraint(equalTo: contentEmptyView.trailingAnchor),
                descriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
                descriptionTextView.bottomAnchor.constraint(equalTo: contentEmptyView.bottomAnchor)
            ])
            
        } else if let _ = image,
                  let _ = title,
                  emptyStateDescription == nil {
            
            contentEmptyView.addSubview(imageView)
            contentEmptyView.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentEmptyView.topAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 250),
                imageView.centerXAnchor.constraint(equalTo: contentEmptyView.centerXAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 250),
                
                titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
                titleLabel.leadingAnchor.constraint(equalTo: contentEmptyView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: contentEmptyView.trailingAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: contentEmptyView.bottomAnchor)
            ])
        }
    }
    
    // MARK: - Layout
    private func layoutContentView() {
        NSLayoutConstraint.activate([
            contentEmptyView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            contentEmptyView.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor),
            contentEmptyView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            contentEmptyView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: contentEmptyView.bottomAnchor)
        ])
    }
    
    private func setupContent(
        image: UIImage?,
        title: String?,
        description: NSAttributedString?
    ) {
        imageView.image = image
        titleLabel.text = title
        descriptionTextView.attributedText = description
    }
}


