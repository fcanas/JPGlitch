//
//  Loading.swift
//  JPGlitch
//
//  Created by Fabian Canas on 8/20/15.
//  Copyright © 2015 Fabian Canas. All rights reserved.
//

import Foundation

func dataForURL(url :NSURL) -> Data? {
    if let data = NSData(contentsOfURL: url) {
        return Data(data: data)
    }
    return nil
}

func segmentsForData(data: Data) -> [JFIFSegment] {
    var segments = Array<JFIFSegment>()
    let first = JFIFSegment(data: data)!
    
    segments.append(first)
    
    var next :JFIFSegment?
    repeat {
        next = segments.last?.nextSegment
        if let n = next {
//            print(n)
            segments.append(n)
        }
    } while next != nil
    return segments
}

/*
////: Playground - noun: a place where people can play
//
import Cocoa

let g1p = NSBundle.mainBundle().URLForImageResource("s")!
let g2p = NSBundle.mainBundle().URLForImageResource("g1")!

let g1d = NSData(contentsOfURL: g1p)!
let jpgD1 = Data(data: g1d)

let g2d = NSData(contentsOfURL: g2p)!
let jpgD2 = Data(data: g2d)

//let (small, big) = jpgD1.length > jpgD2.length ? (jpgD2, jpgD1) : (jpgD1, jpgD2)
//
//small.length
//big.length
//
//var injectionPoint = UnsafeMutablePointer<UInt8>(small.bytes.advancedBy(small.length / 2))
//var readStart = 258
//var readPoint = big.bytes.advancedBy(readStart)
//for var r :Int = 0; r < 148; r = r + 15 {
//    injectionPoint[r] = readPoint[r]
//}
//
//NSImage(data:NSData(bytes: small.bytes, length: small.length))

//

//
var segments = Array<JFIFSegment>()
//
var first = JFIFSegment(data: jpgD1)!

segments.append(first)

repeat {
var next = segments.last.nextSegment
if let next = next {
segments.append(next)
}
} while next != nil

var next = JFIFSegment(data: first.next!)!
var n = JFIFSegment(data: next.next!)!

var o = JFIFSegment(data: n.next!)
o?.type



//
//if let first = first {
//    segments.append(first)
//    1
//    var cc = true
//    while cc {
//        if let next = segments.last?.next, let segment = JFIFSegment(data: next) {
//            segments.count
//            segments.append(segment)
//            segments.count
//        } else {
//            cc = false
//        }
//    }
//    5
//}
//
//segments
//segments.count
//segments[0].type
//segments[1].type
//segments[1].next?.bytes[0]
//
//
//
//func readChunk(jpegBytes: Data) -> NSData {
//
//    return NSData()
//}
//
//NSImage(data: g1d)
//
//

*/