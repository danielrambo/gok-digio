//
//  HomeView.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import UIKit

final class HomeView: CustomViewController {
    
    // MARK: Init
    
    init(viewModel: HomeViewModel) {
        super.init()
        
        self.viewModel = viewModel
    }
    
    required public init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Property
    
    private var viewModel: HomeViewModel!
    private var stackViewContainer: UIStackView!
}

// MARK: - Public Methods

extension HomeView {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObserver()
        setupInitial()
    }
}

// MARK: - Layout

private extension HomeView {
    func setupInitial() {
        let stackView = buildMainStackView(scrollViewEnabled: true, padding: .bottom64)
        stackView.axis = .vertical
        stackView.spacing = 0.0
        
        setupTitle(in: stackView)
        self.stackViewContainer = stackView
        viewModel.send(in: .viewDidApper)
    }
    
    func setupTitle(in stackView: UIStackView) {
        let labelTitle = UILabel()
        labelTitle.font = UIFont.boldSystemFont(ofSize: 16.0)
        labelTitle.text = .helloUser
        labelTitle.textColor = UIColor(hexString: "#707070")
        
        let viewContainer = UIView()
        viewContainer.embed(newView: labelTitle, padding: .top16h16)
        stackView.addArrangedSubview(viewContainer)
    }
    
    func setupCarouselSpotlight(in stackView: UIStackView, images: [UIImage]) {
        let carouselStackViewSpotlight = UIStackView()
        carouselStackViewSpotlight.axis = .horizontal
        carouselStackViewSpotlight.clipsToBounds = false
        carouselStackViewSpotlight.spacing = 10.0
        
        for item in images {
            let stackViewContainer = UIStackView()
            stackViewContainer.axis = .vertical
            stackViewContainer.spacing = 0.0
            
            let imageView = UIImageView(image: item)
            imageView.contentMode = .scaleAspectFit
            imageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
            imageView.layoutIfNeeded()
            imageView.layer.cornerRadius = 40.0
            imageView.layer.masksToBounds = true
            stackViewContainer.addArrangedSubview(imageView)
            
            let width = UIScreen.main.bounds.width - 32
            let viewContainer = UIView()
            viewContainer.embed(newView: stackViewContainer)
            
            viewContainer.widthAnchor.constraint(equalToConstant: width).isActive = true
            carouselStackViewSpotlight.addArrangedSubview(viewContainer)
        }

        let scrollViewSpotlight = CustomScroolView()
        scrollViewSpotlight.isPagingEnabled = true
        scrollViewSpotlight.showsHorizontalScrollIndicator = false
        scrollViewSpotlight.showsVerticalScrollIndicator = false
        scrollViewSpotlight.clipsToBounds = false
        scrollViewSpotlight.set(scrollDirection: .horizontal)
        scrollViewSpotlight.embed(newView: carouselStackViewSpotlight)
        
        let content = UIView()
        content.embed(newView: scrollViewSpotlight, padding: .all16)
        content.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        stackView.addArrangedSubview(content)
    }
    
    func setupCash(in stackView: UIStackView, image: UIImage?) {
        let tagParser = TagParser(string: .digioCash, color: UIColor(hexString: "#707070"))
        
        let labelTitle = UILabel()
        labelTitle.font = UIFont.boldSystemFont(ofSize: 20.0)
        labelTitle.attributedText = tagParser.attributedString
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        imageView.layoutIfNeeded()
        imageView.layer.cornerRadius = 20.0
        imageView.layer.masksToBounds = true
        
        let stackViewVertical = UIStackView()
        stackViewVertical.axis = .vertical
        stackViewVertical.spacing = 16.0
        stackViewVertical.addArrangedSubview(labelTitle)
        stackViewVertical.addArrangedSubview(imageView)
        
        let content = UIView()
        content.embed(newView: stackViewVertical, padding: .v32h16)
        stackView.addArrangedSubview(content)
    }
    
    func setupCarouselProduct(in stackView: UIStackView, images: [UIImage]) {
        let carouselStackViewProduct = UIStackView()
        carouselStackViewProduct.axis = .horizontal
        carouselStackViewProduct.clipsToBounds = false
        carouselStackViewProduct.spacing = 10.0
        
        for item in images {
            let stackViewContainer = UIStackView()
            stackViewContainer.axis = .vertical
            stackViewContainer.spacing = 0.0
            
            let imageView = UIImageView(image: item)
            imageView.contentMode = .scaleAspectFit
            imageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            stackViewContainer.addArrangedSubview(imageView)
            
            let viewContainer = UIView()
            viewContainer.backgroundColor = .white
            viewContainer.layer.cornerRadius = 20.0
            viewContainer.embed(newView: stackViewContainer, padding: .all16)
            
            carouselStackViewProduct.addArrangedSubview(viewContainer)
        }

        let scrollViewProduct = CustomScroolView()
        scrollViewProduct.isPagingEnabled = true
        scrollViewProduct.showsHorizontalScrollIndicator = false
        scrollViewProduct.showsVerticalScrollIndicator = false
        scrollViewProduct.clipsToBounds = false
        scrollViewProduct.set(scrollDirection: .horizontal)
        scrollViewProduct.embed(newView: carouselStackViewProduct)
        
        let content = UIView()
        content.embed(newView: scrollViewProduct, padding: .left32Right16)
        content.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        let labelTitle = UILabel()
        labelTitle.font = UIFont.boldSystemFont(ofSize: 20.0)
        labelTitle.text = .product
        labelTitle.textColor = UIColor(hexString: "#005779")
        
        let containerLabel = UIView()
        containerLabel.embed(newView: labelTitle, padding: .h16)
        
        let stackViewVertical = UIStackView()
        stackViewVertical.axis = .vertical
        stackViewVertical.spacing = 16.0
        stackViewVertical.addArrangedSubview(containerLabel)
        stackViewVertical.addArrangedSubview(content)
        
        stackView.addArrangedSubview(stackViewVertical)
    }
}


// MARK: - ViewModel

private extension HomeView {
    func setupObserver() {
        viewModel.setObservable { state in
            switch state {
            case .isLoading:
                self.toggleLoading(true)
                
            case .modalError(let error):
                self.toggleLoading(false)
                self.presentAlert(error: error)
                
            case .updateValues(let values):
                self.toggleLoading(false)
                self.setupCarouselSpotlight(in: self.stackViewContainer, images: values.spotlight)
                self.setupCash(in: self.stackViewContainer, image: values.cash)
                self.setupCarouselProduct(in: self.stackViewContainer, images: values.products)
            }
        }
    }
}

// MARK: - Strings

fileprivate extension String {
    static let helloUser = "Olá, Maria"
    static let digioCash = "<blue>digio</blue> Cash"
    static let product = "Produtos"
}
