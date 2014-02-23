//
//  HRMViewController.h
//  HeartMonitor
//
//  Created by Main Account on 12/13/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

// Start tutorial code
@import CoreBluetooth;
@import QuartzCore;

#define DEVICE_INFO_SERVICE_UUID @"180A"
#define DEVICE_DATA_SERVICE_UUID @"180D"

#define ACCEL_CHARACTERISTIC_UUID @"2A37"
#define GYRO_CHARACTERISTIC_UUID @"2A38"
#define MAGNETO_CHARACTERISTIC_UUID @"2A29"
// End tutorial code

@interface HRMViewController : UIViewController <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral     *kiwiWearablePeripheral;

// Properties for your Object controls
@property (nonatomic, strong) IBOutlet UITextView  *deviceInfo;
 
// Properties to hold data characteristics for the peripheral device
@property (nonatomic, strong) NSString   *connected;

@property (assign) uint16_t   *accelData;
@property (assign) uint16_t   *gyroData;
@property (assign) uint16_t   *magnetoData;

@property (nonatomic, strong) NSString   *manufacturer;
@property (nonatomic, strong) NSString   *kiwiWearableDeviceData;
 
// Instance methods to grab device Manufacturer Name, and kiwi wearable data
- (void) getManufacturerName:(CBCharacteristic *)characteristic;

- (void) getAccelData:(CBCharacteristic *)characteristic;
- (void) getGyroData:(CBCharacteristic *)characteristic;
- (void) getMagnetoData:(CBCharacteristic *)characteristic;

@end
