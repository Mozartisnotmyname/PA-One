//
//  ViewController.m
//  PA One
//
//  Created by wanchenxie on 6/27/16.
//  Copyright © 2016 wanchenxie. All rights reserved.
//

#import "ViewController.h"
#import "NMRangeSlider.h"
#import "KGModal.h"
#import "BleDataFormat.h"

typedef enum: NSInteger{
    NoFold = 1,
    FromBtnOne,
    FromBtnTwo,
    FromBtnThree,
    FromBtnFour
}DisplayStatus;

int labelInViewFourDetailDisplayStatus = 0;

bool btnMuteInViewOneStatusFlag;
bool btnMuteInViewTwoStatusFlag;
bool btnMuteInViewThreeStatusFlag;
bool btnMuteInViewFourStatusFlag;
bool btnMuteInViewFiveStatusFlag;
bool btnInViewFiveFirstTimeFlag = true;
bool btnInViewFiveDetailStatus = true;
bool btnInFeedbackInViewFiveDetailStatus = true;
bool btnSOLOInViewOneDetailClickedStatus = true;
bool btnSOLOInViewTwoDetailClickedStatus = true;
bool btnSOLOInViewThreeDetailClickedStatus = true;

//CH1 不可选部分需要覆盖的view
UIView *btnMuteCannotChooseViewInViewOne;
UIView *imageViewCannotChooseViewInViewOne;
UIView *sliderOneCannotChooseInViewOneDetail;
UIView *sliderTwoCannotChooseInViewOneDetail;
UIView *sliderThreeCannotChooseInViewOneDetail;

//CH2 不可选部分需要覆盖的view
UIView *btnMuteCannotChooseViewInViewTwo;
UIView *imageViewCannotChooseViewInViewTwo;
UIView *sliderOneCannotChooseInViewTwoDetail;
UIView *sliderTwoCannotChooseInViewTwoDetail;
UIView *sliderThreeCannotChooseInViewTwoDetail;

//Bt/Aux 不可选部分需要覆盖的view
UIView *btnMuteCannotChooseViewInViewThree;
UIView *imageViewCannotChooseViewInViewThree;
UIView *sliderOneCannotChooseInViewThreeDetail;
UIView *sliderTwoCannotChooseInViewThreeDetail;
UIView *sliderThreeCannotChooseInViewThreeDetail;

//Reverb 不可选部分
UIView *imageViewCannotChooseViewInViewFour;

//Main 不可选部分
UIView *imageViewCannotChooseViewInViewFive;



NSUInteger r;
NSTimer *timerOne;
NSTimer *timerTwo;
NSTimer *timerThree;
NSTimer *timerFour;
NSTimer *timerFive;

UIView *contentView;
UIButton *btnMALEVOCAL;
UIButton *btnFEMALEVOCAL;
UIButton *btnELECTRICGUITAR;
UIButton *btnNYLONACOUSTIC;
UIButton *btnSTEELACOUSTIC;
UIButton *btnBASSGUITAR;
UIButton *btnSYNTHPIANO;
UIButton *btnBRASS;
UIButton *btnWOODWIND;
UIButton *btnLOWBOOST;
UIButton *btnFLAT;
UIButton *btnCOMPRESSOR;
UIButton *btnCHORUS;
UIButton *btnDELAY;
UIButton *btnReverbDelay;

int buttonClickedInVOICEMODE = 1;
int buttonClickedInFXSELECTOR = 1;


@interface ViewController ()

//================== BT ========================
@property (strong, nonatomic) BTSerialPort* btSerialPort;




@property (weak, nonatomic) IBOutlet UIView *viewOne;
@property (weak, nonatomic) IBOutlet UIView *viewTwo;
@property (weak, nonatomic) IBOutlet UIView *viewThree;
@property (weak, nonatomic) IBOutlet UIView *viewFour;
@property (weak, nonatomic) IBOutlet UIView *viewFive;
@property (weak, nonatomic) IBOutlet UIView *blackBackground;
@property (weak, nonatomic) IBOutlet UIView *viewFiveDetail;
@property (weak, nonatomic) IBOutlet UIView *viewOneDetail;
@property (weak, nonatomic) IBOutlet UIView *viewTwoDetail;
@property (weak, nonatomic) IBOutlet UIView *viewThreeDetail;
@property (weak, nonatomic) IBOutlet UIView *viewFourDetail;
@property (weak, nonatomic) IBOutlet UIView *viewMainEQInViewFiveDetail;
@property (weak, nonatomic) IBOutlet UIView *viewFeedbackInViewFiveDetail;
@property (weak, nonatomic) IBOutlet UIView *viewAboutInViewFiveDetail;


- (IBAction)btnOneTapped:(UIButton *)sender;
- (IBAction)btnTwoTapped:(UIButton *)sender;
- (IBAction)btnThreeTapped:(UIButton *)sender;
- (IBAction)btnFourTapped:(UIButton *)sender;
- (IBAction)btnFiveTapped:(UIButton *)sender;
- (IBAction)btnFourSubstituteInViewOneDetail:(id)sender;
- (IBAction)btnFourSubstituteInViewTwoDetail:(id)sender;
- (IBAction)btnFourSubstituteInViewThreeDetail:(id)sender;

//SOLO按键action
- (IBAction)btnSOLOInViewOneDetailTapped:(id)sender;
- (IBAction)btnSOLOInViewTwoDetailTapped:(id)sender;
- (IBAction)btnSOLOInViewThreeDetailTapped:(id)sender;


- (IBAction)btnLeftInViewOneDetail:(id)sender;
- (IBAction)btnRightInViewOneDetail:(id)sender;
- (IBAction)btnLeftInViewTwoDetail:(id)sender;
- (IBAction)btnRightInViewTwoDetail:(id)sender;
- (IBAction)btnLeftInViewThreeDetail:(id)sender;
- (IBAction)btnRightInViewThreeDetail:(id)sender;
- (IBAction)btnLeftInViewFourDetail:(id)sender;
- (IBAction)btnRightInViewFourDetail:(id)sender;


- (IBAction)btnFunctionSelectInDialogTapped:(id)sender;
- (IBAction)segmentTapped:(id)sender;
- (IBAction)btnOneDownInViewFiveDetailTapped:(id)sender;
- (IBAction)btnTwoDownInViewFiveDetailTapped:(id)sender;
- (IBAction)btnThreeDownInViewFiveDetailTapped:(id)sender;
- (IBAction)btnOneUpInViewFiveDetailTapped:(id)sender;
- (IBAction)btnTwoUpInViewFiveDetailTapped:(id)sender;
- (IBAction)btnThreeUpInViewFiveDetailTapped:(id)sender;


- (IBAction)btnMuteInViewOneTapped:(id)sender;
- (IBAction)btnMuteInViewTwoTapped:(id)sender;
- (IBAction)btnMuteInViewThreeTapped:(id)sender;
- (IBAction)btnMuteInViewFourTapped:(id)sender;
- (IBAction)btnMuteInViewFiveTapped:(id)sender;
- (IBAction)btnLIMITERInFeedbackInViewFiveDetailTapped:(id)sender;
- (IBAction)btnFBSUPPRESSORInFeedbackInViewFiveDetailTapped:(id)sender;
- (IBAction)btnBASSBOOSTInFeedbackInViewFiveDetailTapped:(id)sender;

//===================== Cross-Slider in five views ======================
// ViewOne
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInViewOneForReverdSend;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInHightInViewOneDetail;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInMidInViewOneDetail;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInLowInViewOneDetail;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInFXLEVELInViewOneDetail;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInRVSENDInViewOneForMid;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInPANInViewOneForLow;


// ViewTwo
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInViewTwoForReverdSend;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInHightInViewTwoDetail;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInMidInViewTwoDetail;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInLowInViewTwoDetail;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInFXLEVELInViewTwoDetail;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInRVSENDInViewTwoForMid;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInPANInViewTwoForLow;

// ViewThree
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInViewThreeForReverdSend;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInHightInViewThreeDetail;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInMidInViewThreeDetail;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInLowInViewThreeDetail;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInFXLEVELInViewThreeDetail;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInRVSENDInViewThreeForMid;
@property (weak, nonatomic) IBOutlet NMRangeSlider *crossSliderInPANInViewThreeForLow;


@property (weak, nonatomic) IBOutlet UILabel *labelInViewOne;
@property (weak, nonatomic) IBOutlet UILabel *labelInViewTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelInViewThree;
@property (weak, nonatomic) IBOutlet UILabel *labelInViewFour;
@property (weak, nonatomic) IBOutlet UILabel *labelInViewFive;



@property (weak, nonatomic) IBOutlet UIButton *btnInViewOne;
@property (weak, nonatomic) IBOutlet UIButton *btnVerticalInViewOne;
@property (weak, nonatomic) IBOutlet UIButton *btnInViewTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnVerticalInViewTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnInViewThree;
@property (weak, nonatomic) IBOutlet UIButton *btnVerticalInViewThree;
@property (weak, nonatomic) IBOutlet UIButton *btnInViewFour;
@property (weak, nonatomic) IBOutlet UIButton *btnVerticalInViewFour;
@property (weak, nonatomic) IBOutlet UIButton *btnInViewFive;
@property (weak, nonatomic) IBOutlet UIButton *btnVerticalInViewFive;


@property (weak, nonatomic) IBOutlet UIButton *btnMuteInViewOne;
@property (weak, nonatomic) IBOutlet UIButton *btnMuteInViewOnePress;
@property (weak, nonatomic) IBOutlet UIButton *btnMuteInViewTwo;
@property (weak, nonatomic) IBOutlet UIButton *btnMuteInViewTwoPress;
@property (weak, nonatomic) IBOutlet UIButton *btnMuteInViewThree;
@property (weak, nonatomic) IBOutlet UIButton *btnMuteInViewThreePress;
@property (weak, nonatomic) IBOutlet UIButton *btnMuteInViewFour;
@property (weak, nonatomic) IBOutlet UIButton *btnMuteInViewFourPress;
@property (weak, nonatomic) IBOutlet UIButton *btnMuteInViewFive;
@property (weak, nonatomic) IBOutlet UIButton *btnMuteInViewFivePress;


@property (weak, nonatomic) IBOutlet UIButton *btnLIMITERInFeedbackInViewFiveDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnFBSUPPRESSORInFeedbackInViewFiveDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnBASSBOOSTInFeedbackInViewFiveDetail;



@property (weak, nonatomic) IBOutlet UIImageView *imageViewSMALLInViewFourDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewMIDInViewFourDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLARGEInViewFourDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewKARAOKEInViewFourDetail;

//SOLO按键变量
@property (weak, nonatomic) IBOutlet UIButton *btnSOLOInViewOneDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnSOLOInViewTwoDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnSOLOInViewThreeDetail;


//viewOne,viewOneDetail中的一些Outlet
@property (weak, nonatomic) IBOutlet UIImageView *imageViewInViewOne;
@property (weak, nonatomic) IBOutlet UIView *sliderInViewOneDetail;
@property (weak, nonatomic) IBOutlet UIView *sliderOneInViewOneDetail;
@property (weak, nonatomic) IBOutlet UIView *sliderTwoInViewOneDetail;
@property (weak, nonatomic) IBOutlet UIView *sliderThreeInViewOneDetail;

//viewTwo,viewTwoDetail中的一些Outlet
@property (weak, nonatomic) IBOutlet UIImageView *imageViewInViewTwo;
@property (weak, nonatomic) IBOutlet UIView *sliderInViewTwoDetail;
@property (weak, nonatomic) IBOutlet UIView *sliderOneInViewTwoDetail;
@property (weak, nonatomic) IBOutlet UIView *sliderTwoInViewTwoDetail;
@property (weak, nonatomic) IBOutlet UIView *sliderThreeInViewTwoDetail;

//viewThree,viewThreeDetail中的一些Outlet
@property (weak, nonatomic) IBOutlet UIImageView *imageViewInViewThree;
@property (weak, nonatomic) IBOutlet UIView *sliderInViewThreeDetail;
@property (weak, nonatomic) IBOutlet UIView *sliderOneInViewThreeDetail;
@property (weak, nonatomic) IBOutlet UIView *sliderTwoInViewThreeDetail;
@property (weak, nonatomic) IBOutlet UIView *sliderThreeInViewThreeDetail;



@property (weak, nonatomic) IBOutlet UIImageView *imageViewInViewFour;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewInViewFive;

//ViewFiveDetail segment-Preset
@property (weak, nonatomic) IBOutlet UIButton *btnOneDownInViewFiveDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnTwoDownInViewFiveDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnThreeDownInViewFiveDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnOneUpInViewFiveDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnTwoUpInViewFiveDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnThreeUpInViewFiveDetail;





@property (weak, nonatomic) IBOutlet UILabel *labelInViewFourDetail;

@property (weak, nonatomic) IBOutlet UILabel *labelOneInAboutInViewFiveDetail;
@property (weak, nonatomic) IBOutlet UILabel *labelTwoInAboutInViewFiveDetail;
@property (weak, nonatomic) IBOutlet UILabel *labelThreeInAboutInViewFiveDetail;




@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthForViewOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthForViewTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthForViewThree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthForViewFour;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthForViewFive;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForReverbSendOneInViewOneDetail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForReverbSendThreeInViewOneDetail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForHightInViewOneDetail;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForReverbSendOneInViewTwoDetail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForReverbSendThreeInViewTwoDetail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForHightInViewTwoDetail;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForReverbSendOneInViewThreeDetail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForReverbSendThreeInViewThreeDetail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForHightInViewThreeDetail;

//length and height of segment
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentLength;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segmentHeight;


//length and height of button
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForBtnMute;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthForBtnMute;



@property (nonatomic) CGRect viewHideOriginalFrame;
@property (nonatomic) CGRect viewOneOriginalFrame;
@property (nonatomic) CGRect viewTwoOriginalFrame;
@property (nonatomic) CGRect viewThreeOriginalFrame;
@property (nonatomic) CGRect viewFourOriginalFrame;
@property (nonatomic) CGRect viewFiveOriginalFrame;
@property (nonatomic) CGRect viewBlackBackgroundOriginalFrame;
@property (nonatomic) CGRect viewOneToFourDetailHideLeftFrame;
@property (nonatomic) CGRect viewOneToFourDetailHideRightFrame;
@property (nonatomic) CGRect viewOneToFourDetailOriginalFrame;
@property (nonatomic) CGRect viewFiveDetailHideFrame;
@property (nonatomic) CGRect viewFiveDetailOriginalFrame;


@property (nonatomic) DisplayStatus displayStatus;

@property (nonatomic) NSTimeInterval animationTime;
@property (nonatomic) BOOL isFold;

@end

@implementation ViewController

@synthesize sliderOne;
@synthesize sliderTwo;
@synthesize sliderThree;
@synthesize sliderFour;
@synthesize sliderFive;

@synthesize sliderValueLabelOne;
@synthesize sliderValueLabelTwo;
@synthesize sliderValueLabelThree;
@synthesize sliderValueLabelFour;
@synthesize sliderValueLabelFive;

@synthesize width;
@synthesize height;
@synthesize interval;
@synthesize averageWidth;

