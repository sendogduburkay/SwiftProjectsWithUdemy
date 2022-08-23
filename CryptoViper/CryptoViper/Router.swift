//
//  Router.swift
//  CryptoViper
//
//  Created by Muhammed Burkay Şendoğdu on 23.08.2022.
//

import Foundation
import UIKit

//EntryPoint belirteceğiz
// Class,protocol
typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter{
    var entryPoint: EntryPoint? {get}
    static func startExecution() -> AnyRouter
    
}


class CryptoRouter: AnyRouter{
    
    var entryPoint: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
        
        var view: AnyView = CryptoViewController()
        var presenter: AnyPresenter = CryptoPresenter()
        var interactor: AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        router.entryPoint = view as? EntryPoint
        
        return router
    }
    

    
    
}
