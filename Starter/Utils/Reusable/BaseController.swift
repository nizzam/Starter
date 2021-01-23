//
//  BaseController.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarLayout()
    }
}

//  MARK:- Private Setup Navigation Bar
extension BaseController {
    
    /// Navigation bar set to be transparent
    private func setupNavBarLayout() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    /// Navigation bar - `Not Logged In`
    private func setupNotLoggedInHeaderView() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePresentLoginVC))
//        containerView.isUserInteractionEnabled = true
//        containerView.addGestureRecognizer(tapGesture)

        let icon = UIImageView(image: nil)
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Log in \nTo make appointment"
        title.textColor = .white
        //title.font = Fonts.navigationFont
        title.numberOfLines = 0

        containerView.addSubview(icon)
        containerView.addSubview(title)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: view.frame.width - 50),
            containerView.heightAnchor.constraint(equalToConstant: 40),
            
            icon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            icon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 40),
            icon.heightAnchor.constraint(equalToConstant: 40),
            
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8),
            title.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
        
        navigationItem.titleView = containerView
    }
    
    /// Navigation bar - `Logged In`
    private func setupLoggedInHeaderView(_ showDrawer: Bool) {
        navigationItem.titleView = nil
        
//        navigationItem.leftBarButtonItem = showDrawer ? UIBarButtonItem(image: #imageLiteral(resourceName: "icon_menu"), style: .plain, target: self, action: #selector(handleDrawer)) : nil
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: user.mobile, style: .plain, target: self, action: #selector(handleProfile))
        
//        let containerView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.backgroundColor = .clear
//        containerView.isUserInteractionEnabled = true
//
//        let icon = UIImageView(image: #imageLiteral(resourceName: "icon_menu"))
//        icon.translatesAutoresizingMaskIntoConstraints = false
//        icon.isUserInteractionEnabled = true
//        let iconGesture = UITapGestureRecognizer(target: self, action: #selector(handleDrawer))
//        icon.addGestureRecognizer(iconGesture)
//
//        let title = UILabel()
//        title.translatesAutoresizingMaskIntoConstraints = false
//        title.isUserInteractionEnabled = true
//        let titleGesture = UITapGestureRecognizer(target: self, action: #selector(handleProfile))
//        title.addGestureRecognizer(titleGesture)
//        title.text = "Roman Duterte"
//        title.textColor = .white
//        title.numberOfLines = 0
//
//        containerView.addSubview(icon)
//        containerView.addSubview(title)
//
//        NSLayoutConstraint.activate([
//            containerView.widthAnchor.constraint(equalToConstant: view.frame.width - 50),
//            containerView.heightAnchor.constraint(equalToConstant: 40),
//
//            icon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: -10),
//            icon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            icon.widthAnchor.constraint(equalToConstant: 40),
//            icon.heightAnchor.constraint(equalToConstant: 40),
//
//            title.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 8),
//            title.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//        ])
        
//        navigationItem.titleView = containerView
    }
    
    /// Header view is layer for navigation bar (is transparent), ease to changing color
    /// Advise to load the function at *viewSafeAreaInsetsDidChange* to get safeAreaInsets value
    func setupHeaderView(color: UIColor = UIColor.navbar,
                         currentView: UIView,
                         titleText: NSMutableAttributedString = .init()) {
        
        let top = view.safeAreaInsets.top
        
        let header = UIView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = color
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.attributedText = titleText
        title.numberOfLines = 0
        
        header.addSubview(title)
        currentView.addSubview(header)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: currentView.topAnchor),
            header.leadingAnchor.constraint(equalTo: currentView.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: currentView.trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: top),
            
            title.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10),
            title.centerYAnchor.constraint(equalTo: header.centerYAnchor),
        ])
        
        UIView.animate(withDuration: 0.1) {
            currentView.layoutIfNeeded()
        }
    }
}

//  MARK:- Show Loading
extension BaseController {
    
    /// Show loading without message
    func showLoading() {
        //showLoadingView(nil)
    }
    
    /// Show loading with message
    func showLoadingWithMessage(message: String) {
        //showLoadingView(message)
    }
    
    /// Hide loading
    func hideLoading() {
        //dismissLoadingView()
    }
    
    /// End editing
    func endEditing() {
        view.endEditing(true)
    }
}

//  MARK:- Alert Controller
extension BaseController {
    
    func presentAlert(title: String?, message: String, actions: UIAlertAction..., animated: Bool = true) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        self.present(alert, animated: animated, completion: nil)
    }
}

//  MARK:- Reload Table
extension BaseController {
    
    /// Reload a tableView
    func handleReloadTableView(tableView: UITableView) {
        tableView.reloadData()
    }
    
    /// Reload a particular cell without animation
    func handleReloadTableWithoutAnimation(tableView: UITableView, indexPath: IndexPath) {
        tableView.reloadWithoutAnimation(indexPath)
    }

    /// Reload a particular cell with animation
    func handleReloadTableRows(tableView: UITableView, at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
    
    /// Decorate reload
    func handleDecorateReload(tableView: UITableView, dataSource: ListDataSource?) {
        tableView.beginUpdates()
        for cell in tableView.visibleCells {
            if let indexPath = tableView.indexPath(for: cell) {
                dataSource?.decorate(cell as! CellPresentable, at: indexPath)
            }
        }
        tableView.endUpdates()
    }
}