BleDataFormat* bleDataFormat = nil;

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect b = self.view.bounds;
    
    width = CGRectGetWidth(b);
    height = CGRectGetHeight(b);
    
    NSLog(@"width = %f, height = %f", width, height);
    
    interval = 0.0f;
    
    averageWidth = (width - interval * 4) / 5;
    NSLog(@"averageWidth = %f", averageWidth);
    
    self.widthForViewOne.constant = averageWidth;
    self.widthForViewTwo.constant = averageWidth;
    self.widthForViewThree.constant = averageWidth;
    self.widthForViewFour.constant = averageWidth;
    self.widthForViewFive.constant = averageWidth;
    
    //viewOneDetail界面约束根据屏幕heigh调整
    self.heightForReverbSendOneInViewOneDetail.constant = (height - 93) * 0.8 / 4.5;
    self.heightForReverbSendThreeInViewOneDetail.constant = (height - 93) * 3.5 / 4.5;
    self.heightForHightInViewOneDetail.constant =self.heightForReverbSendThreeInViewOneDetail.constant / 6;
    
    //viewTwoDetail界面约束根据屏幕heigh调整
    self.heightForReverbSendOneInViewTwoDetail.constant = (height - 93) * 0.8 / 4.5;
    self.heightForReverbSendThreeInViewTwoDetail.constant = (height - 93) * 3.5 / 4.5;
    self.heightForHightInViewTwoDetail.constant =self.heightForReverbSendThreeInViewTwoDetail.constant / 6;
    
    //viewThreeDetail界面约束根据屏幕heigh调整
    self.heightForReverbSendOneInViewThreeDetail.constant = (height - 93) * 0.8 / 4.5;
    self.heightForReverbSendThreeInViewThreeDetail.constant = (height - 93) * 3.5 / 4.5;
    self.heightForHightInViewThreeDetail.constant =self.heightForReverbSendThreeInViewTwoDetail.constant / 6;


    //设置ViewFiveDetail中的segment的宽度和高度
    self.segmentLength.constant = averageWidth * 2.5;
    self.segmentHeight.constant = height / 11;
    
    
    
    self.viewHideOriginalFrame = CGRectMake(-averageWidth, 0, averageWidth, height);
    
    self.viewOneOriginalFrame = CGRectMake(0, 0, averageWidth, height);
    self.viewTwoOriginalFrame = CGRectMake(averageWidth + interval, 0, averageWidth, height);
    
    self.viewThreeOriginalFrame = CGRectMake((averageWidth + interval) * 2, 0, averageWidth, height);
    
    self.viewFourOriginalFrame = CGRectMake((averageWidth  + interval) * 3, 0, averageWidth, height);
    
    self.viewFiveOriginalFrame = CGRectMake((averageWidth + interval) * 4, 0, averageWidth, height);
    
    self.viewBlackBackgroundOriginalFrame = CGRectMake(0, 0, width, height);
    
    self.viewFiveDetailOriginalFrame = CGRectMake(0, 0, averageWidth * 4, height);
    self.viewFiveDetailHideFrame = CGRectMake(averageWidth * 5, 0, averageWidth * 4, height);
    self.viewOneToFourDetailOriginalFrame = CGRectMake(averageWidth, 0, averageWidth * 3, height);
    self.viewOneToFourDetailHideLeftFrame = CGRectMake((-averageWidth) * 3, 0, averageWidth * 3, height);
    self.viewOneToFourDetailHideRightFrame = CGRectMake(averageWidth * 5 , 0, averageWidth * 3, height);
   
    
    
    
    
    NSLog(@"viewOneFrame x = %f, y = %f, width = %f", self.viewOne.frame.origin.x, self.viewOne.frame.origin.y, self.viewOne.frame.size.width);
    
    NSLog(@"viewTwoFrame x = %f, y = %f, width = %f", self.viewTwo.frame.origin.x, self.viewTwo.frame.origin.y, self.viewTwo.frame.size.width);
    
    NSLog(@"viewThreeFrame x = %f, y = %f, width = %f", self.viewThree.frame.origin.x, self.viewThree.frame.origin.y, self.viewThree.frame.size.width);
    
    NSLog(@"viewFourFrame x = %f, y = %f, width = %f", self.viewFour.frame.origin.x, self.viewFour.frame.origin.y, self.viewFour.frame.size.width);
    
    NSLog(@"\n\n");
    
    NSLog(@"viewOneOriginalFrame x = %f, y = %f, width = %f", self.viewOneOriginalFrame.origin.x, self.viewOneOriginalFrame.origin.y, self.viewOneOriginalFrame.size.width);
    
    NSLog(@"viewTwoOriginalFrame x = %f, y = %f, width = %f", self.viewTwoOriginalFrame.origin.x, self.viewTwoOriginalFrame.origin.y, self.viewTwoOriginalFrame.size.width);
    
    NSLog(@"viewThreeOriginalFrame x = %f, y = %f, width = %f", self.viewThreeOriginalFrame.origin.x, self.viewThreeOriginalFrame.origin.y, self.viewThreeOriginalFrame.size.width);
    
    NSLog(@"viewFourOriginalFrame x = %f, y = %f, width = %f", self.viewFourOriginalFrame.origin.x, self.viewFourOriginalFrame.origin.y, self.viewFourOriginalFrame.size.width);
    
    self.displayStatus = NoFold;
    
    self.isFold = false;
    
    self.animationTime = 0.4f;
    
    //为ViewFiveDetail中的segment-Preset六个按键添加背景图片，为了按下有阴影效果
    [self.btnOneDownInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_button_one_down"] forState:UIControlStateNormal];
    [self.btnTwoDownInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_button_one_down"] forState:UIControlStateNormal];
    [self.btnThreeDownInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_button_one_down"] forState:UIControlStateNormal];
    [self.btnOneUpInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_button_one_down"] forState:UIControlStateNormal];
    [self.btnTwoUpInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_button_one_down"] forState:UIControlStateNormal];
    [self.btnThreeUpInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_button_one_down"] forState:UIControlStateNormal];

    
    //添加代码
    //滑动条
    [self sliderOneInit];
    [self sliderTwoInit];
    [self sliderThreeInit];
    [self sliderFourInit];
    [self sliderFiveInit];
//    [self sliderInViewOneInit];
//    [self sliderHighInViewOneInit];
//    [self sliderMidInViewOneInit];
//    [self sliderLowInViewOneInit];
 
    
    // Add a shadow for ViewFive
    self.viewFive.layer.shadowOpacity = 1.0;
    self.viewFive.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.viewFive.layer.shadowOffset = CGSizeMake(-2, 0);
    
    // ========= Configure the cross-slider ===================
    // ===== Configure the cross-slider in viewOne ======
    //Configure crossSliderInViewOneFor Reverb Send
    self.crossSliderInViewOneForReverdSend.minimumRange = -1.0;
    self.crossSliderInViewOneForReverdSend.upperValue = 0;
    self.crossSliderInViewOneForReverdSend.lowerValue = 0.05;
    self.crossSliderInViewOneForReverdSend.delegate = self;
    self.crossSliderInViewOneForReverdSend.backgroundColor = [UIColor clearColor];
    self.crossSliderInViewOneForReverdSend.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInViewOneForReverdSend.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInViewOneForReverdSend.trackImage= [UIImage imageNamed:@"drawable_green_button.9_meitu_1"];
    
    //Configure crossSliderInHightInViewOneDetail
    self.crossSliderInHightInViewOneDetail.minimumRange = -1.0;
    self.crossSliderInHightInViewOneDetail.upperValue = 0.5;
    self.crossSliderInHightInViewOneDetail.lowerValue = 0.5;
    self.crossSliderInHightInViewOneDetail.delegate = self;
    self.crossSliderInHightInViewOneDetail.backgroundColor = [UIColor clearColor];
    self.crossSliderInHightInViewOneDetail.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInHightInViewOneDetail.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInHightInViewOneDetail.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];

    //Configure crossSliderInMidInViewOneDetail
    self.crossSliderInMidInViewOneDetail.minimumRange = -1.0;
    self.crossSliderInMidInViewOneDetail.upperValue = 0.5;
    self.crossSliderInMidInViewOneDetail.lowerValue = 0.5;
    self.crossSliderInMidInViewOneDetail.delegate = self;
    self.crossSliderInMidInViewOneDetail.backgroundColor = [UIColor clearColor];
    self.crossSliderInMidInViewOneDetail.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInMidInViewOneDetail.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInMidInViewOneDetail.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];

    
    //Configure crossSliderInLowInViewOneDetail
    self.crossSliderInLowInViewOneDetail.minimumRange = -1.0;
    self.crossSliderInLowInViewOneDetail.upperValue = 0.5;
    self.crossSliderInLowInViewOneDetail.lowerValue = 0.5;
    self.crossSliderInLowInViewOneDetail.delegate = self;
    self.crossSliderInLowInViewOneDetail.backgroundColor = [UIColor clearColor];
    self.crossSliderInLowInViewOneDetail.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInLowInViewOneDetail.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInLowInViewOneDetail.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];

    
    //Configure crossSliderInFXLEVELInViewOneDetail
    self.crossSliderInFXLEVELInViewOneDetail.minimumRange = -1.0;
    self.crossSliderInFXLEVELInViewOneDetail.upperValue = 0.5;
    self.crossSliderInFXLEVELInViewOneDetail.lowerValue = 0.5;
    self.crossSliderInFXLEVELInViewOneDetail.delegate = self;
    self.crossSliderInFXLEVELInViewOneDetail.backgroundColor = [UIColor clearColor];
    self.crossSliderInFXLEVELInViewOneDetail.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInFXLEVELInViewOneDetail.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInFXLEVELInViewOneDetail.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    //Configure crossSliderInRVSENDInViewOneForMid
    self.crossSliderInRVSENDInViewOneForMid.minimumRange = -1.0;
    self.crossSliderInRVSENDInViewOneForMid.upperValue = 0.5;
    self.crossSliderInRVSENDInViewOneForMid.lowerValue = 0.5;
    self.crossSliderInRVSENDInViewOneForMid.delegate = self;
    self.crossSliderInRVSENDInViewOneForMid.backgroundColor = [UIColor clearColor];
    self.crossSliderInRVSENDInViewOneForMid.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInRVSENDInViewOneForMid.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInRVSENDInViewOneForMid.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    //Configure crossSliderInPANInViewOneForLow
    self.crossSliderInPANInViewOneForLow.minimumRange = -1.0;
    self.crossSliderInPANInViewOneForLow.upperValue = 0.5;
    self.crossSliderInPANInViewOneForLow.lowerValue = 0.5;
    self.crossSliderInPANInViewOneForLow.delegate = self;
    self.crossSliderInPANInViewOneForLow.backgroundColor = [UIColor clearColor];
    self.crossSliderInPANInViewOneForLow.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInPANInViewOneForLow.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInPANInViewOneForLow.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];

    
    // ===== Configure the cross-slider in viewTwo =======
    //Configure crossSliderInViewTwoFor Reverb Send
    self.crossSliderInViewTwoForReverdSend.minimumRange = -1.0;
    self.crossSliderInViewTwoForReverdSend.upperValue = 0;
    self.crossSliderInViewTwoForReverdSend.lowerValue = 0.05;
    self.crossSliderInViewTwoForReverdSend.delegate = self;
    self.crossSliderInViewTwoForReverdSend.backgroundColor = [UIColor clearColor];
    
    self.crossSliderInViewTwoForReverdSend.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInViewTwoForReverdSend.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInViewTwoForReverdSend.trackImage= [UIImage imageNamed:@"drawable_green_button.9_meitu_1"];
    
    //Configure crossSliderInHightInViewTwoDetail
    self.crossSliderInHightInViewTwoDetail.minimumRange = -1.0;
    self.crossSliderInHightInViewTwoDetail.upperValue = 0.5;
    self.crossSliderInHightInViewTwoDetail.lowerValue = 0.5;
    self.crossSliderInHightInViewTwoDetail.delegate = self;
    self.crossSliderInHightInViewTwoDetail.backgroundColor = [UIColor clearColor];
    self.crossSliderInHightInViewTwoDetail.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInHightInViewTwoDetail.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInHightInViewTwoDetail.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    //Configure crossSliderInMidInViewTwoDetail
    self.crossSliderInMidInViewTwoDetail.minimumRange = -1.0;
    self.crossSliderInMidInViewTwoDetail.upperValue = 0.5;
    self.crossSliderInMidInViewTwoDetail.lowerValue = 0.5;
    self.crossSliderInMidInViewTwoDetail.delegate = self;
    self.crossSliderInMidInViewTwoDetail.backgroundColor = [UIColor clearColor];
    self.crossSliderInMidInViewTwoDetail.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInMidInViewTwoDetail.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInMidInViewTwoDetail.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    
    //Configure crossSliderInLowInViewTwoDetail
    self.crossSliderInLowInViewTwoDetail.minimumRange = -1.0;
    self.crossSliderInLowInViewTwoDetail.upperValue = 0.5;
    self.crossSliderInLowInViewTwoDetail.lowerValue = 0.5;
    self.crossSliderInLowInViewTwoDetail.delegate = self;
    self.crossSliderInLowInViewTwoDetail.backgroundColor = [UIColor clearColor];
    self.crossSliderInLowInViewTwoDetail.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInLowInViewTwoDetail.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInLowInViewTwoDetail.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    
    //Configure crossSliderInFXLEVELInViewTwoDetail
    self.crossSliderInFXLEVELInViewTwoDetail.minimumRange = -1.0;
    self.crossSliderInFXLEVELInViewTwoDetail.upperValue = 0.5;
    self.crossSliderInFXLEVELInViewTwoDetail.lowerValue = 0.5;
    self.crossSliderInFXLEVELInViewTwoDetail.delegate = self;
    self.crossSliderInFXLEVELInViewTwoDetail.backgroundColor = [UIColor clearColor];
    self.crossSliderInFXLEVELInViewTwoDetail.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInFXLEVELInViewTwoDetail.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInFXLEVELInViewTwoDetail.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    //Configure crossSliderInRVSENDInViewTwoForMid
    self.crossSliderInRVSENDInViewTwoForMid.minimumRange = -1.0;
    self.crossSliderInRVSENDInViewTwoForMid.upperValue = 0.5;
    self.crossSliderInRVSENDInViewTwoForMid.lowerValue = 0.5;
    self.crossSliderInRVSENDInViewTwoForMid.delegate = self;
    self.crossSliderInRVSENDInViewTwoForMid.backgroundColor = [UIColor clearColor];
    self.crossSliderInRVSENDInViewTwoForMid.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInRVSENDInViewTwoForMid.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInRVSENDInViewTwoForMid.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    //Configure crossSliderInPANInViewTwoForLow
    self.crossSliderInPANInViewTwoForLow.minimumRange = -1.0;
    self.crossSliderInPANInViewTwoForLow.upperValue = 0.5;
    self.crossSliderInPANInViewTwoForLow.lowerValue = 0.5;
    self.crossSliderInPANInViewTwoForLow.delegate = self;
    self.crossSliderInPANInViewTwoForLow.backgroundColor = [UIColor clearColor];
    self.crossSliderInPANInViewTwoForLow.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInPANInViewTwoForLow.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInPANInViewTwoForLow.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    
    // ===== Configure the cross-slider in viewThree =======
    //Configure crossSliderInViewThreeFor Reverb Send
    self.crossSliderInViewThreeForReverdSend.minimumRange = -1.0;
    self.crossSliderInViewThreeForReverdSend.upperValue = 0;
    self.crossSliderInViewThreeForReverdSend.lowerValue = 0.05;
    self.crossSliderInViewThreeForReverdSend.delegate = self;
    self.crossSliderInViewThreeForReverdSend.backgroundColor = [UIColor clearColor];
    self.crossSliderInViewThreeForReverdSend.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInViewThreeForReverdSend.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInViewThreeForReverdSend.trackImage= [UIImage imageNamed:@"drawable_green_button.9_meitu_1"];
    
    //Configure crossSliderInViewThreeFor Reverb Send
    self.crossSliderInViewThreeForReverdSend.minimumRange = -1.0;
    self.crossSliderInViewThreeForReverdSend.upperValue = 0;
    self.crossSliderInViewThreeForReverdSend.lowerValue = 0.05;
    self.crossSliderInViewThreeForReverdSend.delegate = self;
    self.crossSliderInViewThreeForReverdSend.backgroundColor = [UIColor clearColor];
    
    self.crossSliderInViewThreeForReverdSend.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInViewThreeForReverdSend.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInViewThreeForReverdSend.trackImage= [UIImage imageNamed:@"drawable_green_button.9_meitu_1"];
    
    //Configure crossSliderInHightInViewThreeDetail
    self.crossSliderInHightInViewThreeDetail.minimumRange = -1.0;
    self.crossSliderInHightInViewThreeDetail.upperValue = 0.5;
    self.crossSliderInHightInViewThreeDetail.lowerValue = 0.5;
    self.crossSliderInHightInViewThreeDetail.delegate = self;
    self.crossSliderInHightInViewThreeDetail.backgroundColor = [UIColor clearColor];
    self.crossSliderInHightInViewThreeDetail.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInHightInViewThreeDetail.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInHightInViewThreeDetail.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    //Configure crossSliderInMidInViewThreeDetail
    self.crossSliderInMidInViewThreeDetail.minimumRange = -1.0;
    self.crossSliderInMidInViewThreeDetail.upperValue = 0.5;
    self.crossSliderInMidInViewThreeDetail.lowerValue = 0.5;
    self.crossSliderInMidInViewThreeDetail.delegate = self;
    self.crossSliderInMidInViewThreeDetail.backgroundColor = [UIColor clearColor];
    self.crossSliderInMidInViewThreeDetail.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInMidInViewThreeDetail.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInMidInViewThreeDetail.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    
    //Configure crossSliderInLowInViewThreeDetail
    self.crossSliderInLowInViewThreeDetail.minimumRange = -1.0;
    self.crossSliderInLowInViewThreeDetail.upperValue = 0.5;
    self.crossSliderInLowInViewThreeDetail.lowerValue = 0.5;
    self.crossSliderInLowInViewThreeDetail.delegate = self;
    self.crossSliderInLowInViewThreeDetail.backgroundColor = [UIColor clearColor];
    self.crossSliderInLowInViewThreeDetail.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInLowInViewThreeDetail.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInLowInViewThreeDetail.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    
    //Configure crossSliderInFXLEVELInViewThreeDetail
    self.crossSliderInFXLEVELInViewThreeDetail.minimumRange = -1.0;
    self.crossSliderInFXLEVELInViewThreeDetail.upperValue = 0.5;
    self.crossSliderInFXLEVELInViewThreeDetail.lowerValue = 0.5;
    self.crossSliderInFXLEVELInViewThreeDetail.delegate = self;
    self.crossSliderInFXLEVELInViewThreeDetail.backgroundColor = [UIColor clearColor];
    self.crossSliderInFXLEVELInViewThreeDetail.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInFXLEVELInViewThreeDetail.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInFXLEVELInViewThreeDetail.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    //Configure crossSliderInRVSENDInViewThreeForMid
    self.crossSliderInRVSENDInViewThreeForMid.minimumRange = -1.0;
    self.crossSliderInRVSENDInViewThreeForMid.upperValue = 0.5;
    self.crossSliderInRVSENDInViewThreeForMid.lowerValue = 0.5;
    self.crossSliderInRVSENDInViewThreeForMid.delegate = self;
    self.crossSliderInRVSENDInViewThreeForMid.backgroundColor = [UIColor clearColor];
    self.crossSliderInRVSENDInViewThreeForMid.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInRVSENDInViewThreeForMid.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInRVSENDInViewThreeForMid.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    //Configure crossSliderInPANInViewThreeForLow
    self.crossSliderInPANInViewThreeForLow.minimumRange = -1.0;
    self.crossSliderInPANInViewThreeForLow.upperValue = 0.5;
    self.crossSliderInPANInViewThreeForLow.lowerValue = 0.5;
    self.crossSliderInPANInViewThreeForLow.delegate = self;
    self.crossSliderInPANInViewThreeForLow.backgroundColor = [UIColor clearColor];
    self.crossSliderInPANInViewThreeForLow.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInPANInViewThreeForLow.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInPANInViewThreeForLow.trackImage= [UIImage imageNamed:@"10-140430230Q0194_meitu_1"];
    
    
    // ===== Configure the cross-slider in viewThree =======
    //Configure crossSliderInViewThreeFor Reverb Send
    self.crossSliderInViewThreeForReverdSend.minimumRange = -1.0;
    self.crossSliderInViewThreeForReverdSend.upperValue = 0;
    self.crossSliderInViewThreeForReverdSend.lowerValue = 0.05;
    self.crossSliderInViewThreeForReverdSend.delegate = self;
    self.crossSliderInViewThreeForReverdSend.backgroundColor = [UIColor clearColor];
    self.crossSliderInViewThreeForReverdSend.upperHandleImageNormal = [UIImage imageNamed:@"drawable_detail_scrubber_control"];
    self.crossSliderInViewThreeForReverdSend.upperHandleImageHighlighted = [UIImage imageNamed:@"drawable_detail_scrubber_control_pressed"];
    self.crossSliderInViewThreeForReverdSend.trackImage= [UIImage imageNamed:@"drawable_green_button.9_meitu_1"];
    
    //imageViewInViewFiveDetail Click Respond
    self.imageViewSMALLInViewFourDetail.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImageViewSMALL)];
    [self.imageViewSMALLInViewFourDetail addGestureRecognizer:singleTap];
    
    self.imageViewMIDInViewFourDetail.userInteractionEnabled=YES;
    singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImageViewMID)];
    [self.imageViewMIDInViewFourDetail addGestureRecognizer:singleTap];
    
    self.imageViewLARGEInViewFourDetail.userInteractionEnabled=YES;
    singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImageViewLARGE)];
    [self.imageViewLARGEInViewFourDetail addGestureRecognizer:singleTap];
    
    self.imageViewKARAOKEInViewFourDetail.userInteractionEnabled=YES;
    singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImageViewKARAOKE)];
    [self.imageViewKARAOKEInViewFourDetail addGestureRecognizer:singleTap];
    
    
    
    // BT Serial Port
    self.btSerialPort = [[BTSerialPort alloc] init];
    self.btSerialPort.delegate = self;
    
    
    bleDataFormat = [[BleDataFormat alloc] init];
    //测试
//    NSString *myNSString = @"This is a test code block";
//    const char *myChar = [myNSString cStringUsingEncoding: [NSString defaultCStringEncoding]];
//    NSLog(@"字符：%x", myChar[2]);
}



#pragma mark - Dialog
- (void)showAction:(id)sender{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 250)];
    
    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = 20;
    welcomeLabelRect.size.height = 20;
    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:17];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"Welcome to KGModal!";
    welcomeLabel.font = welcomeLabelFont;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.shadowColor = [UIColor blackColor];
    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:welcomeLabel];
    
    CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
    infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect)+5;
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect) + 50;
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
    infoLabel.text = @"KGModal is an easy drop in control that allows you to display any view "
    "in a modal popup. The modal will automatically scale to fit the content view "
    "and center it on screen with nice animations!";
    infoLabel.numberOfLines = 6;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.shadowColor = [UIColor blackColor];
    infoLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:infoLabel];
    
    /*
    CGFloat btnY = CGRectGetMaxY(infoLabelRect)+5;
    CGFloat btnH = CGRectGetMaxY(contentView.frame)-5 - btnY;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(infoLabelRect.origin.x, btnY, infoLabelRect.size.width, btnH);
    [btn setTitle:@"Close Button Right" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeCloseButtonType:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btn];
     */
    KGModal *modal = [KGModal sharedInstance];
    modal.closeButtonType = KGModalCloseButtonTypeRight;
    //    [[KGModal sharedInstance] setCloseButtonLocation:KGModalCloseButtonLocationRight];
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
}


- (void)willShow:(NSNotification *)notification{
    NSLog(@"will show");
}


- (void)didShow:(NSNotification *)notification{
    NSLog(@"did show");
}

- (void)willHide:(NSNotification *)notification{
    NSLog(@"will hide");
}

- (void)didHide:(NSNotification *)notification{
    NSLog(@"did hide");
}

- (void)changeCloseButtonType:(id)sender{
    UIButton *button = (UIButton *)sender;
    KGModal *modal = [KGModal sharedInstance];
    KGModalCloseButtonType type = modal.closeButtonType;
    
    if(type == KGModalCloseButtonTypeLeft){
        modal.closeButtonType = KGModalCloseButtonTypeRight;
        [button setTitle:@"Close Button Right" forState:UIControlStateNormal];
    }else if(type == KGModalCloseButtonTypeRight){
        modal.closeButtonType = KGModalCloseButtonTypeNone;
        [button setTitle:@"Close Button None" forState:UIControlStateNormal];
    }else{
        modal.closeButtonType = KGModalCloseButtonTypeLeft;
        [button setTitle:@"Close Button Left" forState:UIControlStateNormal];
    }
}


#pragma mark - CrossSlider Delegate
- (void)rangeSlider:(NMRangeSlider *)slider begineChangedWithEvent:(UIEvent *)event{
   
    NSLog(@"slider begine changing value = %f", slider.upperValue);
}

- (void)rangeSlider:(NMRangeSlider *)slider continueChangeWithEvent:(UIEvent *)event{
    
    NSLog(@"slider continue changing value = %f", slider.upperValue);
}

- (void)rangeSlider:(NMRangeSlider *)slider endChangeWithEvent:(UIEvent *)event{
    
    NSLog(@"slider end changing value = %f", slider.upperValue);
}

#pragma mark - Slider设置
- (void)setImageForSlider:(UISlider*)slider{
    
    [slider setThumbImage:[UIImage imageNamed:@"drawable_seekbar_thumb_normal.png"] forState:UIControlStateNormal];
    [slider setThumbImage:[UIImage imageNamed:@"drawable_seekbar_thumb_press"] forState:UIControlStateHighlighted];
}

