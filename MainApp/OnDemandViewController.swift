//
//  OnDemandViewController.swift
//  MainApp
//
//  Created by Vina Rianti on 21/4/22.
//

import UIKit

class OnDemandViewController: UIViewController {
    let resourceRequest: NSBundleResourceRequest = NSBundleResourceRequest(tags: Set(["characters"]))
    var scrollView: UIScrollView!
    var stackView: UIStackView!
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func preloadResourceWithTag(tagArray: [String]) {
        resourceRequest.conditionallyBeginAccessingResources { [weak self] isAvailable in
            if isAvailable {
                DispatchQueue.main.async {
                    self?.showCharacters()
                }
            } else {
                self?.resourceRequest.beginAccessingResources(completionHandler: { error in
                    if let error = error {
                        print("Resource not available: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            self?.showCharacters()
                        }
                    }
                })
            }
        }
    }
    
    private func showCharacters() {
        
    }
    
    private func setupViews() {
        title = "ODR"
        view.backgroundColor = .white
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        scrollView.addSubview(contentView)
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.backgroundColor = .yellow
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])

        
        let localAssetLabel = makeLabels(text: "MainApp - always available")
        let thorImage = makeImageView(imageName: "dc")!
        let onDemandLabel = makeLabels(text: "MainApp - on demand")
        let walleImage = makeImageView(imageName: "dc")!
        
        let subviews = [localAssetLabel, thorImage, onDemandLabel, walleImage]
        for v in subviews {
            stackView.addArrangedSubview(v)
        }
        
        NSLayoutConstraint.activate([
            thorImage.heightAnchor.constraint(lessThanOrEqualToConstant: 300),
            walleImage.heightAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        scrollView.contentSize = view.frame.size
//    }
    
    private func makeLabels(text: String) -> UILabel {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.text = text
        return label
    }
    
    private func makeImageAsView(imageName: String) -> UIView {
        guard let image = UIImage(named: imageName) else {
            return UIView()
        }
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        return view
    }
    private func makeImageView(imageName: String) -> UIImageView? {
        guard let image = UIImage(named: imageName) else {
            return nil
        }
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
}
