//
//  ViewController.swift
//  GameOfThrones
//
//  Created by Diego Eduardo on 9/12/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- IBOUtlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    
    //MARK:- vars
    lazy var charDao = CharacterDao.instance
    var charData = [Character]()
    var networkManager = NetworkingManger()
    var pages = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        networkManager.delegate = self
        tableView.delegate = self
        loadData(pages)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Methods
    
    fileprivate func updatetable() {
        self.tableView.reloadData()
    }
    
    fileprivate func loadData(_ pages: Int) {
        showLoadinView()
        networkManager.getData(pages)
    }
    
    fileprivate func showLoadinView() {
        UIView.animate(withDuration: 1.0, animations: {
            self.loadingView.frame.origin.y -= 50
        }, completion: nil)
    }
    
    
    fileprivate func hideLoadingIndicator() {
        UIView.animate(withDuration: 0) {
            self.loadingView.frame.origin.y += 50
        }
    }
    
}

//MARK:- UitableView delegate and Data source

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let character = charData[indexPath.row]
        cell.textLabel?.text = character.displayName()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title: UILabel = UILabel()
        
        title.textColor = UIColor.darkGray
        title.backgroundColor = UIColor.groupTableViewBackground
        title.font = UIFont.systemFont(ofSize: 14)
        title.text = "    Game Of Thrones characters"
        return title
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastPage = (pages * 19)
        if indexPath.row == lastPage {
            pages += 1
            loadData(pages)
        }
    }
}

extension ViewController: NetworkManagerDelegate {

    //Loading view only appears while the app is loading the data, if the device has a fast/good internet conenction it loads the data very fast and the user doesn't need to see the loading screen 
    func didGetInfo() {
        self.charData = charDao.getAllCharacters()
        self.updatetable()
        hideLoadingIndicator()
    }
}
