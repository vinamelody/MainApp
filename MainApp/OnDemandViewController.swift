//
//  OnDemandViewController.swift
//  MainApp
//
//  Created by Vina Rianti on 21/4/22.
//

import UIKit

class OnDemandViewController: UIViewController {
    
    var resourceManager: ResourceManager?
    
    let resourceRequest: NSBundleResourceRequest = NSBundleResourceRequest(tags: Set(["characters", "heroes"]))
    var scrollView: UIScrollView!
    var stackView: UIStackView!
    var topImageView: UIImageView!
    var bottomImageView: UIImageView!
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        preloadResourceWithTag()
    }

    func preloadResourceWithTag() {
        
        guard let resourceManager = resourceManager else {
            return
        }

        resourceManager.requestResourceWith(onSuccess: { [weak self] in
            DispatchQueue.main.async {
                self?.showCharacters()
            }
        }, onFailure: { error in
            print("Resource not available: \(error)")
        })
    }
    
    private func showCharacters() {
        guard let thorImage = UIImage(named: "thor"), let walleImage = UIImage(named: "walle") else {
            return
        }
        topImageView.image = thorImage
        bottomImageView.image = walleImage
    }
    
    private func setupViews() {
        title = "On-Demand"
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
        stackView.backgroundColor = .orange
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

        
        let onDemandLabel = makeLabels(text: "MainApp - on demand")
        topImageView = makeImageView(imageName: "placeholder")!
        bottomImageView = makeImageView(imageName: "placeholder")!
        
        let subviews = [onDemandLabel, topImageView, bottomImageView]
        for v in subviews {
            stackView.addArrangedSubview(v ?? UIView())
        }
        
        NSLayoutConstraint.activate([
            topImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 300),
            bottomImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
    }
    
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
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }
}
