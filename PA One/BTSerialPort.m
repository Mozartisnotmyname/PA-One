//
//  BTSerialPort.m
//  BLTest
//
//  Created by wanchenxie on 8/4/16.
//  Copyright © 2016 wanchenxie. All rights reserved.
//

#import "BTSerialPort.h"

#define BT_SERIAL_PORT_DEVICE_UUID      @"09A4F057-7C52-F377-5554-6540B3B2145C"
#define BT_SERIAL_PORT_SERVICE_UUID     @"FFE0"
#define BT_TRANSFER_CHARACTERISTIC_UUID @"FFE1"

@interface BTSerialPort ()

@property (nonatomic, strong) CBCentralManager* centralManager;
@property (nonatomic, strong) CBPeripheral* peripheral;
@property (nonatomic, strong) CBPeripheral* backupedPeripheral;
@property (nonatomic, strong) CBCharacteristic* transferCh;
@property (nonatomic) BOOL isPowerOn;



@end

@implementation BTSerialPort


#pragma mark - Init
- (instancetype)init{
    
    if (self = [super init]) {
        
        [self setup];
    }
    return self;
}

#pragma mark - Self tool functions
- (void)setup{
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
}

- (void)connect{
    
    if (self.isPowerOn) {
        
        // Directly connect the BT
        
        [self connectWithUUIDStr:BT_SERIAL_PORT_DEVICE_UUID];
        
        // Throught scan
        //[self scanForConnect];
        
    }
}

- (void)connectWithUUIDStr:(NSString*)uuidStr {
    
    self.backupedPeripheral = [[self.centralManager retrievePeripheralsWithIdentifiers:@[[CBUUID UUIDWithString:uuidStr]]] firstObject];
    
    if (self.backupedPeripheral) {
        [self.centralManager connectPeripheral:self.backupedPeripheral options:nil];
    }else {
        [self scanForConnect];
    }
    
}


- (void)scanForConnect {
    
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:BT_SERIAL_PORT_SERVICE_UUID]] options:nil];
}


-(NSData*)stringToByte:(NSString*)string//字符串转换为16位Data
{
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            return nil;
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            return nil;
        
        tempbyt[0] = int_ch1+int_ch2;  ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}

-(NSString *)ConvertToNSString:(NSData *)aData//将DATA转换为16进制字符串
{
    NSMutableString *strTemp = [NSMutableString stringWithCapacity:[aData length]*2];
    
    const unsigned char *szBuffer = [aData bytes];
    
    for (NSInteger i=0; i < [aData length]; ++i) {
        
        [strTemp appendFormat:@"%02lX",(unsigned long)szBuffer[i]];
    }
    
    return strTemp;
}

#pragma mark - send
- (void)sendCmdStr:(NSString *)cmd {
    
    if (self.transferCh) {
        
        NSData* cmdData = [self stringToByte:cmd];
        [self.peripheral writeValue:cmdData
                  forCharacteristic:self.transferCh
                               type:CBCharacteristicWriteWithoutResponse];
    }
}



#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    NSLog(@"Central didUpdateState...");
    
    switch (central.state) {
        case CBCentralManagerStateUnknown: {
            
            break;
        }
        case CBCentralManagerStateResetting: {
            
            break;
        }
        case CBCentralManagerStateUnsupported: {
            
            break;
        }
        case CBCentralManagerStateUnauthorized: {
            
            break;
        }
        case CBCentralManagerStatePoweredOff: {
            
            self.isPowerOn = false;
            
            if (self.delegate != nil
                && [self.delegate respondsToSelector:@selector(btSerialPortPoweredOn:)]) {
                
                [self.delegate performSelector:@selector(btSerialPortPoweredOn:) withObject:[NSNumber numberWithBool:false]];
            }
            break;
        }
        case CBCentralManagerStatePoweredOn: {
            self.isPowerOn = YES;
            
            if (self.delegate != nil
                && [self.delegate respondsToSelector:@selector(btSerialPortPoweredOn:)]) {
                
                [self.delegate performSelector:@selector(btSerialPortPoweredOn:) withObject:[NSNumber numberWithBool:YES]];
            }
            NSNumber *ret;
            [self.delegate respondsToSelector:@selector(btSerialPortPoweredOn:)];
            break;
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"Central didDiscover... %@", peripheral.name);
    
    [self.centralManager stopScan];
    
    self.peripheral = peripheral;
    peripheral.delegate = self;
    
    [self.centralManager connectPeripheral:peripheral options:nil];
    
}
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"Central didConnectePeripheral... %@", peripheral.name);
    
    self.peripheral = peripheral;
    peripheral.delegate = self;

    
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"Central didFailedToConnect... %@", peripheral.name);
    
    [self scanForConnect];
}


#pragma mark - CBPeripheralDelegate
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    NSLog(@"Peripheral didDiscoverService... ");
    
    for (CBService* service in peripheral.services) {
        
        NSLog(@"      There are %@", service);
        if ([service.UUID isEqual:[CBUUID UUIDWithString:BT_SERIAL_PORT_SERVICE_UUID]]) {
            
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"Peripheral didDiscoverCharacteristic ...");
    
    for (CBCharacteristic* ch in service.characteristics) {
        
        NSLog(@"     They are %@", ch);
        if ([ch.UUID isEqual:[CBUUID UUIDWithString:BT_TRANSFER_CHARACTERISTIC_UUID]]) {
            
            self.transferCh = ch;
            [peripheral setNotifyValue:YES forCharacteristic:ch];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"Peripheral didUpdateValue... %@", characteristic.value);
    
    if (self.delegate != nil
        && [self.delegate respondsToSelector:@selector(receiveCmdStr:)]) {
        
        NSString* str = [self ConvertToNSString:characteristic.value];
        [self.delegate performSelector:@selector(receiveCmdStr:) withObject:str];
    }
}
@end