- (UISlider*)addNewSliderToView: (UIView*)View withTitle:(NSString*)title{
    
    UISlider* slider = [[UISlider alloc] init];
    CGRect frame;
    
    //slider，通过sliderValueLabel的相对位置定义frame
    frame.origin.x = (averageWidth - 25) * 0.88 - (height - 135) * 0.83 * 0.5;
    frame.origin.y = (height - 135) * 0.5 + 57;
    frame.size.width = (height - 135) * 0.83;
    frame.size.height = 40;
    
    slider = [[UISlider alloc]initWithFrame:frame];
    slider.minimumValue = -20;//最小值
    slider.maximumValue = 20;//最大值
    
    [self setImageForSlider:slider];
    

    slider.transform = CGAffineTransformMakeRotation(M_PI_2 * 3);
    
    slider.value = 0;//执行初始值
    
    if (View == self.viewOne)
    {
        sliderValueLabelOne = [[UILabel alloc] init];
//        sliderValueLabelOne.frame = self.labelInViewOne.frame;
        sliderValueLabelOne.frame = CGRectMake(self.labelInViewOne.frame.origin.x, self.labelInViewOne.frame.origin.y, self.labelInViewOne.frame.size.width + averageWidth - 120, self.labelInViewFour.frame.size.height);
        sliderValueLabelOne.backgroundColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:0];
        sliderValueLabelOne.textAlignment =  NSTextAlignmentCenter;
        sliderValueLabelOne.font = [UIFont fontWithName:@"Arial-BoldMT" size:18.f];
        sliderValueLabelOne.text = @"CH1";
        //加入到viewOne中
        [self.viewOne addSubview:sliderValueLabelOne];
        
        [slider setMinimumTrackImage:[UIImage imageNamed:@"drawable_slider_gray.png"] forState:UIControlStateNormal];
        [slider setMaximumTrackImage:[UIImage imageNamed:@"drawable_slider_black.png"] forState:UIControlStateNormal];
        
        [slider addTarget:self action:@selector(sliderOneValueChanged) //处理事件的方法
         forControlEvents:UIControlEventValueChanged//具体事件
         ];

        [slider addTarget:self //事件委托对象
                   action:@selector(sliderOneValueChangedFinish) //处理事件的方法
         forControlEvents:UIControlEventTouchUpInside//具体事件
         ];

    }
    
    if (View == self.viewTwo)
    {
        sliderValueLabelTwo = [[UILabel alloc] init];
//        sliderValueLabelTwo.frame = self.labelInViewTwo.frame;
        sliderValueLabelTwo.frame = CGRectMake(self.labelInViewTwo.frame.origin.x, self.labelInViewTwo.frame.origin.y, self.labelInViewTwo.frame.size.width + averageWidth - 120, self.labelInViewFour.frame.size.height);
        sliderValueLabelTwo.backgroundColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:0];
        sliderValueLabelTwo.textAlignment =  NSTextAlignmentCenter;
        sliderValueLabelTwo.font = [UIFont fontWithName:@"Arial-BoldMT" size:18.f];
        sliderValueLabelTwo.text = @"CH2";
        //加入到viewOne中
        [self.viewTwo addSubview:sliderValueLabelTwo];
        
        [slider setMinimumTrackImage:[UIImage imageNamed:@"drawable_slider_gray.png"] forState:UIControlStateNormal];
        [slider setMaximumTrackImage:[UIImage imageNamed:@"drawable_slider_black.png"] forState:UIControlStateNormal];
        
        //设置响应事件(此操作同：使用xib中时将事件与操作IBAction进行关联)
        [slider addTarget:self //事件委托对象
                   action:@selector(sliderTwoValueChanged) //处理事件的方法
         forControlEvents:UIControlEventValueChanged//具体事件
         ];
        
        [slider addTarget:self //事件委托对象
                   action:@selector(sliderTwoValueChangedFinish) //处理事件的方法
         forControlEvents:UIControlEventTouchUpInside//具体事件
         ];
    }
    
    if (View == self.viewThree)
    {
        sliderValueLabelThree = [[UILabel alloc] init];
//        sliderValueLabelThree.frame = self.labelInViewThree.frame;
        sliderValueLabelThree.frame = CGRectMake(self.labelInViewThree.frame.origin.x, self.labelInViewThree.frame.origin.y, self.labelInViewThree.frame.size.width + averageWidth - 120, self.labelInViewFour.frame.size.height);
        sliderValueLabelThree.backgroundColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:0];
        sliderValueLabelThree.textAlignment =  NSTextAlignmentCenter;
        sliderValueLabelThree.font = [UIFont fontWithName:@"Arial-BoldMT" size:18.f];
        sliderValueLabelThree.text = @"Bt/Aux";
        //加入到viewOne中
        [self.viewThree addSubview:sliderValueLabelThree];
        
        [slider setMinimumTrackImage:[UIImage imageNamed:@"drawable_slider_blue.png"] forState:UIControlStateNormal];
        [slider setMaximumTrackImage:[UIImage imageNamed:@"drawable_slider_black.png"] forState:UIControlStateNormal];
        
        //设置响应事件(此操作同：使用xib中时将事件与操作IBAction进行关联)
        [slider addTarget:self //事件委托对象
                   action:@selector(sliderThreeValueChanged) //处理事件的方法
         forControlEvents:UIControlEventValueChanged//具体事件
         ];
        
        [slider addTarget:self //事件委托对象
                   action:@selector(sliderThreeValueChangedFinish) //处理事件的方法
         forControlEvents:UIControlEventTouchUpInside//具体事件
         ];
    }
    
    if (View == self.viewFour)
    {
        sliderValueLabelFour= [[UILabel alloc] init];
//        sliderValueLabelFour.frame = self.labelInViewFour.frame;
        sliderValueLabelFour.frame = CGRectMake(self.labelInViewFour.frame.origin.x, self.labelInViewFour.frame.origin.y, self.labelInViewFour.frame.size.width + averageWidth - 120, self.labelInViewFour.frame.size.height);
        sliderValueLabelFour.backgroundColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:0];
        sliderValueLabelFour.textAlignment = NSTextAlignmentCenter;
        sliderValueLabelFour.font = [UIFont fontWithName:@"Arial-BoldMT" size:18.f];
        sliderValueLabelFour.text = @"Reverb";
        //加入到viewOne中
        [self.viewFour addSubview:sliderValueLabelFour];
        
        [slider setMinimumTrackImage:[UIImage imageNamed:@"drawable_slider_green.png"] forState:UIControlStateNormal];
        [slider setMaximumTrackImage:[UIImage imageNamed:@"drawable_slider_black.png"] forState:UIControlStateNormal];
        
        //设置响应事件(此操作同：使用xib中时将事件与操作IBAction进行关联)
        [slider addTarget:self //事件委托对象
                   action:@selector(sliderFourValueChanged) //处理事件的方法
         forControlEvents:UIControlEventValueChanged//具体事件
         ];
        
        [slider addTarget:self //事件委托对象
                   action:@selector(sliderFourValueChangedFinish) //处理事件的方法
         forControlEvents:UIControlEventTouchUpInside//具体事件
         ];
    }
    
    if (View == self.viewFive)
    {
        sliderValueLabelFive = [[UILabel alloc] init];
//        sliderValueLabelFive.frame = self.labelInViewFive.frame;
        sliderValueLabelFive.frame = CGRectMake(self.labelInViewFive.frame.origin.x, self.labelInViewFive.frame.origin.y, self.labelInViewFive.frame.size.width + averageWidth - 120, self.labelInViewFour.frame.size.height);
        sliderValueLabelFive.backgroundColor = [UIColor colorWithRed:93/255.0 green:93/255.0 blue:93/255.0 alpha:0];
        sliderValueLabelFive.textAlignment =  NSTextAlignmentCenter;
        sliderValueLabelFive.font = [UIFont fontWithName:@"Arial-BoldMT" size:18.f];
        sliderValueLabelFive.textColor = [UIColor whiteColor];
        sliderValueLabelFive.text = @"Main";
        //加入到viewOne中
        [self.viewFive addSubview:sliderValueLabelFive];
        
        [slider setMinimumTrackImage:[UIImage imageNamed:@"drawable_slider_gray.png"] forState:UIControlStateNormal];
        [slider setMaximumTrackImage:[UIImage imageNamed:@"drawable_slider_black.png"] forState:UIControlStateNormal];
        
        //设置响应事件(此操作同：使用xib中时将事件与操作IBAction进行关联)
        [slider addTarget:self //事件委托对象
                   action:@selector(sliderFiveValueChanged) //处理事件的方法
         forControlEvents:UIControlEventValueChanged//具体事件
         ];
        
        [slider addTarget:self //事件委托对象
                   action:@selector(sliderFiveValueChangedFinish) //处理事件的方法
         forControlEvents:UIControlEventTouchUpInside//具体事件
         ];
    }

    //加入到view中
    [View addSubview:slider];

    return slider;
}



-(void)sliderOneInit
{
    sliderOne = [self addNewSliderToView:self.viewOne withTitle:@"CH1"];
}


-(void)sliderTwoInit
{
    sliderTwo = [self addNewSliderToView:self.viewTwo withTitle:@"CH2"];
}

-(void)sliderThreeInit
{
    sliderThree = [self addNewSliderToView:self.viewThree withTitle:@"Bt/Aux"];
}

-(void)sliderFourInit
{
    sliderFour = [self addNewSliderToView:self.viewFour withTitle:@"Reverb"];
}

-(void)sliderFiveInit
{
    sliderFive = [self addNewSliderToView:self.viewFive withTitle:@"Main"];
}



//sliderOne值改变时进行处理
-(void)sliderOneValueChanged{
    //更新sliderValueLabel的值
    self.sliderValueLabelOne.text = [[NSString alloc]initWithFormat:@"%.0f"@"dB",sliderOne.value];
}

//sliderTwo值改变时进行处理
-(void)sliderTwoValueChanged{
    //更新sliderValueLabel的值
    self.sliderValueLabelTwo.text = [[NSString alloc]initWithFormat:@"%.0f"@"dB",sliderTwo.value];
}

//sliderThree值改变时进行处理
-(void)sliderThreeValueChanged{
    //更新sliderValueLabel的值
    self.sliderValueLabelThree.text = [[NSString alloc]initWithFormat:@"%.0f"@"dB",sliderThree.value];
}

//sliderFour值改变时进行处理
-(void)sliderFourValueChanged{
    //更新sliderValueLabel的值
    self.sliderValueLabelFour.text = [[NSString alloc]initWithFormat:@"%.0f"@"dB",sliderFour.value];
}

//sliderFive值改变时进行处理
-(void)sliderFiveValueChanged{
    //更新sliderValueLabel的值
    self.sliderValueLabelFive.text = [[NSString alloc]initWithFormat:@"%.0f"@"dB",sliderFive
                                      .value];
}

//sliderOne停止触摸时进行处理
-(void)sliderOneValueChangedFinish{
     self.sliderValueLabelOne.text = [[NSString alloc]initWithFormat:@"CH1"];
}

//sliderTwo停止触摸时进行处理
-(void)sliderTwoValueChangedFinish{
     self.sliderValueLabelTwo.text = [[NSString alloc]initWithFormat:@"CH2"];
}

//sliderThree停止触摸时进行处理
-(void)sliderThreeValueChangedFinish{
    self.sliderValueLabelThree.text = [[NSString alloc]initWithFormat:@"Bt/Aux"];
}

//sliderFour停止触摸时进行处理
-(void)sliderFourValueChangedFinish{
    self.sliderValueLabelFour.text = [[NSString alloc]initWithFormat:@"Reverb"];
}

//sliderFive停止触摸时进行处理
-(void)sliderFiveValueChangedFinish{
    self.sliderValueLabelFive.text = [[NSString alloc]initWithFormat:@"Main"];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - view detail button
- (IBAction)btnOneTapped:(UIButton *)sender {
    
    if (self.displayStatus == NoFold) {
        // Fold the views
        self.displayStatus = FromBtnOne;
        
        self.btnInViewOne.hidden = YES;
        self.btnVerticalInViewOne.hidden = NO;
        
        NSLog(@"button1.1按下！");
    
        [UIView animateWithDuration:self.animationTime animations:^{
            
            self.viewOne.frame = self.viewOneOriginalFrame;
            self.viewTwo.frame = self.viewHideOriginalFrame;
            self.viewFour.frame = self.viewHideOriginalFrame;
            self.viewThree.frame = self.viewHideOriginalFrame;
            
            self.viewOneDetail.hidden = NO;
            self.viewTwoDetail.hidden = YES;
            self.viewThreeDetail.hidden = YES;
            self.viewFourDetail.hidden = YES;

            
        } completion:^(BOOL finished) {

            [self.view bringSubviewToFront:self.viewOneDetail];
            
            CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 4, 0);
            [self.viewFour setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewFour];
            
            myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
            [self.viewThree setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewThree];
            
            myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
            [self.viewTwo setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewTwo];
            
            myTransform = CGAffineTransformMakeTranslation(0, 0);
            [self.viewOne setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewOne];
            
            self.viewOne.layer.shadowColor = [UIColor darkGrayColor].CGColor;
            self.viewOne.layer.shadowOffset = CGSizeMake(2, 0);
            self.viewOne.layer.shadowOpacity = 1.0;
        }];
       
    }
    else if (self.displayStatus == FromBtnOne) {
        
        self.displayStatus = NoFold;
        // Move all views to its original postion
        
        
        [self recoverDisplayByClickBtn:sender];
        self.viewOne.layer.shadowOpacity =  0.0;

    }
    
}



- (IBAction)btnTwoTapped:(UIButton *)sender {
    
    //[self doAnimationFromView:self.viewTwo];
    
    if (self.displayStatus == NoFold) {
        // Fold the views
        
        self.displayStatus = FromBtnTwo;
        
        self.btnInViewTwo.hidden = YES;
        self.btnVerticalInViewTwo.hidden = NO;
         NSLog(@"button2.1按下！");
        
        [UIView animateWithDuration:self.animationTime animations:^{
            
            self.viewTwo.frame = self.viewOneOriginalFrame;
            self.viewOne.frame = self.viewHideOriginalFrame;
            self.viewFour.frame = self.viewHideOriginalFrame;
            self.viewThree.frame = self.viewHideOriginalFrame;
            
            self.viewTwoDetail.hidden = NO;
            self.viewOneDetail.hidden = YES;
            self.viewThreeDetail.hidden = YES;
            self.viewFourDetail.hidden = YES;

        } completion:^(BOOL finished) {
            
            [self.view bringSubviewToFront:self.viewTwoDetail];
            
            CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 4, 0);
            [self.viewFour setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewFour];
            
            myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
            [self.viewThree setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewThree];
            
            myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
            [self.viewTwo setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewTwo];
            
            myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
            [self.viewOne setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewOne];
            
            self.viewTwo.layer.shadowColor = [UIColor darkGrayColor].CGColor;
            self.viewTwo.layer.shadowOffset = CGSizeMake(2, 0);
            self.viewTwo.layer.shadowOpacity = 1.0;
        }];
        
    }
    else if (self.displayStatus == FromBtnTwo) {
        
        
        self.displayStatus = NoFold;
        
        // Move all views to its original postion
        [self recoverDisplayByClickBtn:sender];
         self.viewTwo.layer.shadowOpacity =  0.0;
    }

    
}

- (IBAction)btnThreeTapped:(UIButton *)sender {
    
    if (self.displayStatus == NoFold) {
        // Fold the views
        
        self.displayStatus = FromBtnThree;
        
        self.btnInViewThree.hidden = YES;
        self.btnVerticalInViewThree.hidden = NO;
         NSLog(@"button3.1按下！");
        [UIView animateWithDuration:self.animationTime animations:^{
            
            self.viewThree.frame = self.viewOneOriginalFrame;
            self.viewOne.frame = self.viewHideOriginalFrame;
            self.viewTwo.frame = self.viewHideOriginalFrame;
            self.viewFour.frame = self.viewHideOriginalFrame;
            
            self.viewThreeDetail.hidden = NO;
            self.viewOneDetail.hidden = YES;
            self.viewTwoDetail.hidden = YES;
            self.viewFourDetail.hidden = YES;
    
        } completion:^(BOOL finished) {
            
            [self.view bringSubviewToFront:self.viewThreeDetail];
            
            CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 4, 0);
            [self.viewFour setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewFour];
            
            myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
            [self.viewThree setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewThree];
            
            myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
            [self.viewTwo setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewTwo];
            
            myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
            [self.viewOne setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewOne];
            
            self.viewThree.layer.shadowColor = [UIColor darkGrayColor].CGColor;
            self.viewThree.layer.shadowOffset = CGSizeMake(2, 0);
            self.viewThree.layer.shadowOpacity = 1.0;
            }];
    }
    else if (self.displayStatus == FromBtnThree) {
        
        
        self.displayStatus = NoFold;
        
        // Move all views to its original postion
        [self recoverDisplayByClickBtn:sender];
        self.viewThree.layer.shadowOpacity =  0.0;
       
    }

}

- (IBAction)btnFourTapped:(UIButton *)sender {
    
    if (self.displayStatus == NoFold) {
        // Fold the views
        
        self.displayStatus = FromBtnFour;
        
        self.btnInViewFour.hidden = YES;
        self.btnVerticalInViewFour.hidden = NO;
        
        NSLog(@"button4.1按下！");
        [UIView animateWithDuration:self.animationTime animations:^{
            
            self.viewFour.frame = self.viewOneOriginalFrame;
            self.viewOne.frame = self.viewHideOriginalFrame;
            self.viewTwo.frame = self.viewHideOriginalFrame;
            self.viewThree.frame = self.viewHideOriginalFrame;
            
            self.viewFourDetail.hidden = NO;
            self.viewOneDetail.hidden = YES;
            self.viewTwoDetail.hidden = YES;
            self.viewThreeDetail.hidden = YES;

            
        } completion:^(BOOL finished) {
            
            [self.view bringSubviewToFront:self.viewFourDetail];
            
            CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
            [self.viewFour setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewFour];
            
            myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
            [self.viewThree setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewThree];
            
            myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
            [self.viewTwo setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewTwo];
            
            myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
            [self.viewOne setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewOne];
            
            self.viewFour.layer.shadowColor = [UIColor darkGrayColor].CGColor;
            self.viewFour.layer.shadowOffset = CGSizeMake(2, 0);
            self.viewFour.layer.shadowOpacity = 1.0;
        }];
    }
    else if (self.displayStatus == FromBtnFour) {
        
        
        self.displayStatus = NoFold;
        
        // Move all views to its original postion
        [self recoverDisplayByClickBtn:sender];
        self.viewFour.layer.shadowOpacity =  0.0;

    }
    
}

- (IBAction)btnFiveTapped:(UIButton *)sender {
    
    if (btnInViewFiveDetailStatus == true) {
        
        btnInViewFiveDetailStatus = false;
        self.btnInViewFive.hidden = YES;
        self.btnVerticalInViewFive.hidden = NO;
        
        NSLog(@"button5.1按下！");
//        if (btnInViewFiveFirstTimeFlag){
//            
//            btnInViewFiveFirstTimeFlag = false;
//            CATransition *transition = [CATransition animation];
//            transition.duration = 0.2f;
//            transition.type = kCATransitionReveal;
//            transition.subtype = kCATransitionFromRight;
//            [self.viewFiveDetail.layer addAnimation:transition forKey:nil];
//            [self.view  addSubview:self.viewFiveDetail];
//            [self.view bringSubviewToFront:self.viewFiveDetail];
//            [self.view bringSubviewToFront:self.viewFive];
//        }
//
//        CATransition *transition = [CATransition animation];
//        transition.duration = 0.2f;
//        transition.type =  kCATransitionPush;
//        transition.subtype = kCATransitionFromRight;
//        [self.viewFiveDetail.layer addAnimation:transition forKey:nil];
//        [self.view  addSubview:self.viewFiveDetail];
//        [self.view bringSubviewToFront:self.viewFiveDetail];
//        [self.view bringSubviewToFront:self.viewFive];
//
        CATransition *transition = [CATransition animation];
        transition.duration = 0.2f;
        transition.type =  kCATransitionMoveIn;
        transition.subtype = kCATransitionFromRight;
        [self.viewFiveDetail.layer addAnimation:transition forKey:nil];
        [self.view  addSubview:self.viewFiveDetail];
        [self.view bringSubviewToFront:self.viewFiveDetail];
        [self.view bringSubviewToFront:self.viewFive];
        self.viewFiveDetail.hidden = NO;
//        [UIView animateWithDuration:self.animationTime animations:^{
//
//            self.viewFiveDetail.frame = self.viewFiveDetailHideFrame;
//            
//        } completion:^(BOOL finished) {
//            [self.view bringSubviewToFront:self.viewFiveDetail];
//            [self.view bringSubviewToFront:self.viewFive];
//        }];
//        
//        [UIView animateWithDuration:self.animationTime animations:^{
//    
//            self.viewFiveDetail.frame = self.viewFiveDetailOriginalFrame;
//            
//        } completion:^(BOOL finished) {
//        
//            [self.view bringSubviewToFront:self.viewFiveDetail];
//            [self.view bringSubviewToFront:self.viewFive];
//            self.viewFiveDetail.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//            self.viewFiveDetail.layer.shadowOffset = CGSizeMake(2, 0);
//            self.viewFiveDetail.layer.shadowOpacity = 1.0;
//
//        }];

    }
    else{
        
        btnInViewFiveDetailStatus = true;
        
        // Move all views to its original postion
        [self recoverDisplayByClickBtn:sender];
        self.viewFour.layer.shadowOpacity =  0.0;
        
    }

}


