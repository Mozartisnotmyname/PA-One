//
//  BleDataFormat.h
//  PA One
//
//  Created by 凌       陈 on 6/16/17.
//  Copyright © 2017 wanchenxie. All rights reserved.
//

#ifndef BleDataFormat_h
#define BleDataFormat_h



@interface BleDataFormat  : NSObject

extern const Byte DATA_HEAD;
extern const Byte DATA_LEN;
extern const Byte DATA_EDN;
extern const Byte DATA_DEF;

extern const int DEF_DATA_LEN;
extern const int REAL_DATA_LEN;
extern const int MIN_DATA_LEN;

extern const Byte DATA_ACK_OK;
extern const Byte DATA_ACK_ERROR;

extern const Byte SEND_CMD_ACK;
extern const Byte SEND_CMD_GET_SETTING;
extern const Byte SEND_CMD_SET_MASTER;
extern const Byte SEND_CMD_SET_CHANNEL;

extern const Byte REC_CMD_ACK;
extern const Byte REC_CMD_SET_MASTER;
extern const Byte REC_CMD_SET_CHANNEL;
extern const Byte REC_CMD_SET_LIGHT;

extern const Byte CHANNEL1;
extern const Byte CHANNEL2;
extern const Byte CHANNEL3;
extern const Byte CHANNEL4;

-(BOOL) checkSum: (NSArray *)data;

@end

#endif /* BleDataFormat_h */
