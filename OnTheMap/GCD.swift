//
//  GCD.swift
//  OnTheMap
//
//  Created by Frank Giarratani on 2017/12/16.
//  Copyright © 2017 Frank Giarratani. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