// 按键恢复，更换图片和动画效果
- (void)recoverDisplayByClickBtn:(UIButton*)button{
    
    if (button == self.btnVerticalInViewOne){
        NSLog(@"button1按下");
    }
    
    if (button == self.btnVerticalInViewTwo){
        NSLog(@"button2按下");
    }
    
    if (button == self.btnVerticalInViewThree){
        NSLog(@"button3按下");
    }
    
    if (button == self.btnVerticalInViewFour){
        NSLog(@"button4按下");
    }
    
    if (button == self.btnVerticalInViewFive){
        NSLog(@"button5按下");
    }
    
    
    if (button == self.btnVerticalInViewFive){
        self.btnVerticalInViewFive.hidden = YES;
        self.btnInViewFive.hidden = NO;
        
        if (self.displayStatus == NoFold){
            CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0, 0);
            [self.viewFour setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewFour];
            
            myTransform = CGAffineTransformMakeTranslation(0, 0);
            [self.viewThree setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewThree];
            
            myTransform = CGAffineTransformMakeTranslation(0, 0);
            [self.viewTwo setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewTwo];
            
            myTransform = CGAffineTransformMakeTranslation(0, 0);
            [self.viewOne setTransform:myTransform];
            [self.view bringSubviewToFront:self.viewOne];
            
            CATransition *transition = [CATransition animation];
            transition.duration = 0.2f;
            transition.type =   kCATransitionReveal;
            transition.subtype = kCATransitionFromLeft;
            [self.viewFiveDetail.layer addAnimation:transition forKey:nil];
            [self.view  addSubview:self.viewFiveDetail];
            [self.view bringSubviewToFront:self.viewFiveDetail];
            [self.view bringSubviewToFront:self.viewFive];
            [self.viewFiveDetail sendSubviewToBack:self.viewFiveDetail];
            self.viewFiveDetail.hidden = YES;
            
        }else{
            
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3f;
            transition.type =   kCATransitionReveal;
            transition.subtype = kCATransitionFromLeft;
            [self.viewFiveDetail.layer addAnimation:transition forKey:nil];
            [self.view  addSubview:self.viewFiveDetail];
            [self.view bringSubviewToFront:self.viewFiveDetail];
            [self.view bringSubviewToFront:self.viewFive];
            [self.viewFiveDetail sendSubviewToBack:self.viewFiveDetail];
            self.viewFiveDetail.hidden = YES;
        }
        
    }else{
        self.btnVerticalInViewOne.hidden = YES;
        self.btnInViewOne.hidden = NO;
        
        self.btnVerticalInViewTwo.hidden = YES;
        self.btnInViewTwo.hidden = NO;
        
        self.btnVerticalInViewThree.hidden = YES;
        self.btnInViewThree.hidden = NO;
        
        self.btnVerticalInViewFour.hidden = YES;
        self.btnInViewFour.hidden = NO;
        
        
        [UIView animateWithDuration:self.animationTime animations:^{
            
            self.viewOne.frame = self.viewOneOriginalFrame;
            self.viewTwo.frame = self.viewTwoOriginalFrame;
            self.viewThree.frame = self.viewThreeOriginalFrame;
            self.viewFour.frame = self.viewFourOriginalFrame;
            
        } completion:^(BOOL finished) {
            if (finished) {
                self.viewOne.layer.shadowColor = [UIColor clearColor].CGColor;
                self.viewOne.layer.shadowOffset = CGSizeMake(2, 0);
                self.viewOne.layer.shadowOpacity = 1.0;
                
                self.viewTwo.layer.shadowColor = [UIColor clearColor].CGColor;
                self.viewTwo.layer.shadowOffset = CGSizeMake(2, 0);
                self.viewTwo.layer.shadowOpacity = 1.0;
                
                self.viewThree.layer.shadowColor = [UIColor clearColor].CGColor;
                self.viewThree.layer.shadowOffset = CGSizeMake(2, 0);
                self.viewThree.layer.shadowOpacity = 1.0;
                
                self.viewFour.layer.shadowColor = [UIColor clearColor].CGColor;
                self.viewFour.layer.shadowOffset = CGSizeMake(2, 0);
                self.viewFour.layer.shadowOpacity = 1.0;
                
            }
            
        }];
    }
    
}



#pragma mark - Substitute和SOLO按键
- (IBAction)btnFourSubstituteInViewOneDetail:(id)sender {
    
    /*
    self.displayStatus = FromBtnFour;
    
    self.btnInViewFour.hidden = YES;
    self.btnVerticalInViewFour.hidden = NO;
    self.viewOneDetail.hidden = NO;
    self.viewFourDetail.hidden = NO;
    
    //左按键viewxxxDetail切换动画效果
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type =  kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [self.viewOneDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewOneDetail];
    [self.view bringSubviewToFront:self.viewOneDetail];
    
    transition.duration = 0.2f;
    transition.type =  kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.viewFourDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewFourDetail];
    [self.view bringSubviewToFront:self.viewFourDetail];
    [self.view bringSubviewToFront:self.viewFive];
    
    //左按键Viewxxx的显示效果
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewFour setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewFour];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewThree setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewThree];
    
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
    [self.viewTwo setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewTwo];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
    [self.viewOne setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewOne];
    
    
    //添加阴影效果
    self.viewFour.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.viewFour.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewFour.layer.shadowOpacity = 1.0;
    */

//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = [[UIViewController alloc] init];
//    self.window.rootViewController.view.backgroundColor = [UIColor colorWithRed:0.441 green:0.466 blue:1.000 alpha:1.000];
    
//    CGRect showButtonRect = CGRectZero;
//    showButtonRect.size = CGSizeMake(200, 62);
//    showButtonRect.origin.x = round(CGRectGetMidX(self.window.rootViewController.view.bounds)-CGRectGetMidX(showButtonRect));
//    showButtonRect.origin.y = CGRectGetHeight(self.window.rootViewController.view.bounds)-CGRectGetHeight(showButtonRect)-10;
//    UIButton *showButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    showButton.frame = showButtonRect;
//    showButton.autoresizingMask =
//    UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
//    [showButton setTitle:@"Show Modal" forState:UIControlStateNormal];
//    [showButton addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.window.rootViewController.view addSubview:showButton];
//    
//    [KGModal sharedInstance].closeButtonType = KGModalCloseButtonTypeRight;
//    
//    [self.window makeKeyAndVisible];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShow:) name:KGModalWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didShow:) name:KGModalDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHide:) name:KGModalWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didHide:) name:KGModalDidHideNotification object:nil];

   
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, averageWidth * 2.8, height * 0.85)];
    
    //VOICE MODE label
    CGRect dialogVOICEMODEVLabelRect = contentView.bounds;
    dialogVOICEMODEVLabelRect.origin.x = 10;
    dialogVOICEMODEVLabelRect.origin.y = 10;
    dialogVOICEMODEVLabelRect.size.height = 20;
    dialogVOICEMODEVLabelRect.size.width = 200;
    UIFont *dialogVOICEMODEVLabelFont = [UIFont boldSystemFontOfSize:17];
    UILabel *dialogVOICEMODEVLabel = [[UILabel alloc] initWithFrame:dialogVOICEMODEVLabelRect];
    dialogVOICEMODEVLabel.text = @"VOICE MODE:";
    dialogVOICEMODEVLabel.font = dialogVOICEMODEVLabelFont;
    dialogVOICEMODEVLabel.textColor = [UIColor blackColor];
    dialogVOICEMODEVLabel.textAlignment = NSTextAlignmentLeft;
    dialogVOICEMODEVLabel.backgroundColor = [UIColor clearColor];
    [contentView addSubview:dialogVOICEMODEVLabel];
    
