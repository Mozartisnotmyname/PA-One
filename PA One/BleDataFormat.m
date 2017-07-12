//
//  BleDataFormat.m
//  PA One
//
//  Created by 凌       陈 on 6/16/17.
//  Copyright © 2017 wanchenxie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleDataFormat.h"

@implementation BleDataFormat

const Byte DATA_HEAD = 0x55;
const Byte DATA_LEN = 0x12;
const Byte DATA_EDN = 0x0D;
const Byte DATA_DEF = 0xFF;

const int DEF_DATA_LEN = DATA_LEN;
const int REAL_DATA_LEN = DEF_DATA_LEN + 2;
const int MIN_DATA_LEN = 0x08;

const Byte DATA_ACK_OK = 0x01;
const Byte DATA_ACK_ERROR = 0x02;

const Byte SEND_CMD_ACK = 0xFE;
const Byte SEND_CMD_GET_SETTING = 0xFD;
const Byte SEND_CMD_SET_MASTER = 0xFC;
const Byte SEND_CMD_SET_CHANNEL = 0xFB;

const Byte REC_CMD_ACK = 0x01;
const Byte REC_CMD_SET_MASTER = 0x02;
const Byte REC_CMD_SET_CHANNEL = 0x03;
const Byte REC_CMD_SET_LIGHT = 0x04;

const Byte CHANNEL1 = 0x01;
const Byte CHANNEL2 = 0x02;
const Byte CHANNEL3 = 0x03;
const Byte CHANNEL4 = 0x04;

NSMutableArray* noCheckData; // 未检查数据
NSMutableArray* checkData;
Byte channelNum = 0;
int dataLength = 0;
Byte CMDType;
Byte recCMDType;
Boolean isDataGood = false;
NSMutableArray *sendCMDByte;
NSMutableArray *hexByte;

static BleDataFormat *_sharedManager = nil;


+(BleDataFormat *)sharedManager {
    @synchronized( [BleDataFormat class] ){
        if(!_sharedManager)
            _sharedManager = [[self alloc] init];
        return _sharedManager;
    }
    return nil;
}


-(BOOL) checkSum: (NSArray *)data{
    
    Byte checkSumByte = 0;
    
    if ([self checkLength:data]) {
        
        checkSumByte = [self calcCrc8:data offset:0 len:(data.count - 2) preval:checkSumByte];
        
        if (checkSumByte != [data[2] unsignedCharValue]){
            return false;
        }else{
            return true;
        }
    }
    else
    {
        return false;
    }
}

-(BOOL) checkLength: (NSArray *)data {
    if (data != nil && (data.count == REAL_DATA_LEN || data.count == MIN_DATA_LEN)) {
        return true;
    }
    return false;
}


-(Byte) calcCrc8: (NSArray *)data  offset: (int)offset len: (int)len preval: (Byte)preval{
    Byte ret = preval;
    for (int i = offset; i < len; i++) {
        ret += [data[i] unsignedCharValue];
    }
    return ret;
}

@end
