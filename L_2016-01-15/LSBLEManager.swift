//
//  LSBLEManager.swift
//  LearningSwift
//
//  Created by AEF-RD-1 on 16/1/15.
//  Copyright © 2016年 yim. All rights reserved.
//

import UIKit
import CoreBluetooth
import Foundation


class LSBLEManager: NSObject,CBCentralManagerDelegate,CBPeripheralDelegate  {

    var ls_manager: CBCentralManager!
    var ls_peripheral: CBPeripheral!
    var ls_writeCharacteristic: CBCharacteristic!
    //保存收到的蓝牙设备
    var ls_deviceList:NSMutableArray = NSMutableArray()
    //服务和特征的UUID
    let kServiceUUID:String         = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
    let kCharacteristicUUID:String  = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
    private let kPeripheralAdvName :String = "AEFREADER"
    
    var ls_callBack = true;
    
    
    var ls_delegate = BLEManagerDelegate?()

    var ls_time_rssi :NSTimer!
    
    
    internal func setManager() {
        
        self.ls_manager = CBCentralManager(delegate:self,queue:nil)
        
        // Do any additional setup after loading the view.
        
    }
    
    
    
    internal func stopScan() {
        
        self.ls_manager.stopScan()
    }
    
    internal func connectWithPeripheral(peri:CBPeripheral) -> Void{
    
        self.ls_manager.stopScan()
        self.ls_callBack = false;
        
        self.ls_peripheral = peri;
        self.ls_manager.connectPeripheral(peri, options: nil)
    }
    
    
    
    // MARK: - CBCentralManagerDelegate
    // MARK: - 状态更新
    func centralManagerDidUpdateState(central: CBCentralManager) {
        
        //print("central:\(central.state)")
        switch central.state {
        case CBCentralManagerState.PoweredOn:
            self.ls_manager .scanForPeripheralsWithServices(nil, options: nil)
        case CBCentralManagerState.Unauthorized:
            MMPrint("device has not author use ble")
            
        case CBCentralManagerState.Unsupported:
            MMPrint("device has not support ble")
            
        case CBCentralManagerState.PoweredOff:
            MMPrint("ble state PoweredOff")
            
        case CBCentralManagerState.Unknown:
            MMPrint("central manager state unknow")
            
        default :
            MMPrint("central manager has not change state")
        }
        
        
        
    }
    
    // MARK: - 读取 RSSI 值
    func ls_readRSSI() -> Void {
        //
        self.ls_peripheral.readRSSI()
    }
    
    // MARK: - 连接成功
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        //
        self.ls_peripheral.delegate = self;
        self.ls_delegate! .bleDidConnect(peripheral)
        
        if (self.ls_time_rssi == nil) {
            let timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LSBLEManager.ls_readRSSI), userInfo: nil, repeats: true)
            self.ls_time_rssi = timer;
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
        }
        
        self.ls_peripheral.discoverServices(nil);
    }
    
    // MARK: - 连接失败
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        //
    }

    // MARK: - 连接断开
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        //
        self.ls_callBack = true;
        self.ls_time_rssi.invalidate()
        self.ls_time_rssi = nil
        self.ls_delegate?.bleDidDisConnect(peripheral)
        
    }
    
    // MARK: - 发现外设
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        //
        
        if !self.ls_deviceList.containsObject(peripheral) {
            self.ls_deviceList.addObject(peripheral)
        }
        if self.ls_callBack {
            self.ls_delegate?.bleDidFindPeripheral(self.ls_deviceList)
        }
        
        let name = (advertisementData as NSDictionary)[CBAdvertisementDataLocalNameKey];
        let pname = purfy(String(name))
        
        MMPrint("im-peripheral:\(peripheral.name)...\(name)...pname:\(pname)...rssd:\(RSSI)");
        
    }
    
    // MARK: - ====
    func centralManager(central: CBCentralManager, willRestoreState dict: [String : AnyObject]) {
        
    }
    
    // MARK: - CBPeripheralDelegate
    // MARK: - 从服务里发现特征
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if error == nil {
            for chc in service.characteristics! {
                if chc.UUID.UUIDString == kCharacteristicUUID {
                    self.ls_writeCharacteristic = chc;
                    self.ls_peripheral.setNotifyValue(true, forCharacteristic: chc)
                    sendDatas()
                }
            }

        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverDescriptorsForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        
    }
    
    
    func peripheral(peripheral: CBPeripheral, didDiscoverIncludedServicesForService service: CBService, error: NSError?) {
        
    }
    
    // MARK: - 查找服务
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        
        if error == nil {
            
            for service in peripheral.services! {
//                print("service:\(service)")
//                let perStr  = service.UUID;
                if service.UUID.UUIDString  == kServiceUUID {
                    self.ls_peripheral .discoverCharacteristics(nil, forService: service)
                }
            }
            
        }
        
    }
    
