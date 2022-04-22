//
//  LocalViewController.swift
//  MainApp
//
//  Created by Vina Rianti on 20/4/22.
//

import UIKit

class LocalViewController: UIViewController {
    
    let charactersOdrManager: ResourceManager = ResourceManager(tag: "characters")
    
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
    
    private func setupViews() {
        title = "Local"
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
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        let localAssetLabel = makeLabels(text: "MainApp - always available")
        let londonImage = makeImageView(imageName: "london")!
        let sgImage = makeImageView(imageName: "singapore")!
        
        let releaseOdrButton = UIButton(type: .roundedRect)
        releaseOdrButton.setTitle("Release On-Demand Resources", for: .normal)
        releaseOdrButton.addTarget(self, action: #selector(handleRelease), for: .touchUpInside)
        
        let subviews = [localAssetLabel, londonImage, sgImage, releaseOdrButton]
        for v in subviews {
            stackView.addArrangedSubview(v)
        }
        
        NSLayoutConstraint.activate([
            londonImage.heightAnchor.constraint(lessThanOrEqualToConstant: 300),
            sgImage.heightAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
        
        let odrButton = UIBarButtonItem(title: "On-Demand", style: .plain, target: self, action: #selector(showOdrVC))
        navigationItem.rightBarButtonItem = odrButton
    }
    @objc func showOdrVC() {
        let odrVC = OnDemandViewController()
        odrVC.resourceManager = charactersOdrManager
        
        navigationController?.pushViewController(odrVC, animated: true)
    }
    
    @objc func handleRelease() {
        charactersOdrManager.purgeResource()
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

