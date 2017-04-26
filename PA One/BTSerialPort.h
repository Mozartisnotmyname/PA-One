//
//  BTSerialPort.h
//  BLTest
//
//  Created by wanchenxie on 8/4/16.
//  Copyright © 2016 wanchenxie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


//************************************************************************
#define MUTE_ON_CMD     @"55 12 FC 00 00 00 FF FF FF FF FF FF FF FF FF FF FF FF 64 0D"
#define MUTE_OFF_CMD    @"55 12 FC 00 01 00 FF FF FF FF FF FF FF FF FF FF FF FF 64 0D"











//*************************************************************************






@protocol BTSerialPortDelegate <NSObject>

@optional
- (void)btSerialPortPoweredOn:(NSNumber*)result;
- (void)receiveStr:(NSString*)str;

@end

@interface BTSerialPort : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic) id<BTSerialPortDelegate> delegate;

- (instancetype)init;
- (void)connect;

- (void)sendCmdStr:(NSString*)cmd;
@end