//    func CBUUIDToString(uuid:CBUUID) -> CChar {
//        return uuid.data.description.cStringUsingEncoding(NSStringEncodingDetectionAllowLossyKey)
//    }
    
    func peripheral(peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        
    }
    
    func peripheral(peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: NSError?) {
        
//        MMPrint("-------1-------- RSSI:\(RSSI)")
        self.ls_delegate?.bleDidReadRSSI(RSSI)
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        
//        MMPrint("did Update Value :\(characteristic.value)")
        self.ls_delegate?.bleDidUpdateValue(characteristic)
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForDescriptor descriptor: CBDescriptor, error: NSError?) {
        
    }
    
    func peripheral(peripheral: CBPeripheral, didWriteValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        
    }
    
    func peripheral(peripheral: CBPeripheral, didWriteValueForDescriptor descriptor: CBDescriptor, error: NSError?) {
        
    }
    
    func peripheralDidUpdateName(peripheral: CBPeripheral) {
        
    }
    
    internal func sendDatas() -> Void {
        let data = dataWithString("")
        MMPrint("data:\(data)")
        if self.ls_writeCharacteristic == nil {
            MMPrint("self.chc == nil")
            return
        }
        
        if self.ls_peripheral == nil{
            MMPrint("self.per == nil")
            return
        }
        
        self.ls_peripheral.writeValue(data, forCharacteristic: self.ls_writeCharacteristic, type: CBCharacteristicWriteType.WithResponse)
        
    }
    
    func dataWithString(str:String) -> NSData {
//        //
//        let length = 16;
//        var send : UInt8[length] ;
//        for i in 0..<length {
//            send[i] = 0x00;
//        }
//        
//        send[0] = 0xa1;
//        send[1] = 0xf0;
//        send[2] = 0x0e;
//        
//        let indetifier = UIDevice.currentDevice().identifierForVendor?.UUIDString
//        let idfList = indetifier?.componentsSeparatedByString("-")
//        let deviceMac = idfList?.last
//        print("deviceMac:\(deviceMac)")
//        
//        if ((deviceMac.length)>12) {
//            deviceMac = deviceMac?.substringToIndex(12)
//        }
//        
//        let dataMac = operationNumber(deviceMac)
//        let mac = dataMac.byte()
//        
//        for a in 0..<sizeof(dataMac) {
//            send[a+3] = mac[a]
//        }
//        let phone : String = "18565667965"
//        for k in 0..<sizeof(phone) {
//            let s:String = phone.substringWithRange(k*2,2)
//            send[k+9] = Int(s)
//        }
//        
//        for j in 0..<length-1 {
//            send[length-1] = send[length-1] ^ send[j]
//        }
        
        return NSData(bytes: [0xD9,0xff] as [UInt8] , length: 2)
    }
    
    func operationNumber(str:String) -> NSData {
        
        return NSData(bytes: [0xff,0xff] as [UInt8] , length: 2)
    }
    
    
    
    
}


extension NSObject {

    public func purfy(str:String) -> String {
        return str.stringByReplacingOccurrencesOfString(" ", withString: "").stringByReplacingOccurrencesOfString("\r", withString: "").stringByReplacingOccurrencesOfString("\n", withString: "").stringByReplacingOccurrencesOfString("-", withString: "").stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
}


public protocol BLEManagerDelegate:NSObjectProtocol {
    
    func bleStateDidChanged(state:String)
    
    func bleDidConnect(perip:CBPeripheral)
    
    func bleDidDisConnect(perip:CBPeripheral)
    
    func bleDidFindPeripheral(list:NSMutableArray)
    
    func bleDidReadRSSI(rssi:NSNumber)
    
    func bleDidUpdateValue(chc:CBCharacteristic)

}