//    CGRect infoDialogVOICEMODEViewRect = CGRectInset(contentView.bounds, 5, 5);
//    infoDialogVOICEMODEViewRect.origin.y = CGRectGetMaxY(welcomeLabelRect)+5;
//    infoDialogVOICEMODEViewRect.size.height -= CGRectGetMinY(infoDialogVOICEMODEViewRect) + 50;
//    UIView *dialogVOICEMODEView = [[UIView alloc] initWithFrame:infoDialogVOICEMODEViewRect];
//    dialogVOICEMODEView.layer.masksToBounds = NO;
//    dialogVOICEMODEView.layer.shadowColor = [UIColor blackColor].CGColor;
//    dialogVOICEMODEView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
//    dialogVOICEMODEView.layer.shadowOpacity = 0.5f;
//    [contentView addSubview:dialogVOICEMODEView];
    
    //VOICE MODE按键背景框
    CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
    infoLabelRect.origin.x = 10;
    infoLabelRect.origin.y = CGRectGetMaxY(dialogVOICEMODEVLabelRect)+5;
    infoLabelRect.size.width = averageWidth * 2.8 - 20;
    infoLabelRect.size.height = height * 0.85 * 0.51;
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
    infoLabel.text = @"";
    infoLabel.numberOfLines = 6;
    infoLabel.textColor = [UIColor blackColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.shadowColor = [UIColor clearColor];
    infoLabel.shadowOffset = CGSizeMake(0, 1);
    infoLabel.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    infoLabel.layer.borderWidth = 1;//边框宽度
    [contentView addSubview:infoLabel];
    
    //===================Dailog VOICE MODE 按键========================//
    //MALE VOCAL按键
    CGRect dialogVOICEMODEVBtnRect = contentView.bounds;
    dialogVOICEMODEVBtnRect.origin.x = 20;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogVOICEMODEVLabelRect)+15;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnMALEVOCAL = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnMALEVOCAL setTitle:@"MALE\r\nVOCAL" forState:UIControlStateNormal];
    //设置title的字体居中
    btnMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnMALEVOCAL.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnMALEVOCAL.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnMALEVOCAL.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInVOICEMODE == 1)
    {
        //设置标题的颜色
        [btnMALEVOCAL setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }
    
    [btnMALEVOCAL addTarget:self action:@selector(btnMALEVOCALInVOICEMODEInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnMALEVOCAL];
    
    //FEMALE VOCAL按键
    dialogVOICEMODEVBtnRect.origin.x = 20 + (averageWidth * 2.8 - 20 - 50) * 0.25 + 10;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogVOICEMODEVLabelRect)+15;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnFEMALEVOCAL = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnFEMALEVOCAL setTitle:@"FEMALE\r\nVOCAL" forState:UIControlStateNormal];
    //设置title的字体居中
    btnFEMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnFEMALEVOCAL.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnFEMALEVOCAL.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnFEMALEVOCAL.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInVOICEMODE == 2)
    {
        //设置标题的颜色
        [btnFEMALEVOCAL setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnFEMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }
    
    [btnFEMALEVOCAL addTarget:self action:@selector(btnFEMALEVOCALInVOICEMODEInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnFEMALEVOCAL];
    
    //ELECTRIC GUITAR按键
    dialogVOICEMODEVBtnRect.origin.x = 20 + (averageWidth * 2.8 - 20 - 50) * 0.25 * 2 + 10 * 2;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogVOICEMODEVLabelRect)+15;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnELECTRICGUITAR = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnELECTRICGUITAR setTitle:@"ELECTRIC\r\nGUITAR" forState:UIControlStateNormal];
    //设置title的字体居中
    btnELECTRICGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnELECTRICGUITAR.titleLabel.lineBreakMode = 0;
   
    //设置标题的字体大小
    if (width < 600)
    {
        [btnELECTRICGUITAR.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnELECTRICGUITAR.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInVOICEMODE == 3)
    {
        //设置标题的颜色
        [btnELECTRICGUITAR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnELECTRICGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }

    
    [btnELECTRICGUITAR addTarget:self action:@selector(btnELECTRICGUITARInVOICEMODEInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnELECTRICGUITAR];
    
    //NYLON ACOUSTIC按键
    dialogVOICEMODEVBtnRect.origin.x = 20 + (averageWidth * 2.8 - 20 - 50) * 0.25 * 3 + 10 * 3;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogVOICEMODEVLabelRect)+15;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnNYLONACOUSTIC = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnNYLONACOUSTIC setTitle:@"NYLON\r\nACOUSTIC" forState:UIControlStateNormal];
    //设置title的字体居中
    btnNYLONACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnNYLONACOUSTIC.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnNYLONACOUSTIC.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnNYLONACOUSTIC.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInVOICEMODE == 4)
    {
        //设置标题的颜色
        [btnNYLONACOUSTIC setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnNYLONACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }
    
    [btnNYLONACOUSTIC addTarget:self action:@selector(btnNYLONACOUSTICInVOICEMODEInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnNYLONACOUSTIC];
    
    //STEEL ACOUSTIC按键
    dialogVOICEMODEVBtnRect.origin.x = 20;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogVOICEMODEVLabelRect)+15 + (height * 0.85 * 0.51 - 40) * 0.33 + 10;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnSTEELACOUSTIC = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnSTEELACOUSTIC setTitle:@"STEEL\r\nACOUSTIC" forState:UIControlStateNormal];
    //设置title的字体居中
    btnSTEELACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnSTEELACOUSTIC.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnSTEELACOUSTIC.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnSTEELACOUSTIC.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInVOICEMODE == 5)
    {
        //设置标题的颜色
        [btnSTEELACOUSTIC setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnSTEELACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }
    
    [btnSTEELACOUSTIC addTarget:self action:@selector(btnSTEELACOUSTICInVOICEMODEInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnSTEELACOUSTIC];
    
    //BASS GUITAR按键
    dialogVOICEMODEVBtnRect.origin.x = 20 + (averageWidth * 2.8 - 20 - 50) * 0.25 + 10;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogVOICEMODEVLabelRect)+15 + (height * 0.85 * 0.51 - 40) * 0.33 + 10;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnBASSGUITAR = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnBASSGUITAR setTitle:@"BASS\r\nGUITAR" forState:UIControlStateNormal];
    //设置title的字体居中
    btnBASSGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnBASSGUITAR.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnBASSGUITAR.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnBASSGUITAR.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInVOICEMODE == 6)
    {
        //设置标题的颜色
        [btnBASSGUITAR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnBASSGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }
    
    [btnBASSGUITAR addTarget:self action:@selector(btnBASSGUITARInVOICEMODEInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnBASSGUITAR];
    
    //SYNTH PIANO按键
    dialogVOICEMODEVBtnRect.origin.x = 20 + (averageWidth * 2.8 - 20 - 50) * 0.25 * 2 + 10 * 2;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogVOICEMODEVLabelRect)+15 + (height * 0.85 * 0.51 - 40) * 0.33 + 10;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnSYNTHPIANO = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnSYNTHPIANO setTitle:@"SYNTH\r\nPIANO" forState:UIControlStateNormal];
    //设置title的字体居中
    btnSYNTHPIANO.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnSYNTHPIANO.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnSYNTHPIANO.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnSYNTHPIANO.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInVOICEMODE == 7)
    {
        //设置标题的颜色
        [btnSYNTHPIANO setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnSYNTHPIANO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }

    [btnSYNTHPIANO addTarget:self action:@selector(btnSYNTHPIANOInVOICEMODEInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnSYNTHPIANO];
    
    
    //BRASS按键
    dialogVOICEMODEVBtnRect.origin.x = 20 + (averageWidth * 2.8 - 20 - 50) * 0.25 * 3 + 10 * 3;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogVOICEMODEVLabelRect)+15 + (height * 0.85 * 0.51 - 40) * 0.33 + 10;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnBRASS = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnBRASS setTitle:@"BRASS" forState:UIControlStateNormal];
    //设置title的字体居中
    btnBRASS.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnBRASS.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnBRASS.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnBRASS.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInVOICEMODE == 8)
    {
        //设置标题的颜色
        [btnBRASS setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnBRASS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }
    
    [btnBRASS addTarget:self action:@selector(btnBRASSInVOICEMODEInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnBRASS];

    
    //WOOD WIND按键
    dialogVOICEMODEVBtnRect.origin.x = 20;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogVOICEMODEVLabelRect)+15 + (height * 0.85 * 0.51 - 40) * 0.33 * 2 + 10 * 2;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnWOODWIND = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnWOODWIND setTitle:@"WOOD\r\nWIND" forState:UIControlStateNormal];
    //设置title的字体居中
    btnWOODWIND.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnWOODWIND.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnWOODWIND.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnWOODWIND.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInVOICEMODE == 9)
    {
        //设置标题的颜色
        [btnWOODWIND setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnWOODWIND setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }
    
    [btnWOODWIND addTarget:self action:@selector(btnWOODWINDInVOICEMODEInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnWOODWIND];
    
    
    //LOW BOOST按键
    dialogVOICEMODEVBtnRect.origin.x = 20 + (averageWidth * 2.8 - 20 - 50) * 0.25 + 10;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogVOICEMODEVLabelRect)+15 + (height * 0.85 * 0.51 - 40) * 0.33 * 2 + 10 * 2;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnLOWBOOST = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnLOWBOOST setTitle:@"LOW\r\nBOOST" forState:UIControlStateNormal];
    //设置title的字体居中
    btnLOWBOOST.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnLOWBOOST.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnLOWBOOST.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnLOWBOOST.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInVOICEMODE == 10)
    {
        //设置标题的颜色
        [btnLOWBOOST setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnLOWBOOST setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }
    
    [btnLOWBOOST addTarget:self action:@selector(btnLOWBOOSTInVOICEMODEInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnLOWBOOST];
    
    //FLAT按键
    dialogVOICEMODEVBtnRect.origin.x = 20 + (averageWidth * 2.8 - 20 - 50) * 0.25 * 2 + 10 * 2;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogVOICEMODEVLabelRect)+15 + (height * 0.85 * 0.51 - 40) * 0.33 * 2 + 10 * 2;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnFLAT = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnFLAT setTitle:@"FLAT" forState:UIControlStateNormal];
    //设置title的字体居中
    btnFLAT.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnFLAT.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnFLAT.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnFLAT.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInVOICEMODE == 11)
    {
        //设置标题的颜色
        [btnFLAT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnFLAT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }
   
    [btnFLAT addTarget:self action:@selector(btnFLATInVOICEMODEInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnFLAT];
    
    //=========================== END ===========================//
    
    //FX SELECTOR label
    CGRect dialogFXSELECTORLabelRect = contentView.bounds;
    dialogFXSELECTORLabelRect.origin.x = 10;
    dialogFXSELECTORLabelRect.origin.y = CGRectGetMaxY(infoLabelRect)+20;
    dialogFXSELECTORLabelRect.size.height = 20;
    dialogFXSELECTORLabelRect.size.width = 200;
    UIFont *dialogFXSELECTORLabelFont = [UIFont boldSystemFontOfSize:17];
    UILabel *dialogFXSELECTORLabel = [[UILabel alloc] initWithFrame:dialogFXSELECTORLabelRect];
    dialogFXSELECTORLabel.text = @"FX SELECTOR:";
    dialogFXSELECTORLabel.font = dialogFXSELECTORLabelFont;
    dialogFXSELECTORLabel.textColor = [UIColor blackColor];
    dialogFXSELECTORLabel.textAlignment = NSTextAlignmentLeft;
    dialogFXSELECTORLabel.backgroundColor = [UIColor clearColor];
    [contentView addSubview:dialogFXSELECTORLabel];
    
    //FX SELECTOR 按键背景框
    CGRect infoLabelTwoRect = CGRectInset(contentView.bounds, 5, 5);
    infoLabelTwoRect.origin.x = 10;
    infoLabelTwoRect.origin.y = CGRectGetMaxY(dialogFXSELECTORLabelRect)+5;
    infoLabelTwoRect.size.width = averageWidth * 2.8 - 20;
    infoLabelTwoRect.size.height = height * 0.85 * 0.18;
    UILabel *infoLabelTwo = [[UILabel alloc] initWithFrame:infoLabelTwoRect];
    infoLabelTwo.text = @"";
    infoLabelTwo.numberOfLines = 6;
    infoLabelTwo.textColor = [UIColor whiteColor];
    infoLabelTwo.textAlignment = NSTextAlignmentCenter;
    infoLabelTwo.backgroundColor = [UIColor clearColor];
    infoLabelTwo.shadowColor = [UIColor blackColor];
    infoLabelTwo.shadowOffset = CGSizeMake(0, 1);
    infoLabelTwo.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色,要为CGColor
    infoLabelTwo.layer.borderWidth = 1;//边框宽度
    [contentView addSubview:infoLabelTwo];
    
    //========================= Dailog FX SELECTOR 按键 ===========================//
    
    //COMPRESS OR 按键
    dialogVOICEMODEVBtnRect.origin.x = 20;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogFXSELECTORLabelRect) + 15;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnCOMPRESSOR = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnCOMPRESSOR setTitle:@"COMPRESS\r\nOR" forState:UIControlStateNormal];
    //设置title的字体居中
    btnCOMPRESSOR.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnCOMPRESSOR.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnCOMPRESSOR.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnCOMPRESSOR.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInFXSELECTOR == 1)
    {
        //设置标题的颜色
        [btnCOMPRESSOR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnCOMPRESSOR setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnCOMPRESSOR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnCOMPRESSOR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }

    [btnCOMPRESSOR addTarget:self action:@selector(btnCOMPRESSORInFXSELECTORInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnCOMPRESSOR];
    
    //CHORUS 按键
    dialogVOICEMODEVBtnRect.origin.x = 20 + (averageWidth * 2.8 - 20 - 50) * 0.25 + 10;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogFXSELECTORLabelRect) + 15;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnCHORUS = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnCHORUS setTitle:@"CHORUS" forState:UIControlStateNormal];
    //设置title的字体居中
    btnCHORUS.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnCHORUS.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnCHORUS.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnCHORUS.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInFXSELECTOR == 2)
    {
        //设置标题的颜色
        [btnCHORUS setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnCHORUS setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnCHORUS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnCHORUS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }
    
    [btnCHORUS addTarget:self action:@selector(btnCHORUSInFXSELECTORInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnCHORUS];
    
    
    //DELAY 按键
    dialogVOICEMODEVBtnRect.origin.x = 20 + (averageWidth * 2.8 - 20 - 50) * 0.25 * 2 + 10 * 2;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogFXSELECTORLabelRect) + 15;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnDELAY = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnDELAY setTitle:@"DELAY" forState:UIControlStateNormal];
    //设置title的字体居中
    btnDELAY.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnDELAY.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnDELAY.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnDELAY.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInFXSELECTOR == 3)
    {
        //设置标题的颜色
        [btnDELAY setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnDELAY setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnDELAY setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnDELAY setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }
    
    [btnDELAY addTarget:self action:@selector(btnDELAYInFXSELECTORInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnDELAY];
    
    //Reverb + Delay 按键
    dialogVOICEMODEVBtnRect.origin.x = 20 + (averageWidth * 2.8 - 20 - 50) * 0.25 * 3 + 10 * 3;
    dialogVOICEMODEVBtnRect.origin.y = CGRectGetMaxY(dialogFXSELECTORLabelRect) + 15;
    dialogVOICEMODEVBtnRect.size.width = (averageWidth * 2.8 - 20 - 50) * 0.25;
    dialogVOICEMODEVBtnRect.size.height = (height * 0.85 * 0.51 - 40) * 0.33;
    btnReverbDelay = [[UIButton alloc] initWithFrame:dialogVOICEMODEVBtnRect];
    //普通状态按钮标题
    [btnReverbDelay setTitle:@"Reverb +\r\nDelay" forState:UIControlStateNormal];
    //设置title的字体居中
    btnReverbDelay.titleLabel.textAlignment = NSTextAlignmentCenter;
    //title多行显示
    btnReverbDelay.titleLabel.lineBreakMode = 0;
    
    //设置标题的字体大小
    if (width < 600)
    {
        [btnReverbDelay.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    }
    else
    {
        [btnReverbDelay.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    
    if (buttonClickedInFXSELECTOR == 4)
    {
        //设置标题的颜色
        [btnReverbDelay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnReverbDelay setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    }
    else
    {
        //设置标题的颜色
        [btnReverbDelay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //图片被拉伸式地设置背景图片
        [btnReverbDelay setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    }
    
    [btnReverbDelay addTarget:self action:@selector(btnReverbDelayInFXSELECTORInDialogClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnReverbDelay];

    
    //=========================== END ===========================//
    
    //FX SELECTOR 按键
    
//    CGFloat btnY = CGRectGetMaxY(infoLabelRect)+5;
//    CGFloat btnH = CGRectGetMaxY(contentView.frame)-5 - btnY;
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.frame = CGRectMake(infoLabelRect.origin.x, btnY, infoLabelRect.size.width, btnH);
//    [btn setTitle:@"Close Button Right" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(changeCloseButtonType:) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
//    [contentView addSubview:btn];

    
    KGModal *modal = [KGModal sharedInstance];
    modal.closeButtonType = KGModalCloseButtonTypeRight;
   

    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    //[contentView removeFromSuperview];
    //[[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
    //[self.window removeFromSuperview];
    //self.window = nil;

    
    /*
    CGFloat btnY = CGRectGetMaxY(infoLabelRect)+5;
    CGFloat btnH = CGRectGetMaxY(contentView.frame)-5 - btnY;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(infoLabelRect.origin.x, btnY, infoLabelRect.size.width, btnH);
    [btn setTitle:@"Close Button Right" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeCloseButtonType:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btn];
    */
    //    [[KGModal sharedInstance] setCloseButtonLocation:KGModalCloseButtonLocationRight];
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];

}



- (IBAction)btnFourSubstituteInViewTwoDetail:(id)sender {
    
    self.displayStatus = FromBtnFour;
    
    self.btnInViewFour.hidden = YES;
    self.btnVerticalInViewFour.hidden = NO;
    self.viewOneDetail.hidden = NO;
    self.viewFourDetail.hidden = NO;
    
    //左按键viewxxxDetail切换动画效果
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type =  kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [self.viewOneDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewOneDetail];
    [self.view bringSubviewToFront:self.viewOneDetail];
    
    transition.duration = 0.2f;
    transition.type =  kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.viewFourDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewFourDetail];
    [self.view bringSubviewToFront:self.viewFourDetail];
    [self.view bringSubviewToFront:self.viewFive];
    
    //左按键Viewxxx的显示效果
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewFour setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewFour];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewThree setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewThree];
    
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
    [self.viewTwo setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewTwo];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
    [self.viewOne setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewOne];
    
    //添加阴影效果
    self.viewFour.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.viewFour.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewFour.layer.shadowOpacity = 1.0;
}

- (IBAction)btnFourSubstituteInViewThreeDetail:(id)sender {
    
    self.displayStatus = FromBtnFour;
    
    self.btnInViewFour.hidden = YES;
    self.btnVerticalInViewFour.hidden = NO;
    self.viewTwoDetail.hidden = NO;
    self.viewFourDetail.hidden = NO;
    
    //左按键viewxxxDetail切换动画效果
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type =  kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [self.viewTwoDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewTwoDetail];
    [self.view bringSubviewToFront:self.viewTwoDetail];
    
    transition.duration = 0.2f;
    transition.type =  kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.viewFourDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewFourDetail];
    [self.view bringSubviewToFront:self.viewFourDetail];
    [self.view bringSubviewToFront:self.viewFive];
    
    //左按键Viewxxx的显示效果
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewFour setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewFour];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewThree setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewThree];
    
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
    [self.viewTwo setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewTwo];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
    [self.viewOne setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewOne];
    
    //添加阴影效果
    self.viewFour.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.viewFour.layer.shadowOffset = CGSizeMake(0, 0);
    self.viewFour.layer.shadowOpacity = 1.0;
}

- (IBAction)btnSOLOInViewOneDetailTapped:(id)sender {
    
    if (btnSOLOInViewOneDetailClickedStatus == true)
    {
        //viewTwo,viewTwoDetail不可选
        //Mute不可选
        CGRect btnMuteCannotChooseRect = CGRectMake(self.btnMuteInViewTwo.frame.origin.x, self.btnMuteInViewTwo.frame.origin.y, self.btnMuteInViewTwo.frame.size.width, self.btnMuteInViewTwo.frame.size.height);
        btnMuteCannotChooseViewInViewTwo = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        btnMuteCannotChooseViewInViewTwo.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewTwo addSubview:btnMuteCannotChooseViewInViewTwo];
        //image不可选
        btnMuteCannotChooseRect = CGRectMake(self.imageViewInViewTwo.frame.origin.x, self.imageViewInViewTwo.frame.origin.y, self.imageViewInViewTwo.frame.size.width, self.imageViewInViewTwo.frame.size.height);
        imageViewCannotChooseViewInViewTwo = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        imageViewCannotChooseViewInViewTwo.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewTwo addSubview:imageViewCannotChooseViewInViewTwo];
        //sliderOne不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewTwoDetail.frame.origin.x + self.sliderOneInViewTwoDetail.frame.origin.x, self.sliderInViewTwoDetail.frame.origin.y + self.sliderOneInViewTwoDetail.frame.origin.y, self.sliderOneInViewTwoDetail.frame.size.width, self.sliderOneInViewTwoDetail.frame.size.height);
        sliderOneCannotChooseInViewTwoDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderOneCannotChooseInViewTwoDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewTwoDetail addSubview:sliderOneCannotChooseInViewTwoDetail];
        //sliderTwo不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewTwoDetail.frame.origin.x + self.sliderTwoInViewTwoDetail.frame.origin.x, self.sliderInViewTwoDetail.frame.origin.y + self.sliderTwoInViewTwoDetail.frame.origin.y, self.sliderTwoInViewTwoDetail.frame.size.width, self.sliderTwoInViewTwoDetail.frame.size.height);
        sliderTwoCannotChooseInViewTwoDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderTwoCannotChooseInViewTwoDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewTwoDetail addSubview:sliderTwoCannotChooseInViewTwoDetail];
        //sliderThree不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewTwoDetail.frame.origin.x + self.sliderThreeInViewTwoDetail.frame.origin.x, self.sliderInViewTwoDetail.frame.origin.y + self.sliderThreeInViewTwoDetail.frame.origin.y, self.sliderThreeInViewTwoDetail.frame.size.width, self.sliderThreeInViewTwoDetail.frame.size.height);
        sliderThreeCannotChooseInViewTwoDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderThreeCannotChooseInViewTwoDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewTwoDetail addSubview:sliderThreeCannotChooseInViewTwoDetail];
        
        
        //viewThree,viewThreeDetail不可选
        //Mute不可选
        btnMuteCannotChooseRect = CGRectMake(self.btnMuteInViewThree.frame.origin.x, self.btnMuteInViewThree.frame.origin.y, self.btnMuteInViewThree.frame.size.width, self.btnMuteInViewThree.frame.size.height);
        btnMuteCannotChooseViewInViewThree = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        btnMuteCannotChooseViewInViewThree.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewThree addSubview:btnMuteCannotChooseViewInViewThree];
        //image不可选
        btnMuteCannotChooseRect = CGRectMake(self.imageViewInViewThree.frame.origin.x, self.imageViewInViewThree.frame.origin.y, self.imageViewInViewThree.frame.size.width, self.imageViewInViewThree.frame.size.height);
        imageViewCannotChooseViewInViewThree = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        imageViewCannotChooseViewInViewThree.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewThree addSubview:imageViewCannotChooseViewInViewThree];
        //sliderOne不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewThreeDetail.frame.origin.x + self.sliderOneInViewThreeDetail.frame.origin.x, self.sliderInViewThreeDetail.frame.origin.y + self.sliderOneInViewThreeDetail.frame.origin.y, self.sliderOneInViewThreeDetail.frame.size.width, self.sliderOneInViewThreeDetail.frame.size.height);
        sliderOneCannotChooseInViewThreeDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderOneCannotChooseInViewThreeDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewThreeDetail addSubview:sliderOneCannotChooseInViewThreeDetail];
        //sliderTwo不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewThreeDetail.frame.origin.x + self.sliderTwoInViewThreeDetail.frame.origin.x, self.sliderInViewThreeDetail.frame.origin.y + self.sliderTwoInViewThreeDetail.frame.origin.y, self.sliderTwoInViewThreeDetail.frame.size.width, self.sliderTwoInViewThreeDetail.frame.size.height);
        sliderTwoCannotChooseInViewThreeDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderTwoCannotChooseInViewThreeDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewThreeDetail addSubview:sliderTwoCannotChooseInViewThreeDetail];
        //sliderThree不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewThreeDetail.frame.origin.x + self.sliderThreeInViewThreeDetail.frame.origin.x, self.sliderInViewThreeDetail.frame.origin.y + self.sliderThreeInViewThreeDetail.frame.origin.y, self.sliderThreeInViewThreeDetail.frame.size.width, self.sliderThreeInViewThreeDetail.frame.size.height);
        sliderThreeCannotChooseInViewThreeDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderThreeCannotChooseInViewThreeDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewThreeDetail addSubview:sliderThreeCannotChooseInViewThreeDetail];
    }
    
    if (btnSOLOInViewOneDetailClickedStatus == true)
    {
        btnSOLOInViewOneDetailClickedStatus = false;
        [self.btnSOLOInViewOneDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnSOLOInViewOneDetail setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
        
        //viewTwo,viewTwoDetail不可选显示
        btnMuteCannotChooseViewInViewTwo.hidden = NO;
        imageViewCannotChooseViewInViewTwo.hidden = NO;
        sliderOneCannotChooseInViewTwoDetail.hidden = NO;
        sliderTwoCannotChooseInViewTwoDetail.hidden = NO;
        sliderThreeCannotChooseInViewTwoDetail.hidden = NO;
        
        //viewThree,viewThreeDetail不可选显示
        btnMuteCannotChooseViewInViewThree.hidden = NO;
        imageViewCannotChooseViewInViewThree.hidden = NO;
        sliderOneCannotChooseInViewThreeDetail.hidden = NO;
        sliderTwoCannotChooseInViewThreeDetail.hidden = NO;
        sliderThreeCannotChooseInViewThreeDetail.hidden = NO;
     }
    else
    {
        btnSOLOInViewOneDetailClickedStatus = true;
        [self.btnSOLOInViewOneDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnSOLOInViewOneDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
        
        //viewTwo,viewTwoDetail不可选隐藏
        btnMuteCannotChooseViewInViewTwo.hidden = YES;
        imageViewCannotChooseViewInViewTwo.hidden = YES;
        sliderOneCannotChooseInViewTwoDetail.hidden = YES;
        sliderTwoCannotChooseInViewTwoDetail.hidden = YES;
        sliderThreeCannotChooseInViewTwoDetail.hidden = YES;
        
        //viewOThree,viewThreeDetail不可选隐藏
        btnMuteCannotChooseViewInViewThree.hidden = YES;
        imageViewCannotChooseViewInViewThree.hidden = YES;
        sliderOneCannotChooseInViewThreeDetail.hidden = YES;
        sliderTwoCannotChooseInViewThreeDetail.hidden = YES;
        sliderThreeCannotChooseInViewThreeDetail.hidden = YES;
    }
}

- (IBAction)btnSOLOInViewTwoDetailTapped:(id)sender {
    
    if (btnSOLOInViewTwoDetailClickedStatus == true)
    {
        //viewOne,viewOneDetail不可选
        //Mute不可选
        CGRect btnMuteCannotChooseRect = CGRectMake(self.btnMuteInViewOne.frame.origin.x, self.btnMuteInViewOne.frame.origin.y, self.btnMuteInViewOne.frame.size.width, self.btnMuteInViewOne.frame.size.height);
        btnMuteCannotChooseViewInViewOne = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        btnMuteCannotChooseViewInViewOne.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewOne addSubview:btnMuteCannotChooseViewInViewOne];
        //image不可选
        btnMuteCannotChooseRect = CGRectMake(self.imageViewInViewOne.frame.origin.x, self.imageViewInViewOne.frame.origin.y, self.imageViewInViewOne.frame.size.width, self.imageViewInViewOne.frame.size.height);
        imageViewCannotChooseViewInViewOne = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        imageViewCannotChooseViewInViewOne.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewOne addSubview:imageViewCannotChooseViewInViewOne];
        //sliderOne不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewOneDetail.frame.origin.x + self.sliderOneInViewOneDetail.frame.origin.x, self.sliderInViewOneDetail.frame.origin.y + self.sliderOneInViewOneDetail.frame.origin.y, self.sliderOneInViewOneDetail.frame.size.width, self.sliderOneInViewOneDetail.frame.size.height);
        sliderOneCannotChooseInViewOneDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderOneCannotChooseInViewOneDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewOneDetail addSubview:sliderOneCannotChooseInViewOneDetail];
        //sliderTwo不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewOneDetail.frame.origin.x + self.sliderTwoInViewOneDetail.frame.origin.x, self.sliderInViewOneDetail.frame.origin.y + self.sliderTwoInViewOneDetail.frame.origin.y, self.sliderTwoInViewOneDetail.frame.size.width, self.sliderTwoInViewOneDetail.frame.size.height);
        sliderTwoCannotChooseInViewOneDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderTwoCannotChooseInViewOneDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewOneDetail addSubview:sliderTwoCannotChooseInViewOneDetail];
        //sliderThree不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewOneDetail.frame.origin.x + self.sliderThreeInViewOneDetail.frame.origin.x, self.sliderInViewOneDetail.frame.origin.y + self.sliderThreeInViewOneDetail.frame.origin.y, self.sliderThreeInViewOneDetail.frame.size.width, self.sliderThreeInViewOneDetail.frame.size.height);
        sliderThreeCannotChooseInViewOneDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderThreeCannotChooseInViewOneDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewOneDetail addSubview:sliderThreeCannotChooseInViewOneDetail];
        
        
        //viewThree,viewThreeDetail不可选
        //Mute不可选
        btnMuteCannotChooseRect = CGRectMake(self.btnMuteInViewThree.frame.origin.x, self.btnMuteInViewThree.frame.origin.y, self.btnMuteInViewThree.frame.size.width, self.btnMuteInViewThree.frame.size.height);
        btnMuteCannotChooseViewInViewThree = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        btnMuteCannotChooseViewInViewThree.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewThree addSubview:btnMuteCannotChooseViewInViewThree];
        //image不可选
        btnMuteCannotChooseRect = CGRectMake(self.imageViewInViewThree.frame.origin.x, self.imageViewInViewThree.frame.origin.y, self.imageViewInViewThree.frame.size.width, self.imageViewInViewThree.frame.size.height);
        imageViewCannotChooseViewInViewThree = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        imageViewCannotChooseViewInViewThree.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewThree addSubview:imageViewCannotChooseViewInViewThree];
        //sliderOne不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewThreeDetail.frame.origin.x + self.sliderOneInViewThreeDetail.frame.origin.x, self.sliderInViewThreeDetail.frame.origin.y + self.sliderOneInViewThreeDetail.frame.origin.y, self.sliderOneInViewThreeDetail.frame.size.width, self.sliderOneInViewThreeDetail.frame.size.height);
        sliderOneCannotChooseInViewThreeDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderOneCannotChooseInViewThreeDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewThreeDetail addSubview:sliderOneCannotChooseInViewThreeDetail];
        //sliderTwo不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewThreeDetail.frame.origin.x + self.sliderTwoInViewThreeDetail.frame.origin.x, self.sliderInViewThreeDetail.frame.origin.y + self.sliderTwoInViewThreeDetail.frame.origin.y, self.sliderTwoInViewThreeDetail.frame.size.width, self.sliderTwoInViewThreeDetail.frame.size.height);
        sliderTwoCannotChooseInViewThreeDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderTwoCannotChooseInViewThreeDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewThreeDetail addSubview:sliderTwoCannotChooseInViewThreeDetail];
        //sliderThree不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewThreeDetail.frame.origin.x + self.sliderThreeInViewThreeDetail.frame.origin.x, self.sliderInViewThreeDetail.frame.origin.y + self.sliderThreeInViewThreeDetail.frame.origin.y, self.sliderThreeInViewThreeDetail.frame.size.width, self.sliderThreeInViewThreeDetail.frame.size.height);
        sliderThreeCannotChooseInViewThreeDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderThreeCannotChooseInViewThreeDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewThreeDetail addSubview:sliderThreeCannotChooseInViewThreeDetail];
    }
    
    if (btnSOLOInViewTwoDetailClickedStatus == true)
    {
        btnSOLOInViewTwoDetailClickedStatus = false;
        [self.btnSOLOInViewTwoDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnSOLOInViewTwoDetail setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
        
        //viewOne,viewOneDetail不可选显示
        btnMuteCannotChooseViewInViewOne.hidden = NO;
        imageViewCannotChooseViewInViewOne.hidden = NO;
        sliderOneCannotChooseInViewOneDetail.hidden = NO;
        sliderTwoCannotChooseInViewOneDetail.hidden = NO;
        sliderThreeCannotChooseInViewOneDetail.hidden = NO;
        
        //viewThree,viewThreeDetail不可选显示
        btnMuteCannotChooseViewInViewThree.hidden = NO;
        imageViewCannotChooseViewInViewThree.hidden = NO;
        sliderOneCannotChooseInViewThreeDetail.hidden = NO;
        sliderTwoCannotChooseInViewThreeDetail.hidden = NO;
        sliderThreeCannotChooseInViewThreeDetail.hidden = NO;
    }
    else
    {
        btnSOLOInViewTwoDetailClickedStatus = true;
        [self.btnSOLOInViewTwoDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnSOLOInViewTwoDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
        
        //viewOne,viewOneDetail不可选隐藏
        btnMuteCannotChooseViewInViewOne.hidden = YES;
        imageViewCannotChooseViewInViewOne.hidden = YES;
        sliderOneCannotChooseInViewOneDetail.hidden = YES;
        sliderTwoCannotChooseInViewOneDetail.hidden = YES;
        sliderThreeCannotChooseInViewOneDetail.hidden = YES;
        
        //viewOThree,viewThreeDetail不可选隐藏
        btnMuteCannotChooseViewInViewThree.hidden = YES;
        imageViewCannotChooseViewInViewThree.hidden = YES;
        sliderOneCannotChooseInViewThreeDetail.hidden = YES;
        sliderTwoCannotChooseInViewThreeDetail.hidden = YES;
        sliderThreeCannotChooseInViewThreeDetail.hidden = YES;
    }
    
}

- (IBAction)btnSOLOInViewThreeDetailTapped:(id)sender {
    
    if (btnSOLOInViewThreeDetailClickedStatus == true)
    {
        //viewOne,viewOneDetail不可选
        //Mute不可选
        CGRect btnMuteCannotChooseRect = CGRectMake(self.btnMuteInViewOne.frame.origin.x, self.btnMuteInViewOne.frame.origin.y, self.btnMuteInViewOne.frame.size.width, self.btnMuteInViewOne.frame.size.height);
        btnMuteCannotChooseViewInViewOne = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        btnMuteCannotChooseViewInViewOne.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewOne addSubview:btnMuteCannotChooseViewInViewOne];
        //image不可选
        btnMuteCannotChooseRect = CGRectMake(self.imageViewInViewOne.frame.origin.x, self.imageViewInViewOne.frame.origin.y, self.imageViewInViewOne.frame.size.width, self.imageViewInViewOne.frame.size.height);
        imageViewCannotChooseViewInViewOne = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        imageViewCannotChooseViewInViewOne.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewOne addSubview:imageViewCannotChooseViewInViewOne];
        //sliderOne不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewOneDetail.frame.origin.x + self.sliderOneInViewOneDetail.frame.origin.x, self.sliderInViewOneDetail.frame.origin.y + self.sliderOneInViewOneDetail.frame.origin.y, self.sliderOneInViewOneDetail.frame.size.width, self.sliderOneInViewOneDetail.frame.size.height);
        sliderOneCannotChooseInViewOneDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderOneCannotChooseInViewOneDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewOneDetail addSubview:sliderOneCannotChooseInViewOneDetail];
        //sliderTwo不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewOneDetail.frame.origin.x + self.sliderTwoInViewOneDetail.frame.origin.x, self.sliderInViewOneDetail.frame.origin.y + self.sliderTwoInViewOneDetail.frame.origin.y, self.sliderTwoInViewOneDetail.frame.size.width, self.sliderTwoInViewOneDetail.frame.size.height);
        sliderTwoCannotChooseInViewOneDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderTwoCannotChooseInViewOneDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewOneDetail addSubview:sliderTwoCannotChooseInViewOneDetail];
        //sliderThree不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewOneDetail.frame.origin.x + self.sliderThreeInViewOneDetail.frame.origin.x, self.sliderInViewOneDetail.frame.origin.y + self.sliderThreeInViewOneDetail.frame.origin.y, self.sliderThreeInViewOneDetail.frame.size.width, self.sliderThreeInViewOneDetail.frame.size.height);
        sliderThreeCannotChooseInViewOneDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderThreeCannotChooseInViewOneDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewOneDetail addSubview:sliderThreeCannotChooseInViewOneDetail];
        
        
        //viewTwo,viewTwoDetail不可选
        //Mute不可选
        btnMuteCannotChooseRect = CGRectMake(self.btnMuteInViewTwo.frame.origin.x, self.btnMuteInViewTwo.frame.origin.y, self.btnMuteInViewTwo.frame.size.width, self.btnMuteInViewTwo.frame.size.height);
        btnMuteCannotChooseViewInViewTwo = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        btnMuteCannotChooseViewInViewTwo.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewTwo addSubview:btnMuteCannotChooseViewInViewTwo];
        //image不可选
        btnMuteCannotChooseRect = CGRectMake(self.imageViewInViewTwo.frame.origin.x, self.imageViewInViewTwo.frame.origin.y, self.imageViewInViewTwo.frame.size.width, self.imageViewInViewTwo.frame.size.height);
        imageViewCannotChooseViewInViewTwo = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        imageViewCannotChooseViewInViewTwo.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewTwo addSubview:imageViewCannotChooseViewInViewTwo];
        //sliderOne不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewTwoDetail.frame.origin.x + self.sliderOneInViewTwoDetail.frame.origin.x, self.sliderInViewTwoDetail.frame.origin.y + self.sliderOneInViewTwoDetail.frame.origin.y, self.sliderOneInViewTwoDetail.frame.size.width, self.sliderOneInViewTwoDetail.frame.size.height);
        sliderOneCannotChooseInViewTwoDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderOneCannotChooseInViewTwoDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewTwoDetail addSubview:sliderOneCannotChooseInViewTwoDetail];
        //sliderTwo不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewTwoDetail.frame.origin.x + self.sliderTwoInViewTwoDetail.frame.origin.x, self.sliderInViewTwoDetail.frame.origin.y + self.sliderTwoInViewTwoDetail.frame.origin.y, self.sliderTwoInViewTwoDetail.frame.size.width, self.sliderTwoInViewTwoDetail.frame.size.height);
        sliderTwoCannotChooseInViewTwoDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderTwoCannotChooseInViewTwoDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewTwoDetail addSubview:sliderTwoCannotChooseInViewTwoDetail];
        //sliderThree不可选
        btnMuteCannotChooseRect = CGRectMake(self.sliderInViewTwoDetail.frame.origin.x + self.sliderThreeInViewTwoDetail.frame.origin.x, self.sliderInViewTwoDetail.frame.origin.y + self.sliderThreeInViewTwoDetail.frame.origin.y, self.sliderThreeInViewTwoDetail.frame.size.width, self.sliderThreeInViewTwoDetail.frame.size.height);
        sliderThreeCannotChooseInViewTwoDetail = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        sliderThreeCannotChooseInViewTwoDetail.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewTwoDetail addSubview:sliderThreeCannotChooseInViewTwoDetail];
    }
    
    if (btnSOLOInViewThreeDetailClickedStatus == true)
    {
        btnSOLOInViewThreeDetailClickedStatus = false;
        [self.btnSOLOInViewThreeDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.btnSOLOInViewThreeDetail setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
        
        //viewOne,viewOneDetail不可选显示
        btnMuteCannotChooseViewInViewOne.hidden = NO;
        imageViewCannotChooseViewInViewOne.hidden = NO;
        sliderOneCannotChooseInViewOneDetail.hidden = NO;
        sliderTwoCannotChooseInViewOneDetail.hidden = NO;
        sliderThreeCannotChooseInViewOneDetail.hidden = NO;
        
        //viewTwo,viewTwoDetail不可选显示
        btnMuteCannotChooseViewInViewTwo.hidden = NO;
        imageViewCannotChooseViewInViewTwo.hidden = NO;
        sliderOneCannotChooseInViewTwoDetail.hidden = NO;
        sliderTwoCannotChooseInViewTwoDetail.hidden = NO;
        sliderThreeCannotChooseInViewTwoDetail.hidden = NO;
    }
    else
    {
        btnSOLOInViewThreeDetailClickedStatus = true;
        [self.btnSOLOInViewThreeDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnSOLOInViewThreeDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
        
        //viewOne,viewOneDetail不可选隐藏
        btnMuteCannotChooseViewInViewOne.hidden = YES;
        imageViewCannotChooseViewInViewOne.hidden = YES;
        sliderOneCannotChooseInViewOneDetail.hidden = YES;
        sliderTwoCannotChooseInViewOneDetail.hidden = YES;
        sliderThreeCannotChooseInViewOneDetail.hidden = YES;
        
        //viewTwo,viewTwoDetail不可选隐藏
        btnMuteCannotChooseViewInViewTwo.hidden = YES;
        imageViewCannotChooseViewInViewTwo.hidden = YES;
        sliderOneCannotChooseInViewTwoDetail.hidden = YES;
        sliderTwoCannotChooseInViewTwoDetail.hidden = YES;
        sliderThreeCannotChooseInViewTwoDetail.hidden = YES;
    }
}


#pragma mark - 不同channel左右切换
- (IBAction)btnLeftInViewOneDetail:(id)sender {
    
    self.displayStatus = FromBtnFour;               
    self.btnInViewOne.hidden = NO;
    self.btnVerticalInViewOne.hidden =YES;
    self.btnInViewFour.hidden = YES;
    self.btnVerticalInViewFour.hidden = NO;
    self.viewThreeDetail.hidden = NO;
    self.viewFourDetail.hidden = NO;
    
    //左按键viewxxxDetail切换动画效果
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
//    transition.type =  kCATransitionReveal;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    [self.viewThreeDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewThreeDetail];
    [self.view bringSubviewToFront:self.viewThreeDetail];
    
    transition.duration = 0.2f;
//    transition.type =  kCATransitionPush;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    [self.viewFourDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewFourDetail];
    [self.view bringSubviewToFront:self.viewFourDetail];
    [self.view bringSubviewToFront:self.viewFive];
    
    //左按键Viewxxx的显示效果
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewFour setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewFour];

    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewThree setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewThree];

    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
    [self.viewTwo setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewTwo];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
    [self.viewOne setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewOne];
    
    
    //设置view边框阴影效果
    self.viewFour.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.viewFour.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewFour.layer.shadowOpacity = 1.0;
    
    self.viewOne.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewOne.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewOne.layer.shadowOpacity = 1.0;
    
    self.viewTwo.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewTwo.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewTwo.layer.shadowOpacity = 1.0;
    
    self.viewThree.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewThree.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewThree.layer.shadowOpacity = 1.0;

}

