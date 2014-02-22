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

@interface HRMViewController : UIViewController

@end
