//
//  ViewController.h
//  PA One
//
//  Created by wanchenxie on 6/27/16.
//  Copyright © 2016 wanchenxie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRangeSlider.h"
#import "BTSerialPort.h"

@interface ViewController : UIViewController<NMRangesSliderDelegate, BTSerialPortDelegate>




//@property (nonatomic,retain) IBOutlet UILabel *sliderValueLabelOne;
//@property (nonatomic,retain) IBOutlet UILabel *sliderValueLabelTwo;
//@property (nonatomic,retain) IBOutlet UILabel *sliderValueLabelThree;
//@property (nonatomic,retain) IBOutlet UILabel *sliderValueLabelFour;
//@property (nonatomic,retain) IBOutlet UILabel *sliderValueLabelFive;


@property(nonatomic,retain)UISlider *sliderOne;
@property(nonatomic,retain)UISlider *sliderTwo;
@property(nonatomic,retain)UISlider *sliderThree;
@property(nonatomic,retain)UISlider *sliderFour;
@property(nonatomic,retain)UISlider *sliderFive;

@property(nonatomic,retain)UILabel *sliderValueLabelOne;
@property(nonatomic,retain)UILabel *sliderValueLabelTwo;
@property(nonatomic,retain)UILabel *sliderValueLabelThree;
@property(nonatomic,retain)UILabel *sliderValueLabelFour;
@property(nonatomic,retain)UILabel *sliderValueLabelFive;

@property CGFloat width;
@property CGFloat height;
@property CGFloat averageWidth;
@property CGFloat interval;

@property (strong, nonatomic) UIWindow *window;

@end

