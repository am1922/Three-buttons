//
//  ViewController.swift
//  Three buttons
//
//  Created by Артем Михайлов on 04.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var animation: UIViewPropertyAnimator?
    
    lazy var button1 = createButton(with: "First Button")
    lazy var button2 = createButton(with: "Second Medium Button")
    lazy var button3 = createButton(with: "Third", action: button3Action)
    
    lazy var button3Action = UIAction { [weak self] _ in
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemBackground
        self?.present(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        
        layout()
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 8),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 8),
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func createButton(with title: String, action: UIAction? = nil) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        
        configuration.title = title
        configuration.image = UIImage(systemName: "arrow.forward.circle.fill")
        configuration.imagePadding = 8
        configuration.imagePlacement = .trailing
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let action {
            button.addAction(action, for: .touchUpInside)
        }
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
        button.addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)
        
        return button
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        animation?.stopAnimation(true)
        
        animation = UIViewPropertyAnimator(duration: 0.2, dampingRatio: 0.8) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        animation?.startAnimation()
    }
    
    @objc func buttonReleased(_ sender: UIButton) {
        animation?.stopAnimation(true)
        
        let decreaseAnimation = UIViewPropertyAnimator(duration: 0.2, dampingRatio: 0.8) {
            sender.transform = .identity
        }
        
        decreaseAnimation.startAnimation()
    }
}
