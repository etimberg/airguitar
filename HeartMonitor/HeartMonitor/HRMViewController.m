//
//  HRMViewController.m
//  HeartMonitor
//
//  Created by Main Account on 12/13/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "HRMViewController.h"

@interface HRMViewController ()

@end

@implementation HRMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
	self.kiwiWearableDeviceData = nil;
	[self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
 
	// Clear out textView
	[self.deviceInfo setText:@""];
	[self.deviceInfo setTextColor:[UIColor blueColor]];
	[self.deviceInfo setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
	[self.deviceInfo setFont:[UIFont fontWithName:@"Arial" size:25]];
	[self.deviceInfo setUserInteractionEnabled:NO];
 
	// Scan for all available CoreBluetooth LE devices
	NSArray *services = @[[CBUUID UUIDWithString:DEVICE_INFO_SERVICE_UUID], [CBUUID UUIDWithString:DEVICE_DATA_SERVICE_UUID]];
	CBCentralManager *centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
	[centralManager scanForPeripheralsWithServices:services options:nil];
	self.centralManager = centralManager;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CBCentralManagerDelegate
 
// method called whenever you have successfully connected to the BLE peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral 
{
}
 
// CBCentralManagerDelegate - This is called with the CBPeripheral class as its main input parameter. This contains most of the information there is to know about a BLE peripheral.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI 
{
    NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    if ([localName length] > 0) {
        NSLog(@"Found the Kiwi Wearable: %@", localName);
        [self.centralManager stopScan];
        self.kiwiWearablePeripheral = peripheral;
        peripheral.delegate = self;
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}
 
// method called whenever the device state changes.
- (void)centralManagerDidUpdateState:(CBCentralManager *)central 
{
    // Determine the state of the peripheral
    if ([central state] == CBCentralManagerStatePoweredOff) {
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
    }
    else if ([central state] == CBCentralManagerStateUnauthorized) {
        NSLog(@"CoreBluetooth BLE state is unauthorized");
    }
    else if ([central state] == CBCentralManagerStateUnknown) {
        NSLog(@"CoreBluetooth BLE state is unknown");
    }
    else if ([central state] == CBCentralManagerStateUnsupported) {
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
    }
}

#pragma mark - CBPeripheralDelegate
 
// CBPeripheralDelegate - Invoked when you discover the peripheral's available services.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error 
{
}
 
// Invoked when you discover the characteristics of a specified service.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error 
{
}
 
// Invoked when you retrieve a specified characteristic's value, or when the peripheral device notifies your app that the characteristic's value has changed.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error 
{
}

#pragma mark - CBCharacteristic helpers
 
// Instance method to get the acceleration
- (void) getAccel:(CBCharacteristic *)characteristic error:(NSError *)error 
{
}
// Instance method to get the manufacturer name of the device
- (void) getGyro:(CBCharacteristic *)characteristic 
{
}
// Instance method to get the body location of the device
- (void) getMagneto:(CBCharacteristic *)characteristic 
{
}

@end
