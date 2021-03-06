//
//  CustomViewController.swift
//  Example
//
//  Created by Hirohisa Kawasaki on 6/30/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import UIKit
import PageController

class CustomMenuCell: MenuCell {

    required init(frame: CGRect) {
        super.init(frame: frame)

//        contentInset = UIEdgeInsets(top: 0, left: 40, bottom: 1, right: 40)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        contentInset = UIEdgeInsets(top: 0, left: 40, bottom: 1, right: 40)
        configure()
    }
    
    func configure() {
    }

    override func updateData() {
        super.updateData()
        
        if selected {
            titleLabel.layer.cornerRadius = titleLabel.frame.height/2
            titleLabel.layer.borderColor = UIColor(red: 250/255, green: 175/255, blue: 72/255, alpha: 1).cgColor
            titleLabel.layer.borderWidth = 1.0
        }

        titleLabel.textColor = selected ? UIColor.black : UIColor.gray
    }
}

class CustomViewController: PageController {

    override func viewDidLoad() {
        super.viewDidLoad()
        menuBar.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        menuBar.registerClass(CustomMenuCell.self)
        delegate = self
        viewControllers = createViewControllers()
    }

}

extension CustomViewController {

    func createViewControllers() -> [UIViewController] {
        let names = [
            "favorites",
            "recents",
            "contacts",
            "history",
            "more",
            ]
        
        return names.map { name -> UIViewController in
            let viewController = ContentViewController()
            viewController.title = name
            return viewController
        }
    }
//
//    func createViewControllers() -> [UIViewController] {
//        let names = [
//            "Home",
//            "Innovation",
//            "Technology",
//            "Life",
//            "Bussiness",
//            "Economics",
//            "Financial",
//            "Market",
//        ]
//
//        let viewControllers = names.map { name -> ItemsCollectionViewController in
//            let viewController = ItemsCollectionViewController()
//            viewController.title = name
//            viewController.collectionView?.scrollsToTop = false
//            return viewController
//        }
//
//        viewControllers.first?.collectionView?.scrollsToTop = true
//        return viewControllers
//    }
}

extension CustomViewController: PageControllerDelegate {

    func pageController(_ pageController: PageController, didChangeVisibleController visibleViewController: UIViewController, fromViewController: UIViewController?) {
        print("now title is \(String(describing: pageController.visibleViewController?.title))")
        print("did change from \(String(describing: fromViewController?.title)) to \(String(describing: visibleViewController.title))")
        if pageController.visibleViewController == visibleViewController {
            print("visibleViewController is assigned pageController.visibleViewController")
        }

        if let viewController = fromViewController as? ItemsCollectionViewController  {
            viewController.collectionView?.scrollsToTop = false
        }
        if let viewController = visibleViewController as? ItemsCollectionViewController  {
            viewController.collectionView?.scrollsToTop = true
        }
    }
}
