import Foundation

public struct Data {
    public var bytes :UnsafePointer<UInt8>
    public let length :Int
    public init(data: NSData) {
        bytes = UnsafePointer(data.bytes)
        length = data.length
    }
    public init(data: Data, offset: Int) {
        bytes = data.bytes.advancedBy(offset)
        length = data.length - offset
    }
}

public enum Marker :UInt8, CustomStringConvertible {
    case SOI  = 0xD8
    case APP0 = 0xE0
    case APP1 = 0xE1
    case APP2 = 0xE2
    case APP13 = 0xED
    case APP14 = 0xEE
    case SOS  = 0xDA
    case EOI  = 0xD9
    
    case SOF0 = 0xC0
    case SOF2 = 0xC2
    case DHT  = 0xC4
    case DQT  = 0xDB
    
    case DRI  = 0xDD
    case RST0 = 0xD0
    case RST1 = 0xD1
    case RST2 = 0xD2
    case RST3 = 0xD3
    case RST4 = 0xD4
    case RST5 = 0xD5
    case RST6 = 0xD6
    case RST7 = 0xD7
    
    case COM  = 0xFE
    
    public var description :String {
        get {
            switch self {
            case SOI:
                return "SOI"
            case APP0:
                return "APP0"
            case APP1:
                return "APP1"
            case APP2:
                return "APP2"
            case APP13:
                return "APP13"
            case APP14:
                return "APP14"
            case SOS:
                return "SOS"
            case EOI:
                return "EOI"
            case SOF0:
                return "SOF0"
            case SOF2:
                return "SOF2"
            case DHT:
                return "DHT"
            case DQT:
                return "DQT"
            case DRI:
                return "DRI"
            case RST0:
                return "RST"
            case RST1:
                return "RST"
            case RST2:
                return "RST"
            case RST3:
                return "RST"
            case RST4:
                return "RST"
            case RST5:
                return "RST"
            case RST6:
                return "RST"
            case RST7:
                return "RST"
            case COM:
                return "COM"
            }
        }
    }
}

public struct JFIFSegment :CustomStringConvertible {
    public let type :Marker
    public var bytes :UnsafePointer<UInt8>
    public let length :Int
    public let next :Data?
    
    var nextSegment :JFIFSegment? {
        get {
            if let n = self.next {
                return JFIFSegment(data: n)
            }
            return nil
        }
    }
    
    public init?(data: Data) {
        if data.bytes[0] != 0xFF {
            return nil
        }
        let jfif :Marker? = Marker(rawValue: data.bytes[1])
        if let jfif = jfif {
            type = jfif
            switch (jfif) {
            case .SOI:
                bytes = data.bytes.advancedBy(2)
                length = 0
                next = Data(data: data, offset: 2)
            case .APP0:
                bytes = data.bytes.advancedBy(4)
                // JFXX0
                let s1 = data.bytes[2]
                let s2 = data.bytes[3]
                length = Int(s1) * 256 + Int(s2) - 2
                next = Data(data: data, offset: 4 + length)
            case .APP1:
                bytes = data.bytes.advancedBy(4)
                // JFXX0
                let s1 = data.bytes[2]
                let s2 = data.bytes[3]
                length = Int(s1) * 256 + Int(s2) - 2
                next = Data(data: data, offset: 4 + length)
            case .APP2:
                bytes = data.bytes.advancedBy(4)
                // JFXX0
                let s1 = data.bytes[2]
                let s2 = data.bytes[3]
                length = Int(s1) * 256 + Int(s2) - 2
                next = Data(data: data, offset: 4 + length)
            case .APP13:
                bytes = data.bytes.advancedBy(4)
                // JFXX0
                let s1 = data.bytes[2]
                let s2 = data.bytes[3]
                length = Int(s1) * 256 + Int(s2) - 2
                next = Data(data: data, offset: 4 + length)
            case .APP14:
                bytes = data.bytes.advancedBy(4)
                // JFXX0
                let s1 = data.bytes[2]
                let s2 = data.bytes[3]
                length = Int(s1) * 256 + Int(s2) - 2
                next = Data(data: data, offset: 4 + length)
                
            case .SOS:
                bytes = data.bytes.advancedBy(2)
                length = 0
                next = Data(data: data, offset: 2)
            case .EOI:
                bytes = data.bytes.advancedBy(2)
                length = 0
                next = nil
            case .SOF0:
                bytes = data.bytes.advancedBy(4)
                let s1 = data.bytes[2]
                let s2 = data.bytes[3]
                length = Int(s1) * 256 + Int(s2) - 2
                next = Data(data: data, offset: 4 + length)
            case .SOF2:
                bytes = data.bytes.advancedBy(4)
                let s1 = data.bytes[2]
                let s2 = data.bytes[3]
                length = Int(s1) * 256 + Int(s2) - 2
                next = Data(data: data, offset: 4 + length)
            case .DHT:
                bytes = data.bytes.advancedBy(4)
                let s1 = data.bytes[2]
                let s2 = data.bytes[3]
                length = Int(s1) * 256 + Int(s2) - 2
                next = Data(data: data, offset: 4 + length)
            case .DQT:
                bytes = data.bytes.advancedBy(4)
                let s1 = data.bytes[2]
                let s2 = data.bytes[3]
                length = Int(s1) * 256 + Int(s2) - 2
                next = Data(data: data, offset: 4 + length)
            case .DRI:
                bytes = data.bytes.advancedBy(4)
                let s1 = data.bytes[2]
                let s2 = data.bytes[3]
                length = Int(s1) * 256 + Int(s2) - 2
                next = Data(data: data, offset: 4 + length)
            case .RST0:
                bytes = data.bytes.advancedBy(2)
                length = 0
                next = Data(data: data, offset: 2)
            case .RST1:
                bytes = data.bytes.advancedBy(2)
                length = 0
                next = Data(data: data, offset: 2)
            case .RST2:
                bytes = data.bytes.advancedBy(2)
                length = 0
                next = Data(data: data, offset: 2)
            case .RST3:
                bytes = data.bytes.advancedBy(2)
                length = 0
                next = Data(data: data, offset: 2)
            case .RST4:
                bytes = data.bytes.advancedBy(2)
                length = 0
                next = Data(data: data, offset: 2)
            case .RST5:
                bytes = data.bytes.advancedBy(2)
                length = 0
                next = Data(data: data, offset: 2)
            case .RST6:
                bytes = data.bytes.advancedBy(2)
                length = 0
                next = Data(data: data, offset: 2)
            case .RST7:
                bytes = data.bytes.advancedBy(2)
                length = 0
                next = Data(data: data, offset: 2)
            case .COM:
                bytes = data.bytes.advancedBy(4)
                let s1 = data.bytes[2]
                let s2 = data.bytes[3]
                length = Int(s1) * 256 + Int(s2) - 2
                next = Data(data: data, offset: 4 + length)
            }
        } else {
            print(data.bytes[1])
            return nil
        }
    }
    
    public var description :String {
        get {
            let nextString = next == nil ? "⍵" : "⚛"
            return "JFIFSegment(type:\(type.description), size:\(length) next:\(nextString))"
        }
    }
}
