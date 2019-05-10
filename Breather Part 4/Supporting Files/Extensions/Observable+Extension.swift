//
//  Observable+Extension.swift
//  Breather
//
//  Created by Alexandros Baramilis on 10/05/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation
import RxSwift

extension Observable where Element: Any {
    func startLoading(loadingSubject: PublishSubject<Bool>) -> Observable<Element> {
        return self.do(onNext: { _ in
            loadingSubject.onNext(true)
        })
    }

    func stopLoading(loadingSubject: PublishSubject<Bool>) -> Observable<Element> {
        return self.do(onNext: { _ in
            loadingSubject.onNext(false)
        })
    }
}
