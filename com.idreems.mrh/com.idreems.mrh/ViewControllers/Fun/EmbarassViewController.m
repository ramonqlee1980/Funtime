//
//  MainViewController.m
//  NetDemo
//
//  Created by 海锋 周 on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EmbarassViewController.h"
#import "Constants.h"
#define FTop      0
#define FRecent   1
#define FPhoto    2

#define FRegsiter 10
#define FLogin    102
#define FHelp     103
#define FSetting  106
#define FFourtype 108
#define FWrite    109

#define kFun @"kFun"
#define kTitle @"Title"

@interface EmbarassViewController ()
-(void) BtnClicked:(id)sender;
@end

@implementation EmbarassViewController
@synthesize m_helpView,helpimageView,isShowHelp,m_contentView;
@synthesize headlogoView;
@synthesize loginbtn,topbtn,regsiterbtn,settingbtn,writebtn,photobtn,helpbtn,recentbtn,fourTypebtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(kFun, "");
        self.tabBarItem.image = [UIImage imageNamed:kIconFun];
        self.navigationItem.title = NSLocalizedString(kTitle, "");
        self.navigationController.navigationBarHidden = YES;
    }
    return self;
}

-(void) BtnClicked:(id)sender
{
#if 1
    UISegmentedControl *btn =(UISegmentedControl *) sender;
    switch (btn.selectedSegmentIndex) {
        /*case FLogin:
        {
            LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
            [loginView.view setFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
            [self presentViewController:loginView animated:YES completion:^{
            }];
        }break;
        case FRegsiter:
        {
            helpbtn.hidden = YES;
            regsiterbtn.hidden =YES;
            loginbtn.hidden =YES;
            headlogoView.hidden = YES;
            
            topbtn.hidden = NO;
            recentbtn.hidden = NO;
            settingbtn.hidden = NO;
            photobtn.hidden = NO;
            fourTypebtn.hidden=NO;
            writebtn.hidden=NO;
            
            topbtn.enabled = NO;
            recentbtn.enabled = YES;
            settingbtn.enabled = YES;
        }break;
        case FWrite:
        {
            helpbtn.hidden = NO;
            regsiterbtn.hidden =NO;
            loginbtn.hidden =NO;
            headlogoView.hidden = NO;
            
            topbtn.hidden = YES;
            recentbtn.hidden = YES;
            settingbtn.hidden = YES;
            photobtn.hidden = YES;
            fourTypebtn.hidden=YES;
            writebtn.hidden=YES;
            
            topbtn.enabled = NO;
            recentbtn.enabled = NO;
            settingbtn.enabled = NO;
        }break;
        case FHelp:
        {
            if (isShowHelp) {
                [UIView animateWithDuration:0.8f animations:^{
                    isShowHelp = NO;
                    [m_helpView setAlpha:0.f];
                    [helpimageView setFrame:CGRectMake(0,720-44-229,320,209)];
                }];
            }else {
                [UIView animateWithDuration:0.8f animations:^{
                    isShowHelp = YES;
                    [m_helpView setAlpha:0.85f];
                    [helpimageView setFrame:CGRectMake(0,480-44-229,320,209)];
                }];
            }
           
        }break;
            */
        case FTop:
        {
            topbtn.enabled = NO;
            recentbtn.enabled = YES;
            settingbtn.enabled = YES;
            [m_contentView LoadPageOfQiushiType:QiuShiTypeTop Time:QiuShiTimeRandom];
             [fourTypebtn setTitle:@"最糗" forState:UIControlStateNormal];
            
        }break;  
        case FRecent:
        {
            topbtn.enabled = YES;
            recentbtn.enabled = NO;
            settingbtn.enabled = YES;
            [m_contentView LoadPageOfQiushiType:QiuShiTypeNew Time:QiuShiTimeRandom];
            [fourTypebtn setTitle:@"最新" forState:UIControlStateNormal];
        }break;
        case FPhoto:
        {
            topbtn.enabled = YES;
            recentbtn.enabled = YES;
            settingbtn.enabled = YES;
            [m_contentView LoadPageOfQiushiType:QiuShiTypePhoto Time:QiuShiTimeRandom];
            [fourTypebtn setTitle:@"真相" forState:UIControlStateNormal];
        }break;
        /*case FSetting:
        {
            topbtn.enabled = YES;
            recentbtn.enabled = YES;
            settingbtn.enabled = YES;
            m_settingView = [[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
           [m_settingView.view setFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-20)];
            [self.view addSubview:m_settingView.view];
            
        }break;
        */
        default:
            break;
    }
#endif
}
-(void)loadSegmentBar
{
    const CGFloat kNavigationBarInnerViewMargin = 7;
    const CGFloat segmentedControlHeight = self.navigationController.navigationBar.frame.size.height-kNavigationBarInnerViewMargin*2;
    // segmented control as the custom title view
	NSArray *segmentTextContent = [NSArray arrayWithObjects:
                                   NSLocalizedString(@"最糗", @""),
                                   NSLocalizedString(@"最新", @""),
                                   NSLocalizedString(@"真相", @""),
								   nil];
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
	segmentedControl.selectedSegmentIndex = FRecent;//the middle one
	segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.frame = CGRectMake(0, 0, 400, segmentedControlHeight);
	[segmentedControl addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventValueChanged];
	
    //	defaultTintColor = [segmentedControl.tintColor retain];	// keep track of this for later
    
	self.navigationItem.titleView = segmentedControl;
	[segmentedControl release];
}
-(void)back
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSegmentBar];
    // Do any additional setup after loading the view from its nib.
   
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = backButton;
    [backButton release];
