//
//  ListInteractor.swift
//  DesafioCielo
//
//  Created by Gustavo Melki Leal on 19/09/2018.
//  Copyright (c) 2018 Gustavo Melki Leal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RxSwift

protocol ListBusinessLogic {
  func getCharacters(request: List.Request)
}

protocol ListDataStore {
  //var name: String { get set }
}

class ListInteractor: ListBusinessLogic, ListDataStore {
  var presenter: ListPresentationLogic?
  let disposeBag = DisposeBag()
  
  // MARK: Do something
  
  func getCharacters(request: List.Request) {
    
    MarvelManager.getCharactersList().subscribe(onNext: { (result) in
      if let result =  result.data?.results {
        let response = List.Response(characters: result)
        self.presenter?.presentCharacters(response: response)
      }
      
    }, onError: { (error) in
      let error = List.Error(errorDescription: error.localizedDescription)
      self.presenter?.presentError(errorDescription: error)
      print(error)
    }, onCompleted: {
      print("onCompleted")
    }).disposed(by: disposeBag)

  }
}