- (IBAction)btnRightInViewOneDetail:(id)sender {
    
    self.displayStatus = FromBtnTwo;
    self.btnInViewOne.hidden = NO;
    self.btnVerticalInViewOne.hidden =YES;
    self.btnInViewTwo.hidden = YES;
    self.btnVerticalInViewTwo.hidden = NO;
    self.viewOneDetail.hidden = NO;
    self.viewTwoDetail.hidden = NO;
    
    //右按键viewxxxDetail切换动画效果
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type =  kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
    [self.viewOneDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewOneDetail];
    [self.view bringSubviewToFront:self.viewOneDetail];
    
    transition.duration = 0.2f;
    transition.type =  kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.viewTwoDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewTwoDetail];
    [self.view bringSubviewToFront:self.viewTwoDetail];
    [self.view bringSubviewToFront:self.viewFive];
    
    //右按键Viewxxx的显示效果
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 4, 0);
    [self.viewFour setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewFour];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewThree setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewThree];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth, 0);
    [self.viewTwo setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewTwo];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
    [self.viewOne setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewOne];
   

    //设置view边框阴影效果
    self.viewTwo.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.viewTwo.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewTwo.layer.shadowOpacity = 1.0;
        
    self.viewOne.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewOne.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewOne.layer.shadowOpacity = 1.0;
        
    self.viewThree.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewThree.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewThree.layer.shadowOpacity = 1.0;

    self.viewFour.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewFour.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewFour.layer.shadowOpacity = 1.0;

}

- (IBAction)btnLeftInViewTwoDetail:(id)sender {
    
    self.displayStatus = FromBtnOne;
    self.btnInViewTwo.hidden = NO;
    self.btnVerticalInViewTwo.hidden =YES;
    self.btnInViewOne.hidden = YES;
    self.btnVerticalInViewOne.hidden = NO;
    self.viewOneDetail.hidden = NO;
    self.viewTwoDetail.hidden = NO;
    
    //左按键viewxxxDetail切换动画效果
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type =  kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [self.viewTwoDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewTwoDetail];
    [self.view bringSubviewToFront:self.viewTwoDetail];
    
    transition.duration = 0.2f;
    transition.type =  kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.viewOneDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewOneDetail];
    [self.view bringSubviewToFront:self.viewOneDetail];
    [self.view bringSubviewToFront:self.viewFive];
    
    //左按键Viewxxx的显示效果
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 4, 0);
    [self.viewFour setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewFour];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewThree setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewThree];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
    [self.viewTwo setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewTwo];
    
    myTransform = CGAffineTransformMakeTranslation(0, 0);
    [self.viewOne setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewOne];
    
    
    //设置view边框阴影效果
    self.viewOne.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.viewOne.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewOne.layer.shadowOpacity = 1.0;
    
    self.viewTwo.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewTwo.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewTwo.layer.shadowOpacity = 1.0;
    
    self.viewThree.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewThree.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewThree.layer.shadowOpacity = 1.0;
    
    self.viewFour.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewFour.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewFour.layer.shadowOpacity = 1.0;

}

- (IBAction)btnRightInViewTwoDetail:(id)sender {
    
    
    self.displayStatus = FromBtnThree;
    self.btnInViewTwo.hidden = NO;
    self.btnVerticalInViewTwo.hidden =YES;
    self.btnInViewThree.hidden = YES;
    self.btnVerticalInViewThree.hidden = NO;
    self.viewTwoDetail.hidden = NO;
    self.viewThreeDetail.hidden = NO;
    
    //右按键viewxxxDetail切换动画效果
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type =  kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
    [self.viewTwoDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewTwoDetail];
    [self.view bringSubviewToFront:self.viewTwoDetail];
    
    transition.duration = 0.2f;
    transition.type =  kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.viewThreeDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewThreeDetail];
    [self.view bringSubviewToFront:self.viewThreeDetail];
    [self.view bringSubviewToFront:self.viewFive];
    
    
    //右按键Viewxxx的显示效果
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 4, 0);
    [self.viewFour setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewFour];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
    [self.viewThree setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewThree];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
    [self.viewTwo setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewTwo];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
    [self.viewOne setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewOne];
    
    
    //设置view边框阴影效果
    self.viewThree.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.viewThree.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewThree.layer.shadowOpacity = 1.0;
    
    self.viewOne.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewOne.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewOne.layer.shadowOpacity = 1.0;
    
    self.viewTwo.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewTwo.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewTwo.layer.shadowOpacity = 1.0;
    
    self.viewFour.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewFour.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewFour.layer.shadowOpacity = 1.0;

}

- (IBAction)btnLeftInViewThreeDetail:(id)sender {
    
    self.displayStatus = FromBtnTwo;
    self.btnInViewThree.hidden = NO;
    self.btnVerticalInViewThree.hidden =YES;
    self.btnInViewTwo.hidden = YES;
    self.btnVerticalInViewTwo.hidden = NO;
    self.viewTwoDetail.hidden = NO;
    self.viewThreeDetail.hidden = NO;
    
    //左按键viewxxxDetail切换动画效果
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type =  kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [self.viewThreeDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewThreeDetail];
    [self.view bringSubviewToFront:self.viewThreeDetail];
    
    transition.duration = 0.2f;
    transition.type =  kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.viewTwoDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewTwoDetail];
    [self.view bringSubviewToFront:self.viewTwoDetail];
    [self.view bringSubviewToFront:self.viewFive];
    
    //左按键Viewxxx的显示效果
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 4, 0);
    [self.viewFour setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewFour];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewThree setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewThree];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth, 0);
    [self.viewTwo setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewTwo];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
    [self.viewOne setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewOne];
    
    
    //设置view边框阴影效果
    self.viewTwo.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.viewTwo.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewTwo.layer.shadowOpacity = 1.0;
    
    self.viewOne.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewOne.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewOne.layer.shadowOpacity = 1.0;
    
    self.viewThree.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewThree.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewThree.layer.shadowOpacity = 1.0;
    
    self.viewFour.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewFour.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewFour.layer.shadowOpacity = 1.0;

}

- (IBAction)btnRightInViewThreeDetail:(id)sender {
    
    self.displayStatus = FromBtnFour;
    self.btnInViewThree.hidden = NO;
    self.btnVerticalInViewThree.hidden =YES;
    self.btnInViewFour.hidden = YES;
    self.btnVerticalInViewFour.hidden = NO;
    self.viewThreeDetail.hidden = NO;
    self.viewFourDetail.hidden = NO;
    
    //右按键viewxxxDetail切换动画效果
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type =  kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
    [self.viewThreeDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewThreeDetail];
    [self.view bringSubviewToFront:self.viewThreeDetail];
    
    transition.duration = 0.2f;
    transition.type =  kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.viewFourDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewFourDetail];
    [self.view bringSubviewToFront:self.viewFourDetail];
    [self.view bringSubviewToFront:self.viewFive];
    
    //右按键Viewxxx的显示效果
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewFour setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewFour];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewThree setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewThree];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
    [self.viewTwo setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewTwo];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
    [self.viewOne setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewOne];
    
    //设置view边框阴影效果
    self.viewFour.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.viewFour.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewFour.layer.shadowOpacity = 1.0;
    
    self.viewOne.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewOne.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewOne.layer.shadowOpacity = 1.0;
    
    self.viewTwo.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewTwo.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewTwo.layer.shadowOpacity = 1.0;
    
    self.viewThree.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewThree.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewThree.layer.shadowOpacity = 1.0;
    
}

- (IBAction)btnLeftInViewFourDetail:(id)sender {
    
    self.displayStatus = FromBtnThree;
    self.btnInViewFour.hidden = NO;
    self.btnVerticalInViewFour.hidden =YES;
    self.btnInViewThree.hidden = YES;
    self.btnVerticalInViewThree.hidden = NO;
    self.viewThreeDetail.hidden = NO;
    self.viewFourDetail.hidden = NO;
    
    //左按键viewxxxDetail切换动画效果
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type =  kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    [self.viewFourDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewFourDetail];
    [self.view bringSubviewToFront:self.viewFourDetail];
    
    transition.duration = 0.2f;
    transition.type =  kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.viewThreeDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewThreeDetail];
    [self.view bringSubviewToFront:self.viewThreeDetail];
    [self.view bringSubviewToFront:self.viewFive];
    
    //左按键Viewxxx的显示效果
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 4, 0);
    [self.viewFour setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewFour];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
    [self.viewThree setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewThree];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
    [self.viewTwo setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewTwo];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 1, 0);
    [self.viewOne setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewOne];

    //设置view边框阴影效果
    self.viewThree.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.viewThree.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewThree.layer.shadowOpacity = 1.0;
    
    self.viewOne.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewOne.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewOne.layer.shadowOpacity = 1.0;
    
    self.viewTwo.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewTwo.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewTwo.layer.shadowOpacity = 1.0;
    
    self.viewFour.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewFour.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewFour.layer.shadowOpacity = 1.0;

}

- (IBAction)btnRightInViewFourDetail:(id)sender {
    
    self.displayStatus = FromBtnOne;
    self.btnInViewFour.hidden = NO;
    self.btnVerticalInViewFour.hidden =YES;
    self.btnInViewOne.hidden = YES;
    self.btnVerticalInViewOne.hidden = NO;
    self.viewOneDetail.hidden = NO;
    self.viewFourDetail.hidden = NO;
    
    //右按键viewxxxDetail切换动画效果
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.type =  kCATransitionReveal;
    transition.subtype = kCATransitionFromLeft;
    [self.viewFourDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewFourDetail];
    [self.view bringSubviewToFront:self.viewFourDetail];
    
    transition.duration = 0.2f;
    transition.type =  kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.viewOneDetail.layer addAnimation:transition forKey:nil];
    [self.view  addSubview:self.viewOneDetail];
    [self.view bringSubviewToFront:self.viewOneDetail];
    [self.view bringSubviewToFront:self.viewFive];
    
    //右按键Viewxxx的显示效果
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(-averageWidth * 4, 0);
    [self.viewFour setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewFour];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 3, 0);
    [self.viewThree setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewThree];
    
    myTransform = CGAffineTransformMakeTranslation(-averageWidth * 2, 0);
    [self.viewTwo setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewTwo];
    
    myTransform = CGAffineTransformMakeTranslation(0, 0);
    [self.viewOne setTransform:myTransform];
    [self.view bringSubviewToFront:self.viewOne];
    
    //设置view边框阴影效果
    self.viewOne.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.viewOne.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewOne.layer.shadowOpacity = 1.0;
    
    self.viewTwo.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewTwo.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewTwo.layer.shadowOpacity = 1.0;
    
    self.viewThree.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewThree.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewThree.layer.shadowOpacity = 1.0;
    
    self.viewFour.layer.shadowColor = [UIColor clearColor].CGColor;
    self.viewFour.layer.shadowOffset = CGSizeMake(2, 0);
    self.viewFour.layer.shadowOpacity = 1.0;

}

