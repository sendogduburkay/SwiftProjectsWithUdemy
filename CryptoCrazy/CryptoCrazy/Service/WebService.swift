//
//  WebService.swift
//  CryptoCrazy
//
//  Created by Muhammed Burkay Şendoğdu on 21.08.2022.
//

import Foundation

class Webservice{
    /* escaping => */
    func downloadCurrencies(url: URL, completion: @escaping ([CryptoCurrency]?) -> ()){
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data {
                let cryptoList = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
                if let cryptoList = cryptoList{
                    completion(cryptoList)
                }
                
            }
        }.resume()
        
    }
    
}