#if 0
    //添加headbar
    UIImage *headimage = [UIImage imageNamed:@"head_background.png"];
    UIImageView *headView = [[UIImageView alloc]initWithImage:headimage];
    [headView setFrame:CGRectMake(0, 0, 320, 44)];
    [self.view addSubview:headView];
    [headView release];
    [headimage release];
    //糗事百科logo
    UIImage *logoimage = [UIImage imageNamed:@"head_logo.png"];
    headlogoView = [[UIImageView alloc]initWithImage:logoimage];
    [headlogoView setFrame:CGRectMake(103, 6, 113, 32)];
    [self.view addSubview:headlogoView];
    [headlogoView release];
    [logoimage release];
    
    //topbar 的按钮
    photobtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photobtn setFrame:CGRectMake(8,6,32,32)];
    [photobtn setBackgroundImage:[UIImage imageNamed:@"icon_pic_enable.png"] forState:UIControlStateNormal];
    [photobtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [photobtn setTag:FPhoto];
    [photobtn setHidden:YES];
    [self.view addSubview:photobtn];
    
    fourTypebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fourTypebtn setFrame:CGRectMake(120,6,80,32)];
    [fourTypebtn setTitle:@"随便逛逛" forState:UIControlStateNormal];
    [fourTypebtn.titleLabel setFont:[UIFont fontWithName:@"AppleGothic" size:18]];
    [fourTypebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fourTypebtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [fourTypebtn setTag:FFourtype];
    [fourTypebtn setHidden:YES];
    [self.view addSubview:fourTypebtn];
    
    writebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [writebtn setFrame:CGRectMake(280,6,32,32)];
    [writebtn setImage:[UIImage imageNamed:@"icon_post_enable.png"] forState:UIControlStateNormal];
    [writebtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [writebtn setTag:FWrite];
    [writebtn setHidden:YES];
    [self.view addSubview:writebtn];
#endif
    
    //添加内容的TableView
    self.m_contentView = [[ContentViewController alloc]initWithNibName:@"ContentViewController" bundle:nil];
    //[m_contentView.view setFrame:CGRectMake(0, 44, kDeviceWidth, KDeviceHeight-44*2)];
//    [m_contentView.view setFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-44)];
    [self.view addSubview:m_contentView.view];
#if 0
 
    
    //添加helpView
    isShowHelp = NO;
    m_helpView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
    [m_helpView setBackgroundColor:[UIColor blackColor]];
    [m_helpView setAlpha:0.f];
    [self.view addSubview:m_helpView];
    
    //帮助
    UIImage *helpimage = [UIImage imageNamed:@"block_help.png"];
    helpimageView = [[UIImageView alloc]initWithImage:helpimage];
    [helpimageView setFrame:CGRectMake(0,720-44-229,320,209)];
    [self.view addSubview:helpimageView];
    [helpimageView setUserInteractionEnabled:YES];
    [helpimageView release];
    [helpimage release];
    
    UIButton *closebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closebtn setFrame:CGRectMake(280,12,24,24)];
    [closebtn setImage:[UIImage imageNamed:@"icon_close.png"] forState:UIControlStateNormal];
    [closebtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [closebtn setTag:FHelp];
    [helpimageView addSubview:closebtn];
    

    //添加tabbar
    UIImage *barimage = [UIImage imageNamed:@"bar_background.png"];
    UIImageView *barView = [[UIImageView alloc]initWithImage:barimage];
    [barView setFrame:CGRectMake(0, 480-44-20, 320,44)];
    [self.view addSubview:barView];
    [barView release];
    [barimage release];
     
    //添加Button，注册。登陆。帮助   
    loginbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginbtn setFrame:CGRectMake(10,482-44-20,62,40)];
    [loginbtn setBackgroundImage:[UIImage imageNamed:@"button_login.png"] forState:UIControlStateNormal];
    [loginbtn setBackgroundImage:[UIImage imageNamed:@"button_login_active.png"] forState:UIControlStateHighlighted];
    [loginbtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginbtn.titleLabel setFont:[UIFont fontWithName:@"AppleGothic" size:16]];
    [loginbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginbtn setTag:FLogin];
    [self.view addSubview:loginbtn];
    
    regsiterbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [regsiterbtn setFrame:CGRectMake(90,482-44-20,62,40)];
    [regsiterbtn setBackgroundImage:[UIImage imageNamed:@"button_login.png"] forState:UIControlStateNormal];
    [regsiterbtn setBackgroundImage:[UIImage imageNamed:@"button_login_active.png"] forState:UIControlStateHighlighted];
    [regsiterbtn setTitle:@"注册" forState:UIControlStateNormal];
    [regsiterbtn.titleLabel setFont:[UIFont fontWithName:@"AppleGothic" size:16]];
    [regsiterbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [regsiterbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [regsiterbtn setTag:FRegsiter];
    [self.view addSubview:regsiterbtn];
    
    helpbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [helpbtn setFrame:CGRectMake(265,424,42,32)];
    [helpbtn setImage:[UIImage imageNamed:@"icon_help.png"] forState:UIControlStateNormal];
    [helpbtn setImage:[UIImage imageNamed:@"icon_help_active.png"] forState:UIControlStateHighlighted];
    [helpbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [helpbtn setTag:FHelp];
    [self.view addSubview:helpbtn];   
    
    //登陆后显示的按钮
    topbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topbtn setFrame:CGRectMake(30,424,32,32)];
    [topbtn setBackgroundImage:[UIImage imageNamed:@"icon_top_active.png"] forState:UIControlStateDisabled];
    [topbtn setBackgroundImage:[UIImage imageNamed:@"icon_top_enable.png"] forState:UIControlStateNormal];
    [topbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [topbtn setTag:FTop];
    [topbtn setHidden:YES];
    [self.view addSubview:topbtn];
    
    recentbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [recentbtn setFrame:CGRectMake(140,424,32,32)];
    [recentbtn setBackgroundImage:[UIImage imageNamed:@"icon_new_enable.png"] forState:UIControlStateNormal];
    [recentbtn setBackgroundImage:[UIImage imageNamed:@"icon_new_active.png"] forState:UIControlStateDisabled];
    [recentbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [recentbtn setTag:FRecent];
    [recentbtn setHidden:YES];
    [self.view addSubview:recentbtn];
    
    settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingbtn setFrame:CGRectMake(250,424,32,32)];
    [settingbtn setImage:[UIImage imageNamed:@"icon_my_enable.png"] forState:UIControlStateNormal];
    [settingbtn setImage:[UIImage imageNamed:@"icon_my_active.png"] forState:UIControlStateDisabled];
    [settingbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [settingbtn setTag:FSetting];
    [settingbtn setHidden:YES];
    [self.view addSubview:settingbtn];
#endif
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
