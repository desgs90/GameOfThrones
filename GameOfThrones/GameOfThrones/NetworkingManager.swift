//
//  NetworkingManager.swift
//  GameOfThrones
//
//  Created by Diego Eduardo on 9/12/17.
//  Copyright © 2017 Diego Santiago. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate: class {
    
    func didGetInfo()
}

class NetworkingManger: NSObject {
    
    weak var delegate: NetworkManagerDelegate?
    fileprivate let baseURL = ""
    lazy var charDao = CharacterDao.instance
    
    public func getData(_ page: Int) {
        let pageString = String(describing: page)
        let stringUrl = "https://www.anapioficeandfire.com/api/characters?page=\(pageString)&pageSize=20"
        
        guard let url = URL(string: stringUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [[String:Any]] {
                        //ParseInfo
                        self.charDao.parseCharacers(jsonObject)
                        DispatchQueue.main.async {
                            self.delegate?.didGetInfo()
                        }
                    }
                } catch {
                    
                }
            }
        }
        task.resume()
        
    }
}