#pragma mark - VOICE MODE Dialog中的按键响应
-(void) btnMALEVOCALInVOICEMODEInDialogClicked
{
    buttonClickedInVOICEMODE = 1;
    
    //设置title的字体居中
    btnMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
   
    //设置标题的颜色
    [btnMALEVOCAL setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //设置背景颜色
    //[btnMALEVOCAL setBackgroundColor:[UIColor blueColor]];
    //图片被拉伸式地设置背景图片
    [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnMALEVOCAL];
    
    //其他按键处理
    //FEMALE VOCAL
    btnFEMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFEMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFEMALEVOCAL];
    
    //ELECTRIC GUITAR
    btnELECTRICGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnELECTRICGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnELECTRICGUITAR];
    
    //NYLON ACOUSTIC
    btnNYLONACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnNYLONACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnNYLONACOUSTIC];
    
    //STEEL ACOUSTIC
    btnSTEELACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSTEELACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSTEELACOUSTIC];
    
    //BASS GUITAR
    btnBASSGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBASSGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBASSGUITAR];
    
    //SYNTH PIANO
    btnSYNTHPIANO.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSYNTHPIANO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSYNTHPIANO];
    
    //BRASS
    btnBRASS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBRASS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBRASS];
    
    //WOOD WIND
    btnWOODWIND.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnWOODWIND setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnWOODWIND];
    
    //LOW BOOST
    btnLOWBOOST.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnLOWBOOST setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnLOWBOOST];

    //FLAT
    btnFLAT.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFLAT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFLAT];
}

-(void) btnFEMALEVOCALInVOICEMODEInDialogClicked
{
    buttonClickedInVOICEMODE = 2;
    
    //设置title的字体居中
    btnFEMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnFEMALEVOCAL setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //设置背景颜色
    //[btnMALEVOCAL setBackgroundColor:[UIColor blueColor]];
    //图片被拉伸式地设置背景图片
    [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFEMALEVOCAL];
    
    //其他按键处理
    //FEMALE VOCAL
    btnMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnMALEVOCAL];
    
    //ELECTRIC GUITAR
    btnELECTRICGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnELECTRICGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnELECTRICGUITAR];
    
    //NYLON ACOUSTIC
    btnNYLONACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnNYLONACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnNYLONACOUSTIC];
    
    //STEEL ACOUSTIC
    btnSTEELACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSTEELACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSTEELACOUSTIC];
    
    //BASS GUITAR
    btnBASSGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBASSGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBASSGUITAR];
    
    //SYNTH PIANO
    btnSYNTHPIANO.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSYNTHPIANO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSYNTHPIANO];
    
    //BRASS
    btnBRASS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBRASS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBRASS];
    
    //WOOD WIND
    btnWOODWIND.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnWOODWIND setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnWOODWIND];
    
    //LOW BOOST
    btnLOWBOOST.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnLOWBOOST setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnLOWBOOST];
    
    //FLAT
    btnFLAT.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFLAT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFLAT];
}

-(void) btnELECTRICGUITARInVOICEMODEInDialogClicked
{
    buttonClickedInVOICEMODE = 3;
    
    //设置title的字体居中
    btnELECTRICGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnELECTRICGUITAR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    //图片被拉伸式地设置背景图片
    [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnELECTRICGUITAR];
    
    //其他按键处理
    //MALE VOCAL
    btnMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnMALEVOCAL];
    
    //FEMALE VOCAL
    btnFEMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFEMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFEMALEVOCAL];
    
    //NYLON ACOUSTIC
    btnNYLONACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnNYLONACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnNYLONACOUSTIC];
    
    //STEEL ACOUSTIC
    btnSTEELACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSTEELACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSTEELACOUSTIC];
    
    //BASS GUITAR
    btnBASSGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBASSGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBASSGUITAR];
    
    //SYNTH PIANO
    btnSYNTHPIANO.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSYNTHPIANO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSYNTHPIANO];
    
    //BRASS
    btnBRASS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBRASS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBRASS];
    
    //WOOD WIND
    btnWOODWIND.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnWOODWIND setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnWOODWIND];
    
    //LOW BOOST
    btnLOWBOOST.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnLOWBOOST setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnLOWBOOST];
    
    //FLAT
    btnFLAT.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFLAT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFLAT];
}

-(void) btnNYLONACOUSTICInVOICEMODEInDialogClicked
{
    buttonClickedInVOICEMODE = 4;
    
    //设置title的字体居中
    btnNYLONACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnNYLONACOUSTIC setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //图片被拉伸式地设置背景图片
    [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnNYLONACOUSTIC];
    
    //其他按键处理
    //MALE VOCAL
    btnMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnMALEVOCAL];
    
    //FEMALE VOCAL
    btnFEMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFEMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFEMALEVOCAL];
    
    //ELECTRIC GUITAR
    btnELECTRICGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnELECTRICGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnELECTRICGUITAR];
    
    //STEEL ACOUSTIC
    btnSTEELACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSTEELACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSTEELACOUSTIC];
    
    //BASS GUITAR
    btnBASSGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBASSGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBASSGUITAR];
    
    //SYNTH PIANO
    btnSYNTHPIANO.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSYNTHPIANO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSYNTHPIANO];
    
    //BRASS
    btnBRASS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBRASS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBRASS];
    
    //WOOD WIND
    btnWOODWIND.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnWOODWIND setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnWOODWIND];
    
    //LOW BOOST
    btnLOWBOOST.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnLOWBOOST setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnLOWBOOST];
    
    //FLAT
    btnFLAT.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFLAT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFLAT];
}

-(void) btnSTEELACOUSTICInVOICEMODEInDialogClicked
{
    buttonClickedInVOICEMODE = 5;
    
    //设置title的字体居中
    btnSTEELACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnSTEELACOUSTIC setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //图片被拉伸式地设置背景图片
    [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSTEELACOUSTIC];
    
    //其他按键处理
    //MALE VOCAL
    btnMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnMALEVOCAL];
    
    //FEMALE VOCAL
    btnFEMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFEMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFEMALEVOCAL];
    
    //ELECTRIC GUITAR
    btnELECTRICGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnELECTRICGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnELECTRICGUITAR];
    
    //NYLON ACOUSTIC
    btnNYLONACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnNYLONACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnNYLONACOUSTIC];
    
    //BASS GUITAR
    btnBASSGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBASSGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBASSGUITAR];
    
    //SYNTH PIANO
    btnSYNTHPIANO.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSYNTHPIANO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSYNTHPIANO];
    
    //BRASS
    btnBRASS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBRASS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBRASS];
    
    //WOOD WIND
    btnWOODWIND.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnWOODWIND setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnWOODWIND];
    
    //LOW BOOST
    btnLOWBOOST.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnLOWBOOST setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnLOWBOOST];
    
    //FLAT
    btnFLAT.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFLAT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFLAT];
}

-(void) btnBASSGUITARInVOICEMODEInDialogClicked
{
    buttonClickedInVOICEMODE = 6;
    
    //设置title的字体居中
    btnBASSGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnBASSGUITAR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //图片被拉伸式地设置背景图片
    [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBASSGUITAR];
    
    //其他按键处理
    //MALE VOCAL
    btnMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnMALEVOCAL];
    
    //FEMALE VOCAL
    btnFEMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFEMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFEMALEVOCAL];
    
    //ELECTRIC GUITAR
    btnELECTRICGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnELECTRICGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnELECTRICGUITAR];
    
    //NYLON ACOUSTIC
    btnNYLONACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnNYLONACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnNYLONACOUSTIC];
    
    //STEEL ACOUSTIC
    btnSTEELACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSTEELACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSTEELACOUSTIC];
    
    //SYNTH PIANO
    btnSYNTHPIANO.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSYNTHPIANO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSYNTHPIANO];
    
    //BRASS
    btnBRASS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBRASS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBRASS];
    
    //WOOD WIND
    btnWOODWIND.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnWOODWIND setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnWOODWIND];
    
    //LOW BOOST
    btnLOWBOOST.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnLOWBOOST setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnLOWBOOST];
    
    //FLAT
    btnFLAT.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFLAT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFLAT];
}

-(void) btnSYNTHPIANOInVOICEMODEInDialogClicked
{
    buttonClickedInVOICEMODE = 7;
    
    //设置title的字体居中
    btnSYNTHPIANO.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnSYNTHPIANO setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //图片被拉伸式地设置背景图片
    [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSYNTHPIANO];
    
    //其他按键处理
    //MALE VOCAL
    btnMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnMALEVOCAL];
    
    //FEMALE VOCAL
    btnFEMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFEMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFEMALEVOCAL];
    
    //ELECTRIC GUITAR
    btnELECTRICGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnELECTRICGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnELECTRICGUITAR];
    
    //NYLON ACOUSTIC
    btnNYLONACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnNYLONACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnNYLONACOUSTIC];
    
    //STEEL ACOUSTIC
    btnSTEELACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSTEELACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSTEELACOUSTIC];
    
    //BASS GUITAR
    btnBASSGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBASSGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBASSGUITAR];
    
    //BRASS
    btnBRASS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBRASS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBRASS];
    
    //WOOD WIND
    btnWOODWIND.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnWOODWIND setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnWOODWIND];
    
    //LOW BOOST
    btnLOWBOOST.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnLOWBOOST setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnLOWBOOST];
    
    //FLAT
    btnFLAT.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFLAT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFLAT];
    
}

-(void) btnBRASSInVOICEMODEInDialogClicked
{
    buttonClickedInVOICEMODE = 8;
    
    //设置title的字体居中
    btnBRASS.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnBRASS setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //图片被拉伸式地设置背景图片
    [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBRASS];
    
    //其他按键处理
    //MALE VOCAL
    btnMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnMALEVOCAL];
    
    //FEMALE VOCAL
    btnFEMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFEMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFEMALEVOCAL];
    
    //ELECTRIC GUITAR
    btnELECTRICGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnELECTRICGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnELECTRICGUITAR];
    
    //NYLON ACOUSTIC
    btnNYLONACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnNYLONACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnNYLONACOUSTIC];
    
    //STEEL ACOUSTIC
    btnSTEELACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSTEELACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSTEELACOUSTIC];
    
    //BASS GUITAR
    btnBASSGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBASSGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBASSGUITAR];
    
    //SYNTH PIANO
    btnSYNTHPIANO.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSYNTHPIANO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSYNTHPIANO];
    
    //WOOD WIND
    btnWOODWIND.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnWOODWIND setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnWOODWIND];
    
    //LOW BOOST
    btnLOWBOOST.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnLOWBOOST setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnLOWBOOST];
    
    //FLAT
    btnFLAT.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFLAT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFLAT];
}

-(void) btnWOODWINDInVOICEMODEInDialogClicked
{
    buttonClickedInVOICEMODE = 9;
    
    //设置title的字体居中
    btnWOODWIND.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnWOODWIND setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //图片被拉伸式地设置背景图片
    [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnWOODWIND];
    
    //其他按键处理
    //MALE VOCAL
    btnMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnMALEVOCAL];
    
    //FEMALE VOCAL
    btnFEMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFEMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFEMALEVOCAL];
    
    //ELECTRIC GUITAR
    btnELECTRICGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnELECTRICGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnELECTRICGUITAR];
    
    //NYLON ACOUSTIC
    btnNYLONACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnNYLONACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnNYLONACOUSTIC];
    
    //STEEL ACOUSTIC
    btnSTEELACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSTEELACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSTEELACOUSTIC];
    
    //BASS GUITAR
    btnBASSGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBASSGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBASSGUITAR];
    
    //SYNTH PIANO
    btnSYNTHPIANO.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSYNTHPIANO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSYNTHPIANO];
    
    //BRASS
    btnBRASS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBRASS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBRASS];
    
    //LOW BOOST
    btnLOWBOOST.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnLOWBOOST setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnLOWBOOST];
    
    //FLAT
    btnFLAT.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFLAT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFLAT];
}

-(void) btnLOWBOOSTInVOICEMODEInDialogClicked
{
    buttonClickedInVOICEMODE = 10;
    
    //设置title的字体居中
    btnLOWBOOST.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnLOWBOOST setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //图片被拉伸式地设置背景图片
    [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnLOWBOOST];
    
    //其他按键处理
    //MALE VOCAL
    btnMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnMALEVOCAL];
    
    //FEMALE VOCAL
    btnFEMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFEMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFEMALEVOCAL];
    
    //ELECTRIC GUITAR
    btnELECTRICGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnELECTRICGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnELECTRICGUITAR];
    
    //NYLON ACOUSTIC
    btnNYLONACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnNYLONACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnNYLONACOUSTIC];
    
    //STEEL ACOUSTIC
    btnSTEELACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSTEELACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSTEELACOUSTIC];
    
    //BASS GUITAR
    btnBASSGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBASSGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBASSGUITAR];
    
    //SYNTH PIANO
    btnSYNTHPIANO.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSYNTHPIANO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSYNTHPIANO];
    
    //BRASS
    btnBRASS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBRASS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBRASS];
    
    //WOOD WIND
    btnWOODWIND.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnWOODWIND setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnWOODWIND];
    
    //FLAT
    btnFLAT.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFLAT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFLAT];
}

-(void) btnFLATInVOICEMODEInDialogClicked
{
    buttonClickedInVOICEMODE = 11;
    
    //设置title的字体居中
    btnFLAT.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnFLAT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //图片被拉伸式地设置背景图片
    [btnFLAT setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFLAT];
    
    //其他按键处理
    //MALE VOCAL
    btnMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnMALEVOCAL];
    
    //FEMALE VOCAL
    btnFEMALEVOCAL.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnFEMALEVOCAL setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnFEMALEVOCAL setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnFEMALEVOCAL];
    
    //ELECTRIC GUITAR
    btnELECTRICGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnELECTRICGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnELECTRICGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnELECTRICGUITAR];
    
    //NYLON ACOUSTIC
    btnNYLONACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnNYLONACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnNYLONACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnNYLONACOUSTIC];
    
    //STEEL ACOUSTIC
    btnSTEELACOUSTIC.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSTEELACOUSTIC setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSTEELACOUSTIC setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSTEELACOUSTIC];
    
    //BASS GUITAR
    btnBASSGUITAR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBASSGUITAR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBASSGUITAR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBASSGUITAR];
    
    //SYNTH PIANO
    btnSYNTHPIANO.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnSYNTHPIANO setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSYNTHPIANO setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnSYNTHPIANO];
    
    //BRASS
    btnBRASS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnBRASS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBRASS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnBRASS];
    
    //WOOD WIND
    btnWOODWIND.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnWOODWIND setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnWOODWIND setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnWOODWIND];
    
    //LOW BOOST
    btnLOWBOOST.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnLOWBOOST setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLOWBOOST setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnLOWBOOST];
}

-(void) btnCOMPRESSORInFXSELECTORInDialogClicked
{
    buttonClickedInFXSELECTOR= 1;
    
    //设置title的字体居中
    btnCOMPRESSOR.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnCOMPRESSOR setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //图片被拉伸式地设置背景图片
    [btnCOMPRESSOR setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnCOMPRESSOR];
    
    //其他按键处理
    //CHORUS
    btnCHORUS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnCHORUS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnCHORUS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnCHORUS];
    
    //DELAY
    btnDELAY.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnDELAY setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDELAY setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnDELAY];
    
    //Reverb Delay
    btnReverbDelay.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnReverbDelay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnReverbDelay setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnReverbDelay];

}

-(void) btnCHORUSInFXSELECTORInDialogClicked
{
    buttonClickedInFXSELECTOR= 2;
    
    //设置title的字体居中
    btnCHORUS.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnCHORUS setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //图片被拉伸式地设置背景图片
    [btnCHORUS setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnCHORUS];
    
    //其他按键处理
    //COMPRESSOR
    btnCOMPRESSOR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnCOMPRESSOR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnCOMPRESSOR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnCOMPRESSOR];
    
    //DELAY
    btnDELAY.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnDELAY setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDELAY setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnDELAY];
    
    //Reverb Delay
    btnReverbDelay.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnReverbDelay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnReverbDelay setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnReverbDelay];
}

-(void) btnDELAYInFXSELECTORInDialogClicked
{
    buttonClickedInFXSELECTOR= 3;
    
    //设置title的字体居中
    btnDELAY.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnDELAY setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //图片被拉伸式地设置背景图片
    [btnDELAY setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnDELAY];
    
    //其他按键处理
    //COMPRESSOR
    btnCOMPRESSOR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnCOMPRESSOR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnCOMPRESSOR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnCOMPRESSOR];
    
    //CHORUS
    btnCHORUS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnCHORUS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnCHORUS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnCHORUS];
    
    //Reverb Delay
    btnReverbDelay.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnReverbDelay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnReverbDelay setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnReverbDelay];
}

-(void) btnReverbDelayInFXSELECTORInDialogClicked
{
    buttonClickedInFXSELECTOR= 4;
    
    //设置title的字体居中
    btnReverbDelay.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //设置标题的颜色
    [btnReverbDelay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //图片被拉伸式地设置背景图片
    [btnReverbDelay setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnReverbDelay];
    
    //其他按键处理
    //COMPRESSOR
    btnCOMPRESSOR.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnCOMPRESSOR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnCOMPRESSOR setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnCOMPRESSOR];
    
    //CHORUS
    btnCHORUS.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnCHORUS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnCHORUS setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnCHORUS];
    
    //DELAY
    btnDELAY.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btnDELAY setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDELAY setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [contentView addSubview:btnDELAY];
}


#pragma mark - segment响应
//segment点击响应
- (IBAction)segmentTapped:(id)sender {
    
    UISegmentedControl *segment = sender;
    
    if (segment.selectedSegmentIndex == 0){
        
        self.viewMainEQInViewFiveDetail.hidden = NO;
        self.viewFeedbackInViewFiveDetail.hidden = YES;
        self.viewAboutInViewFiveDetail.hidden = YES;
    }
    
    if (segment.selectedSegmentIndex == 1){
    
        self.viewMainEQInViewFiveDetail.hidden = YES;
        self.viewFeedbackInViewFiveDetail.hidden = NO;
        self.viewAboutInViewFiveDetail.hidden = YES;
        
    }
    
    if (segment.selectedSegmentIndex == 2){
        
        self.viewMainEQInViewFiveDetail.hidden = YES;
        self.viewFeedbackInViewFiveDetail.hidden = YES;
        self.viewAboutInViewFiveDetail.hidden = NO;
    
        self.labelOneInAboutInViewFiveDetail.text = @"Software Version: V1.0.0\nBlueTooth Version: V4.0\nAuthor: GPE-SSE";
        self.labelOneInAboutInViewFiveDetail.font = [UIFont fontWithName:@"Arial" size:18];
        self.labelOneInAboutInViewFiveDetail.numberOfLines = 0;
        
        self.labelTwoInAboutInViewFiveDetail.text = @"GPE Support";
        self.labelTwoInAboutInViewFiveDetail.userInteractionEnabled = YES;                  //允许用户交互
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];                                                         //为label添加响应
        [self.labelTwoInAboutInViewFiveDetail addGestureRecognizer:labelTapGestureRecognizer];
        
        
        self.labelTwoInAboutInViewFiveDetail.textColor = [UIColor blueColor];
        self.labelTwoInAboutInViewFiveDetail.font = [UIFont fontWithName:@"Arial" size:20];
        
        self.labelThreeInAboutInViewFiveDetail.text = @"© Copyright 2016.All right reserved";
        self.labelThreeInAboutInViewFiveDetail.font = [UIFont fontWithName:@"Arial" size:12];
    }
}

- (IBAction)btnOneDownInViewFiveDetailTapped:(id)sender {
    
}

- (IBAction)btnTwoDownInViewFiveDetailTapped:(id)sender {
}

- (IBAction)btnThreeDownInViewFiveDetailTapped:(id)sender {
}

- (IBAction)btnOneUpInViewFiveDetailTapped:(id)sender {
}

- (IBAction)btnTwoUpInViewFiveDetailTapped:(id)sender {
}

- (IBAction)btnThreeUpInViewFiveDetailTapped:(id)sender {
}


