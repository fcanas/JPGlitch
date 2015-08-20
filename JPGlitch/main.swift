//
//  main.swift
//  JPGlitch
//
//  Created by Fabian Canas on 8/20/15.
//  Copyright © 2015 Fabian Canas. All rights reserved.
//

import Foundation

// no restart interval
//"/Users/fcanas/Desktop/883126.jpeg"

let d = dataForURL(NSURL(fileURLWithPath: "/Users/fcanas/Desktop/samgoat.jpeg"))!

let segments = segmentsForData(d)

print(segments)