#pragma mark - KARAOKE Mode
-(void)onClickImageViewSMALL{
    
    NSLog(@"ImageViewSMALL被点击!");
    
    
    [self.imageViewSMALLInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_01_lit"]];
    
    [self.imageViewMIDInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_02"]];
    
    [self.imageViewLARGEInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_03"]];
    
    [self.imageViewKARAOKEInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_04"]];
}

-(void)onClickImageViewMID{
    
    NSLog(@"ImageViewMID图片被点击!");
    
    [self.imageViewSMALLInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_01"]];
    
    [self.imageViewMIDInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_02_lit"]];
    
    [self.imageViewLARGEInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_03"]];
    
    [self.imageViewKARAOKEInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_04"]];
}

-(void)onClickImageViewLARGE{
    
    NSLog(@"ImageViewLARGE图片被点击!");

    [self.imageViewSMALLInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_01"]];
    
    [self.imageViewMIDInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_02"]];
    
    [self.imageViewLARGEInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_03_lit"]];
    
    [self.imageViewKARAOKEInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_04"]];
}

-(void)onClickImageViewKARAOKE{
    
    NSLog(@"ImageViewKARAOKE图片被点击!");
    
    [self.imageViewSMALLInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_01"]];
    
    [self.imageViewMIDInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_02"]];
    
    [self.imageViewLARGEInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_03"]];
    
    [self.imageViewKARAOKEInViewFourDetail setImage:[UIImage imageNamed:@"drawable_master_fx_04_lit"]];
}

#pragma mark - Mute按键响应
- (IBAction)btnMuteInViewOneTapped:(id)sender {
    
    
    
    if (btnMuteInViewOneStatusFlag == false){
        [self.btSerialPort sendCmdStr:MUTE_ON_CMD];
        btnMuteInViewOneStatusFlag = true;
        self.btnMuteInViewOne.hidden = YES;
        self.btnMuteInViewOnePress.hidden = NO;

        
        //image不可选
        CGRect btnMuteCannotChooseRect = CGRectMake(self.imageViewInViewOne.frame.origin.x, self.imageViewInViewOne.frame.origin.y, self.imageViewInViewOne.frame.size.width, self.imageViewInViewOne.frame.size.height);
        imageViewCannotChooseViewInViewOne = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        imageViewCannotChooseViewInViewOne.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewOne addSubview:imageViewCannotChooseViewInViewOne];
        
        imageViewCannotChooseViewInViewOne.hidden = NO;
//        timerOne = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeActionOne) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] run];

    }else{
        [self.btSerialPort sendCmdStr:MUTE_OFF_CMD];
        btnMuteInViewOneStatusFlag = false;
        self.btnMuteInViewOne.hidden = NO;
        self.btnMuteInViewOnePress.hidden = YES;
//        [timerOne invalidate];
//        timerOne = nil;
//        [self.imageViewInViewOne setImage:[UIImage imageNamed:@"drawable_seekbar_scale"]];
//        [self.btnMuteInViewOne setBackgroundImage:[UIImage imageNamed: @"drawable_white_button.9"] forState:UIControlStateHighlighted];
        imageViewCannotChooseViewInViewOne.hidden = YES;
    }
    
    

}

- (IBAction)btnMuteInViewTwoTapped:(id)sender {
    
    if (btnMuteInViewTwoStatusFlag == false){
        
        [self.btSerialPort sendCmdStr:MUTE_ON_CMD];
        btnMuteInViewTwoStatusFlag = true;
        self.btnMuteInViewTwo.hidden = YES;
        self.btnMuteInViewTwoPress.hidden = NO;
        
        //image不可选
        CGRect btnMuteCannotChooseRect = CGRectMake(self.imageViewInViewTwo.frame.origin.x, self.imageViewInViewTwo.frame.origin.y, self.imageViewInViewTwo.frame.size.width, self.imageViewInViewTwo.frame.size.height);
        imageViewCannotChooseViewInViewTwo = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        imageViewCannotChooseViewInViewTwo.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewTwo addSubview:imageViewCannotChooseViewInViewTwo];
        
        imageViewCannotChooseViewInViewTwo.hidden = NO;
//        timerTwo = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeActionTwo) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] run];
        
    }else{
        
        [self.btSerialPort sendCmdStr:MUTE_OFF_CMD];
        btnMuteInViewTwoStatusFlag = false;
        self.btnMuteInViewTwo.hidden = NO;
        self.btnMuteInViewTwoPress.hidden = YES;
//        [timerTwo invalidate];
//        timerTwo = nil;
//        [self.imageViewInViewTwo setImage:[UIImage imageNamed:@"drawable_seekbar_scale"]];
        [self.btnMuteInViewTwo setBackgroundImage:[UIImage imageNamed: @"drawable_white_button.9"] forState:UIControlStateHighlighted];
        imageViewCannotChooseViewInViewTwo.hidden = YES;
    }

}

- (IBAction)btnMuteInViewThreeTapped:(id)sender {
    
    if (btnMuteInViewThreeStatusFlag == false){
        
        [self.btSerialPort sendCmdStr:MUTE_ON_CMD];
        btnMuteInViewThreeStatusFlag = true;
        self.btnMuteInViewThree.hidden = YES;
        self.btnMuteInViewThreePress.hidden = NO;
        
        //image不可选
        CGRect btnMuteCannotChooseRect = CGRectMake(self.imageViewInViewThree.frame.origin.x, self.imageViewInViewThree.frame.origin.y, self.imageViewInViewThree.frame.size.width, self.imageViewInViewThree.frame.size.height);
        imageViewCannotChooseViewInViewThree = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        imageViewCannotChooseViewInViewThree.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewThree addSubview:imageViewCannotChooseViewInViewThree];
        
        imageViewCannotChooseViewInViewThree.hidden = NO;
//        timerThree = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeActionThree) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] run];

    }else{
        
        [self.btSerialPort sendCmdStr:MUTE_OFF_CMD];
        btnMuteInViewThreeStatusFlag = false;
        self.btnMuteInViewThree.hidden = NO;
        self.btnMuteInViewThreePress.hidden = YES;
//        [timerThree invalidate];
//        timerThree = nil;
//        [self.imageViewInViewThree setImage:[UIImage imageNamed:@"drawable_seekbar_scale"]];
        [self.btnMuteInViewThree setBackgroundImage:[UIImage imageNamed: @"drawable_white_button.9"] forState:UIControlStateHighlighted];
        
        imageViewCannotChooseViewInViewThree.hidden = YES;
    }

}

- (IBAction)btnMuteInViewFourTapped:(id)sender {
    
    if (btnMuteInViewFourStatusFlag == false){
        
        [self.btSerialPort sendCmdStr:MUTE_ON_CMD];
        btnMuteInViewFourStatusFlag = true;
        self.btnMuteInViewFour.hidden = YES;
        self.btnMuteInViewFourPress.hidden = NO;
        
        //image不可选
        CGRect btnMuteCannotChooseRect = CGRectMake(self.imageViewInViewFour.frame.origin.x, self.imageViewInViewFour.frame.origin.y, self.imageViewInViewFour.frame.size.width, self.imageViewInViewFour.frame.size.height);
        imageViewCannotChooseViewInViewFour = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        imageViewCannotChooseViewInViewFour.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewFour addSubview:imageViewCannotChooseViewInViewFour];
        
        imageViewCannotChooseViewInViewFour.hidden = NO;
//        timerFour = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeActionFour) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] run];
    }else{
        
        [self.btSerialPort sendCmdStr:MUTE_OFF_CMD];
        btnMuteInViewFourStatusFlag = false;
        self.btnMuteInViewFour.hidden = NO;
        self.btnMuteInViewFourPress.hidden = YES;
//        [timerFour invalidate];
//        timerFour = nil;
//        [self.imageViewInViewFour setImage:[UIImage imageNamed:@"drawable_seekbar_scale"]];
        [self.btnMuteInViewFour setBackgroundImage:[UIImage imageNamed: @"drawable_white_button.9"] forState:UIControlStateHighlighted];
        
        imageViewCannotChooseViewInViewFour.hidden = YES;
    }

}

- (IBAction)btnMuteInViewFiveTapped:(id)sender {
    
    if (btnMuteInViewFiveStatusFlag == false){
        
        [self.btSerialPort sendCmdStr:MUTE_ON_CMD];
        
        btnMuteInViewFiveStatusFlag = true;
        self.btnMuteInViewFive.hidden = YES;
        self.btnMuteInViewFivePress.hidden = NO;
        
        //image不可选
        CGRect btnMuteCannotChooseRect = CGRectMake(self.imageViewInViewFive.frame.origin.x, self.imageViewInViewFive.frame.origin.y, self.imageViewInViewFive.frame.size.width, self.imageViewInViewFive.frame.size.height);
        imageViewCannotChooseViewInViewFive = [[UIView alloc] initWithFrame:btnMuteCannotChooseRect];
        imageViewCannotChooseViewInViewFive.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:0.4f];
        [self.viewFive addSubview:imageViewCannotChooseViewInViewFive];
        
        imageViewCannotChooseViewInViewFive.hidden = NO;
//        timerFive = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeActionFive) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] run];
    }else{
        
        [self.btSerialPort sendCmdStr:MUTE_OFF_CMD];
        
        btnMuteInViewFiveStatusFlag = false;
        self.btnMuteInViewFive.hidden = NO;
        self.btnMuteInViewFivePress.hidden = YES;
//        [timerFive invalidate];
//        timerFive = nil;
//        [self.imageViewInViewFive setImage:[UIImage imageNamed:@"drawable_seekbar_scale"]];
        [self.btnMuteInViewFive setBackgroundImage:[UIImage imageNamed: @"drawable_white_button.9"] forState:UIControlStateHighlighted];
        
         imageViewCannotChooseViewInViewFive.hidden = YES;
    }

}

/*
- (IBAction)btnFlatInViewFiveDetailTapped:(id)sender {
    

    [self.btnFlatInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [self.btnFlatInViewFiveDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.btnDJInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [self.btnDJInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.btnSoloInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [self.btnSoloInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.btnVoiceInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [self.btnVoiceInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.imageViewFlatInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_01_lit"]];
    
    [self.imageViewDJInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_02"]];
    
    [self.imageViewSoloInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_03"]];
    
    [self.imageViewVoiceInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_04"]];


}

- (IBAction)btnDJInViewFiveDetailTapped:(id)sender {
    
    [self.btnFlatInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
   
    [self.btnFlatInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.btnDJInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [self.btnDJInViewFiveDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.btnSoloInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [self.btnSoloInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.btnVoiceInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [self.btnVoiceInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.imageViewFlatInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_01"]];
    
    [self.imageViewDJInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_02_lit"]];
    
    [self.imageViewSoloInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_03"]];
    
    [self.imageViewVoiceInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_04"]];
    
}

- (IBAction)btnSoloInViewFiveDetailTapped:(id)sender {
    
    [self.btnFlatInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [self.btnFlatInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.btnDJInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [self.btnDJInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.btnSoloInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [self.btnSoloInViewFiveDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.btnVoiceInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [self.btnVoiceInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.imageViewFlatInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_01"]];
    
    [self.imageViewDJInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_02"]];
    
    [self.imageViewSoloInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_03_lit"]];
    
    [self.imageViewVoiceInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_04"]];
}

- (IBAction)btnVoiceInViewFiveDetailTapped:(id)sender {
    
    [self.btnFlatInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [self.btnFlatInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.btnDJInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [self.btnDJInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.btnSoloInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    [self.btnSoloInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.btnVoiceInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    [self.btnVoiceInViewFiveDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.imageViewFlatInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_01"]];
    
    [self.imageViewDJInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_02"]];
    
    [self.imageViewSoloInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_03"]];
    
    [self.imageViewVoiceInViewFiveDetail setImage:[UIImage imageNamed:@"drawable_master_fx_04_lit"]];
}

- (IBAction)btnInFeedbackInViewFiveDetailTapped:(id)sender {
    
    if (btnInFeedbackInViewFiveDetailStatus == true){
        
        btnInFeedbackInViewFiveDetailStatus = false;
        
        [self.btnInFeedbackInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
        [self.btnInFeedbackInViewFiveDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        btnInFeedbackInViewFiveDetailStatus = true;
    
        [self.btnInFeedbackInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
        [self.btnInFeedbackInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
*/
-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    UIWebView *myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, width, height)];//rect是你设计好大小的矩形
    NSURL *url = [NSURL URLWithString:@"http://www.goldpeak.com"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:req];
    [self.view addSubview:myWebView];
}

#pragma mark - 电平灯timeAction
-(void)timeActionOne
{
   
    r = arc4random_uniform(9);
    
    switch (r) {
        case 0:
            [self.imageViewInViewOne setImage:[UIImage imageNamed:@"drawable_seekbar_scale"]];
            break;
        case 1:
            [self.imageViewInViewOne setImage:[UIImage imageNamed:@"drawable_seekbar_scale_one_led_bright"]];
            break;
        case 2:
            [self.imageViewInViewOne setImage:[UIImage imageNamed:@"drawable_seekbar_scale_two_led_bright"]];
            break;
        case 3:
            [self.imageViewInViewOne setImage:[UIImage imageNamed:@"drawable_seekbar_scale_three_led_bright"]];
            break;
        case 4:
            [self.imageViewInViewOne setImage:[UIImage imageNamed:@"drawable_seekbar_scale_four_led_bright"]];
            break;
        case 5:
            [self.imageViewInViewOne setImage:[UIImage imageNamed:@"drawable_seekbar_scale_five_led_bright"]];
            break;
        case 6:
            [self.imageViewInViewOne setImage:[UIImage imageNamed:@"drawable_seekbar_scale_six_led_bright"]];
            break;
        case 7:
            [self.imageViewInViewOne setImage:[UIImage imageNamed:@"drawable_seekbar_scale_seven_led_bright"]];
            break;
        case 8:
            [self.imageViewInViewOne setImage:[UIImage imageNamed:@"drawable_seekbar_scale_eight_led_bright"]];
            break;
        default:
            break;
    }

}

-(void)timeActionTwo
{
   
    r = arc4random_uniform(9);
    
    switch (r) {
        case 0:
            [self.imageViewInViewTwo setImage:[UIImage imageNamed:@"drawable_seekbar_scale"]];
            break;
        case 1:
            [self.imageViewInViewTwo setImage:[UIImage imageNamed:@"drawable_seekbar_scale_one_led_bright"]];
            break;
        case 2:
            [self.imageViewInViewTwo setImage:[UIImage imageNamed:@"drawable_seekbar_scale_two_led_bright"]];
            break;
        case 3:
            [self.imageViewInViewTwo setImage:[UIImage imageNamed:@"drawable_seekbar_scale_three_led_bright"]];
            break;
        case 4:
            [self.imageViewInViewTwo setImage:[UIImage imageNamed:@"drawable_seekbar_scale_four_led_bright"]];
            break;
        case 5:
            [self.imageViewInViewTwo setImage:[UIImage imageNamed:@"drawable_seekbar_scale_five_led_bright"]];
            break;
        case 6:
            [self.imageViewInViewTwo setImage:[UIImage imageNamed:@"drawable_seekbar_scale_six_led_bright"]];
            break;
        case 7:
            [self.imageViewInViewTwo setImage:[UIImage imageNamed:@"drawable_seekbar_scale_seven_led_bright"]];
            break;
        case 8:
            [self.imageViewInViewTwo setImage:[UIImage imageNamed:@"drawable_seekbar_scale_eight_led_bright"]];
            break;
        default:
            break;
    }
        
}
    
-(void)timeActionThree
{
    r = arc4random_uniform(9);
    
    switch (r) {
        case 0:
            [self.imageViewInViewThree setImage:[UIImage imageNamed:@"drawable_seekbar_scale"]];
            break;
        case 1:
            [self.imageViewInViewThree setImage:[UIImage imageNamed:@"drawable_seekbar_scale_one_led_bright"]];
            break;
        case 2:
            [self.imageViewInViewThree setImage:[UIImage imageNamed:@"drawable_seekbar_scale_two_led_bright"]];
            break;
        case 3:
            [self.imageViewInViewThree setImage:[UIImage imageNamed:@"drawable_seekbar_scale_three_led_bright"]];
            break;
        case 4:
            [self.imageViewInViewThree setImage:[UIImage imageNamed:@"drawable_seekbar_scale_four_led_bright"]];
            break;
        case 5:
            [self.imageViewInViewThree setImage:[UIImage imageNamed:@"drawable_seekbar_scale_five_led_bright"]];
            break;
        case 6:
            [self.imageViewInViewThree setImage:[UIImage imageNamed:@"drawable_seekbar_scale_six_led_bright"]];
            break;
        case 7:
            [self.imageViewInViewThree setImage:[UIImage imageNamed:@"drawable_seekbar_scale_seven_led_bright"]];
            break;
        case 8:
            [self.imageViewInViewThree setImage:[UIImage imageNamed:@"drawable_seekbar_scale_eight_led_bright"]];
            break;
        default:
            break;
    }
        
}

-(void)timeActionFour
{
    r = arc4random_uniform(9);
    
    switch (r) {
        case 0:
            [self.imageViewInViewFour setImage:[UIImage imageNamed:@"drawable_seekbar_scale"]];
            break;
        case 1:
            [self.imageViewInViewFour setImage:[UIImage imageNamed:@"drawable_seekbar_scale_one_led_bright"]];
            break;
        case 2:
            [self.imageViewInViewFour setImage:[UIImage imageNamed:@"drawable_seekbar_scale_two_led_bright"]];
            break;
        case 3:
            [self.imageViewInViewFour setImage:[UIImage imageNamed:@"drawable_seekbar_scale_three_led_bright"]];
            break;
        case 4:
            [self.imageViewInViewFour setImage:[UIImage imageNamed:@"drawable_seekbar_scale_four_led_bright"]];
            break;
        case 5:
            [self.imageViewInViewFour setImage:[UIImage imageNamed:@"drawable_seekbar_scale_five_led_bright"]];
            break;
        case 6:
            [self.imageViewInViewFour setImage:[UIImage imageNamed:@"drawable_seekbar_scale_six_led_bright"]];
            break;
        case 7:
            [self.imageViewInViewFour setImage:[UIImage imageNamed:@"drawable_seekbar_scale_seven_led_bright"]];
            break;
        case 8:
            [self.imageViewInViewFour setImage:[UIImage imageNamed:@"drawable_seekbar_scale_eight_led_bright"]];
            break;
        default:
            break;
    }
    
}

-(void)timeActionFive
{
    r = arc4random_uniform(9);
    
    switch (r) {
        case 0:
            [self.imageViewInViewFive setImage:[UIImage imageNamed:@"drawable_seekbar_scale"]];
            break;
        case 1:
            [self.imageViewInViewFive setImage:[UIImage imageNamed:@"drawable_seekbar_scale_one_led_bright"]];
            break;
        case 2:
            [self.imageViewInViewFive setImage:[UIImage imageNamed:@"drawable_seekbar_scale_two_led_bright"]];
            break;
        case 3:
            [self.imageViewInViewFive setImage:[UIImage imageNamed:@"drawable_seekbar_scale_three_led_bright"]];
            break;
        case 4:
            [self.imageViewInViewFive setImage:[UIImage imageNamed:@"drawable_seekbar_scale_four_led_bright"]];
            break;
        case 5:
            [self.imageViewInViewFive setImage:[UIImage imageNamed:@"drawable_seekbar_scale_five_led_bright"]];
            break;
        case 6:
            [self.imageViewInViewFive setImage:[UIImage imageNamed:@"drawable_seekbar_scale_six_led_bright"]];
            break;
        case 7:
            [self.imageViewInViewFive setImage:[UIImage imageNamed:@"drawable_seekbar_scale_seven_led_bright"]];
            break;
        case 8:
            [self.imageViewInViewFive setImage:[UIImage imageNamed:@"drawable_seekbar_scale_eight_led_bright"]];
            break;
        default:
            break;
    }
    
}

#pragma mark - BTSerialPortDelegate
- (void)btSerialPortPoweredOn:(NSNumber *)result {
    
    if ([result boolValue]) {
        [self.btSerialPort connect];
    } else {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"BT Connect" message:@"Failed! make sure you have opened BT" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
        }];
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];        
    }
}


- (void)receiveCmdStr:(NSString *)str {
    
    NSLog(@"Received %@ from BTSerialPort", str);
    const char *receiveBuffTemp = [str cStringUsingEncoding: [NSString defaultCStringEncoding]];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < str.length; i++)
    {
        array[i] = [NSNumber numberWithChar:receiveBuffTemp[i]];
    }
    
    BOOL result = [bleDataFormat checkSum:array];
    if (result) {
        
    }
    

    NSLog(@"收到的数据：%s", receiveBuffTemp);
}


- (IBAction)btnLIMITERInFeedbackInViewFiveDetailTapped:(id)sender{

    //LIMITER
    [self.btnLIMITERInFeedbackInViewFiveDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnLIMITERInFeedbackInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    
    //FB SUPPRESSOR
    [self.btnFBSUPPRESSORInFeedbackInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnFBSUPPRESSORInFeedbackInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    
    //BASS BOOST
    [self.btnBASSBOOSTInFeedbackInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnBASSBOOSTInFeedbackInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    
}

- (IBAction)btnFBSUPPRESSORInFeedbackInViewFiveDetailTapped:(id)sender {
    
    //LIMITER
    [self.btnLIMITERInFeedbackInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnLIMITERInFeedbackInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    
    //FB SUPPRESSOR
    [self.btnFBSUPPRESSORInFeedbackInViewFiveDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnFBSUPPRESSORInFeedbackInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
    
    //BASS BOOST
    [self.btnBASSBOOSTInFeedbackInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnBASSBOOSTInFeedbackInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
}

- (IBAction)btnBASSBOOSTInFeedbackInViewFiveDetailTapped:(id)sender {
    
    //LIMITER

    [self.btnLIMITERInFeedbackInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnLIMITERInFeedbackInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    
    //FB SUPPRESSOR
    [self.btnFBSUPPRESSORInFeedbackInViewFiveDetail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnFBSUPPRESSORInFeedbackInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_white_button.9.png"] forState:UIControlStateNormal];
    
    //BASS BOOST
    [self.btnBASSBOOSTInFeedbackInViewFiveDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnBASSBOOSTInFeedbackInViewFiveDetail setBackgroundImage:[UIImage imageNamed:@"drawable_green_button.9.png"] forState:UIControlStateNormal];
}
@end
