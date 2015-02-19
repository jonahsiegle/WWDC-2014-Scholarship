//
//  JSMainViewController.m
//  Jonah
//
//  Created by Jonah Siegle on 2014-04-08.
//  Copyright (c) 2014 Jonah Siegle. All rights reserved.
//

#import "JSMainViewController.h"

#define scrollViewContentHeight 7400.0f
#define headerImageHeight 250.0f

#define imageTransitionOffsetDistance 120.0f

#define heightScale abs(568 - [UIApplication sharedApplication].keyWindow.bounds.size.height)

@interface JSMainViewController ()

@end

@implementation JSMainViewController{
    
    JSTransitionImageView *transitionImageView;
    
    NSArray *tranistionPoints;
    
    UIImageView *leefLogo;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //Initialize content view array
        self.contentViewStack = [[NSMutableArray alloc]init];
        
        //Initialize text label array
        self.textLabelStack = [[NSMutableArray alloc]init];
        
        //Set the background images names.
        self.backgroundImageNames = @[@"intro_bg.png", @"westlock_bg.png", @"childhood_bg.png", @"technology_bg.png", @"ipod_bg.png", @"code_bg.png", @"Leef_bg.png", @"grant_macewan.png", @"wwdc_bg.png", @"golden_gate_bg.png"];
        
        //C Array of tranistion content offset points
        tranistionPoints = [NSArray arrayWithObjects:
                                               @0.0f,
                            @(810.0f - heightScale),
                            @(1330.0f - heightScale),
                            @(1850.0f - heightScale),
                            @(2370.0f - heightScale),
                            @(3000.0f - heightScale),
                            @(4070.0f - heightScale),
                            @(4970.0f - heightScale),
                            @(5780.0f - heightScale),
                            @(6360.0f - heightScale), nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:true];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //Create background image view
    transitionImageView = [[JSTransitionImageView alloc]initWithFrame:self.view.bounds];
    transitionImageView.imageOne = [UIImage imageNamed:@"intro_bg.png"];
    [self.view addSubview:transitionImageView];
    
    //Set inital translation for Parallax effect
    transitionImageView.transform = CGAffineTransformMakeTranslation(0, headerImageHeight);
    
    //Create Base Background Scrollview
    self.baseScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.baseScrollView setContentSize:CGSizeMake(self.view.bounds.size.width, scrollViewContentHeight)];
    [self.baseScrollView setDelegate:self];
    [self.baseScrollView setDelaysContentTouches:false];
    [self.view addSubview:self.baseScrollView];
    
    //Create Parallax UIImageViews
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, headerImageHeight)];
    [headerImage setContentMode:UIViewContentModeScaleAspectFill];
    [headerImage setImage:[UIImage imageNamed:@"WWDC_header.png"]];
    [headerImage setTag:1];
    [headerImage setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:headerImage];
    
    [self.view bringSubviewToFront:self.baseScrollView];
    [self.view sendSubviewToBack:transitionImageView];
    
    
    [self createContentViewStack];
    [self createTextLabels];
    [self createGlyphs];

    
    
    // Do any additional setup after loading the view.
}

- (void)createGlyphs{
    
    UIImageView *earlyYears = [[UIImageView alloc]initWithFrame:CGRectMake(144, self.view.bounds.size.height + 1110.0f, 32, 32)];
    [earlyYears setImage:[UIImage imageNamed:@"joystick.png"]];
    [self.baseScrollView addSubview:earlyYears];
    
    UIImageView *technology = [[UIImageView alloc]initWithFrame:CGRectMake(144, self.view.bounds.size.height + 1810.0f, 32, 32)];
    [technology setImage:[UIImage imageNamed:@"blockscheme.png"]];
    [self.baseScrollView addSubview:technology];
    
    UIImageView *monitor = [[UIImageView alloc]initWithFrame:CGRectMake(144, self.view.bounds.size.height + 2260.0f, 32, 32)];
    [monitor setImage:[UIImage imageNamed:@"monitor.png"]];
    [self.baseScrollView addSubview:monitor];
    
    UIImageView *ipod = [[UIImageView alloc]initWithFrame:CGRectMake(144, self.view.bounds.size.height + 2460.0f, 32, 32)];
    [ipod setImage:[UIImage imageNamed:@"iphone.png"]];
    [self.baseScrollView addSubview:ipod];
    
    UIImageView *sdk = [[UIImageView alloc]initWithFrame:CGRectMake(144, self.view.bounds.size.height + 2665.0f, 32, 32)];
    [sdk setImage:[UIImage imageNamed:@"gear.png"]];
    [self.baseScrollView addSubview:sdk];
    
    UIImageView *education = [[UIImageView alloc]initWithFrame:CGRectMake(144, self.view.bounds.size.height + 5090.0f, 32, 32)];
    [education setImage:[UIImage imageNamed:@"graduationcap.png"]];
    [self.baseScrollView addSubview:education];
    
    UIImageView *future = [[UIImageView alloc]initWithFrame:CGRectMake(144, self.view.bounds.size.height + 5340.0f, 32, 32)];
    [future setImage:[UIImage imageNamed:@"compas.png"]];
    [self.baseScrollView addSubview:future];
    
}

- (void)createContentViewStack{
    
    
    JSIntroductionView *intro = [[JSIntroductionView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - (328.0f), self.view.bounds.size.width, 328.0f)];
    
    intro.layer.shadowColor = [UIColor blackColor].CGColor;
    intro.layer.shadowOpacity = 0.6f;
    intro.layer.shadowRadius = 4.0f;
    intro.layer.shadowOffset = CGSizeMake(0, 4.0f);
    
    [self.contentViewStack addObject:intro];
    
    JSAppsDisplayView *appsCreated = [[JSAppsDisplayView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height + 3500, 320, 568)];
    [self.baseScrollView addSubview:appsCreated];
    appsCreated.delegate = self;
    appsCreated.layer.shadowColor = [UIColor blackColor].CGColor;
    appsCreated.layer.shadowOpacity = 0.6f;
    appsCreated.layer.shadowRadius = 4.0f;
    appsCreated.layer.shadowOffset = CGSizeMake(0, 4.0f);
    
    
    leefLogo = [[UIImageView alloc]initWithFrame:CGRectMake(20, self.view.bounds.size.height + 4150, 280, 150)];
    [leefLogo setImage:[UIImage imageNamed:@"leef_logo.png"]];
    [self.contentViewStack addObject:leefLogo];
    
    UIImageView *tinker = [[UIImageView alloc]initWithFrame:CGRectMake(56, self.view.bounds.size.height + 4310, 208, 208)];
    [tinker setImage:[UIImage imageNamed:@"tinker.png"]];
    [self.contentViewStack addObject:tinker];
    

    
    //Scroll to top button
    UIButton *scrollToTop = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollToTop setFrame:CGRectMake(68, 7300, 184, 52)];
    [scrollToTop setImage:[UIImage imageNamed:@"top.png"] forState:UIControlStateNormal];
    [scrollToTop setImage:[UIImage imageNamed:@"topselected.png"] forState:UIControlStateHighlighted];
    [scrollToTop addTarget:self action:@selector(returnToTop) forControlEvents:UIControlEventTouchUpInside];
    [scrollToTop setAlpha:0.0f];
    [self.contentViewStack addObject:scrollToTop];
    
    
    
    //Add content views to base UIScrollview
    for (UIView *view in self.contentViewStack){
        [self.baseScrollView addSubview:view];
    }
    
}

//App View Delegate
- (void)JSAppDisplayViewDidSelectAppWithIndex:(NSInteger)index{
    
    switch (index) {
        case 0:{
            JSDetailViewController *chippyCatchView = [[JSDetailViewController alloc]initWithNibName:@"ChippyCatch" bundle:nil];
            chippyCatchView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:chippyCatchView animated:YES completion:nil];
        }break;
            
        case 1:{
            JSDetailViewController *chippyCatchView = [[JSDetailViewController alloc]initWithNibName:@"HTML" bundle:nil];
            chippyCatchView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:chippyCatchView animated:YES completion:nil];
        }break;
            
        case 2:{
            JSDetailViewController *chippyCatchView = [[JSDetailViewController alloc]initWithNibName:@"Search" bundle:nil];
            chippyCatchView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:chippyCatchView animated:YES completion:nil];
        }break;
            
        case 3:{
            JSDetailViewController *chippyCatchView = [[JSDetailViewController alloc]initWithNibName:@"Keychain" bundle:nil];
            chippyCatchView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:chippyCatchView animated:YES completion:nil];
        }break;
            
        case 4:{
            JSDetailViewController *chippyCatchView = [[JSDetailViewController alloc]initWithNibName:@"Whirl" bundle:nil];
            chippyCatchView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:chippyCatchView animated:YES completion:nil];
        }break;
            
        case 5:{
            JSDetailViewController *chippyCatchView = [[JSDetailViewController alloc]initWithNibName:@"Deploy" bundle:nil];
            chippyCatchView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:chippyCatchView animated:YES completion:nil];
        }break;
            
        case 6:{
            JSFlappyChickenController *flappyChicken = [[JSFlappyChickenController alloc]init];
            [self.navigationController pushViewController:flappyChicken animated:YES];
        }break;
            
        default:
            break;
    }
}

- (void)createTextLabels{
    
    //Add the body text
    NSString *bodyText = @"Hey there, \n I'm Jonah. \n \n A 17 year old software developer and high school student residing in snowy Alberta, Canada.";
    
    NSMutableAttributedString *attributedBodyString = [[NSMutableAttributedString alloc]initWithString:bodyText];
    [attributedBodyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Black" size:48.0f] range:NSMakeRange(0, 10)];
    [attributedBodyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Heavy" size:36.0f] range:NSMakeRange(10, 15)];
    [attributedBodyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Medium" size:24.0f] range:NSMakeRange(25, bodyText.length - 25)];
    
    UILabel *introLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height + 100.0f, self.view.frame.size.width, 300.0f)];
    [introLabel setBackgroundColor:[UIColor clearColor]];
    [introLabel setAttributedText:attributedBodyString];
    [introLabel setNumberOfLines:0];
    [introLabel setTextColor:[UIColor whiteColor]];
    [introLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:introLabel];
    
    
    
    //Early years text
    NSString *early = @"About Me \n I was born and raised in the small town of Westlock.";

    NSMutableAttributedString *attributedEarlyYearsString = [[NSMutableAttributedString alloc]initWithString:early];
    [attributedEarlyYearsString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Heavy" size:36.0f] range:NSMakeRange(0, 9)];
    [attributedEarlyYearsString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Medium" size:24.0f] range:NSMakeRange(9, early.length - 9)];
    
    UILabel *earlyYearsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height + 500.0f, self.view.frame.size.width, 300.0f)];
    [earlyYearsLabel setBackgroundColor:[UIColor clearColor]];
    [earlyYearsLabel setAttributedText:attributedEarlyYearsString];
    [earlyYearsLabel setNumberOfLines:0];
    [earlyYearsLabel setTextColor:[UIColor whiteColor]];
    [earlyYearsLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:earlyYearsLabel];
    
    
    //Childhood text
    UILabel *childhoodLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height + 1100.0f, self.view.frame.size.width, 300.0f)];
    [childhoodLabel setBackgroundColor:[UIColor clearColor]];
    [childhoodLabel setText:@"My younger years consisted of trips out to the lake, skiing, building forts in the woods and allowing my imagination to take me anywhere I wanted."];
    [childhoodLabel setNumberOfLines:0];
    [childhoodLabel setTextColor:[UIColor whiteColor]];
    [childhoodLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0f]];
    [childhoodLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:childhoodLabel];
    
    //Childhood text
    UILabel *presentInterestsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height + 1400.0f, self.view.frame.size.width, 300.0f)];
    [presentInterestsLabel setBackgroundColor:[UIColor clearColor]];
    [presentInterestsLabel setText:@"Today I enjoy long walks, being creative, skiing in the mountains, playing bass guitar, socializing with friends and a good game of Minecraft every so often."];
    [presentInterestsLabel setNumberOfLines:0];
    [presentInterestsLabel setTextColor:[UIColor whiteColor]];
    [presentInterestsLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0f]];
    [presentInterestsLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:presentInterestsLabel];
    
    
    
    UILabel *childhoodTechnologyLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.view.bounds.size.height + 1800.0f, self.view.frame.size.width - 10, 300.0f)];
    [childhoodTechnologyLabel setBackgroundColor:[UIColor clearColor]];
    [childhoodTechnologyLabel setText:@"Technology has always been an interest of mine. At the age of nine I discovered you could write code to tell a computer to do anything you told it."];
    [childhoodTechnologyLabel setNumberOfLines:0];
    [childhoodTechnologyLabel setTextColor:[UIColor whiteColor]];
    [childhoodTechnologyLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0f]];
    [childhoodTechnologyLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:childhoodTechnologyLabel];
    
    
    UILabel *childhoodDevLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.view.bounds.size.height + 2200.0f, self.view.frame.size.width - 10, 300.0f)];
    [childhoodDevLabel setBackgroundColor:[UIColor clearColor]];
    [childhoodDevLabel setText:@"Jumping ahead a few years I got my first Mac and iPod Touch."];
    [childhoodDevLabel setNumberOfLines:0];
    [childhoodDevLabel setTextColor:[UIColor whiteColor]];
    [childhoodDevLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0f]];
    [childhoodDevLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:childhoodDevLabel];
    
    
    UILabel *childhoodAppLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.view.bounds.size.height + 2400.0f, self.view.frame.size.width - 10, 300.0f)];
    [childhoodAppLabel setBackgroundColor:[UIColor clearColor]];
    [childhoodAppLabel setText:@"I really liked the idea of apps, having pages of them on my iPod Touch."];
    [childhoodAppLabel setNumberOfLines:0];
    [childhoodAppLabel setTextColor:[UIColor whiteColor]];
    [childhoodAppLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0f]];
    [childhoodAppLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:childhoodAppLabel];
    
    UILabel *wantToDoLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.view.bounds.size.height + 2600.0f, self.view.frame.size.width - 10, 300.0f)];
    [wantToDoLabel setBackgroundColor:[UIColor clearColor]];
    [wantToDoLabel setText:@"Once I discoverd the iPhone SDK I knew this was what I wanted to do..."];
    [wantToDoLabel setNumberOfLines:0];
    [wantToDoLabel setTextColor:[UIColor whiteColor]];
    [wantToDoLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0f]];
    [wantToDoLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:wantToDoLabel];
    
    //Present Text
    NSString *today = @"Today \n Five years later I have created over eight apps and recently started a software company with my good friend Joe Kennedy.";
    
    NSMutableAttributedString *attributedTodayString = [[NSMutableAttributedString alloc]initWithString:today];
    [attributedTodayString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Heavy" size:36.0f] range:NSMakeRange(0, 6)];
    [attributedTodayString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Medium" size:24.0f] range:NSMakeRange(6, today.length - 6)];
    
    UILabel *todayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height + 3000.0f, self.view.frame.size.width, 300.0f)];
    [todayLabel setBackgroundColor:[UIColor clearColor]];
    [todayLabel setAttributedText:attributedTodayString];
    [todayLabel setNumberOfLines:0];
    [todayLabel setTextColor:[UIColor whiteColor]];
    [todayLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:todayLabel];
    
    UILabel *programmingLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.view.bounds.size.height + 3200.0f, self.view.frame.size.width - 10, 300.0f)];
    [programmingLabel setBackgroundColor:[UIColor clearColor]];
    [programmingLabel setText:@"I know Objective C, C, HTML/CSS, and Javascript. I am also familiar with PHP and Python."];
    [programmingLabel setNumberOfLines:0];
    [programmingLabel setTextColor:[UIColor whiteColor]];
    [programmingLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0f]];
    [programmingLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:programmingLabel];
    
    
    UILabel *appsIveCreatedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height + 3450.0f, self.view.frame.size.width, 30)];
    [appsIveCreatedLabel setBackgroundColor:[UIColor clearColor]];
    [appsIveCreatedLabel setText:@"Apps I've Created"];
    [appsIveCreatedLabel setNumberOfLines:0];
    [appsIveCreatedLabel setTextColor:[UIColor whiteColor]];
    [appsIveCreatedLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:24.0f]];
    [appsIveCreatedLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:appsIveCreatedLabel];
    
    
    UILabel *companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height + 4100.0f, self.view.frame.size.width, 30)];
    [companyLabel setBackgroundColor:[UIColor clearColor]];
    [companyLabel setText:@"My App Company"];
    [companyLabel setNumberOfLines:0];
    [companyLabel setTextColor:[UIColor whiteColor]];
    [companyLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:26.0f]];
    [companyLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:companyLabel];
    
    
    UILabel *tinkerLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.view.bounds.size.height + 4500.0f, self.view.frame.size.width - 10, 300.0f)];
    [tinkerLabel setBackgroundColor:[UIColor clearColor]];
    [tinkerLabel setText:@"The first app under Leef I am working on is an app called Tinker. A goal managing app that allows you to set time limits for your tasks."];
    [tinkerLabel setNumberOfLines:0];
    [tinkerLabel setTextColor:[UIColor whiteColor]];
    [tinkerLabel setFont:[UIFont fontWithName:@"Avenir-MediumOblique" size:24.0f]];
    [tinkerLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:tinkerLabel];

    
    //Present Text
    NSString *education = @"Education \n I plan to pursue my passion for Apple and programming as a career.";
    
    NSMutableAttributedString *attributedEducationString = [[NSMutableAttributedString alloc]initWithString:education];
    [attributedEducationString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Heavy" size:36.0f] range:NSMakeRange(0, 10)];
    [attributedEducationString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Medium" size:24.0f] range:NSMakeRange(10, education.length - 10)];
    
    UILabel *educationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height + 4800.0f, self.view.frame.size.width, 300.0f)];
    [educationLabel setBackgroundColor:[UIColor clearColor]];
    [educationLabel setAttributedText:attributedEducationString];
    [educationLabel setNumberOfLines:0];
    [educationLabel setTextColor:[UIColor whiteColor]];
    [educationLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:educationLabel];
    
    
    UILabel *universityLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.view.bounds.size.height + 5050.0f, self.view.frame.size.width - 10, 300.0f)];
    [universityLabel setBackgroundColor:[UIColor clearColor]];
    [universityLabel setText:@"This fall I am studying Computer Science at Grant MacEwan University in Edmonton."];
    [universityLabel setNumberOfLines:0];
    [universityLabel setTextColor:[UIColor whiteColor]];
    [universityLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0f]];
    [universityLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:universityLabel];
    
    
    UILabel *futureLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.view.bounds.size.height + 5300.0f, self.view.frame.size.width - 10, 300.0f)];
    [futureLabel setBackgroundColor:[UIColor clearColor]];
    [futureLabel setText:@"I am excited to see where my career and passion take me; and am hoping for many great years to come."];
    [futureLabel setNumberOfLines:0];
    [futureLabel setTextColor:[UIColor whiteColor]];
    [futureLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0f]];
    [futureLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:futureLabel];
    
    
    //Final Words String
    NSString *final = @"Final Words \n It would be an honour and opportunity of a lifetime to attend WWDC this year.";

    NSMutableAttributedString *attributedFinalWordsString = [[NSMutableAttributedString alloc]initWithString:final];
    [attributedFinalWordsString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Heavy" size:36.0f] range:NSMakeRange(0, 12)];
    [attributedFinalWordsString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Medium" size:24.0f] range:NSMakeRange(12, final.length - 12)];
    
    UILabel *finalWordsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height + 5700.0f, self.view.frame.size.width, 300.0f)];
    [finalWordsLabel setBackgroundColor:[UIColor clearColor]];
    [finalWordsLabel setAttributedText:attributedFinalWordsString];
    [finalWordsLabel setNumberOfLines:0];
    [finalWordsLabel setTextColor:[UIColor whiteColor]];
    [finalWordsLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:finalWordsLabel];
    
    
    UILabel *appleDeveloperLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.view.bounds.size.height + 5900.0f, self.view.frame.size.width - 10, 300.0f)];
    [appleDeveloperLabel setBackgroundColor:[UIColor clearColor]];
    [appleDeveloperLabel setText:@"To have a chance to meet with Apple engineers and all the great people attending."];
    [appleDeveloperLabel setNumberOfLines:0];
    [appleDeveloperLabel setTextColor:[UIColor whiteColor]];
    [appleDeveloperLabel setFont:[UIFont fontWithName:@"Avenir-Medium" size:24.0f]];
    [appleDeveloperLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:appleDeveloperLabel];
    
    
    //Final conclusion string
    NSString *conclusion = @"Thank You \n for your time and considering my application.";

    NSMutableAttributedString *attributedConclusionString = [[NSMutableAttributedString alloc]initWithString:conclusion];
    [attributedConclusionString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Black" size:48.0f] range:NSMakeRange(0, 10)];
    [attributedConclusionString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Avenir-Heavy" size:36.0f] range:NSMakeRange(10, conclusion.length - 10)];
    
    UILabel *conclusionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height + 6300.0f, self.view.frame.size.width, 300.0f)];
    [conclusionLabel setBackgroundColor:[UIColor clearColor]];
    [conclusionLabel setAttributedText:attributedConclusionString];
    [conclusionLabel setNumberOfLines:0];
    [conclusionLabel setTextColor:[UIColor whiteColor]];
    [conclusionLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:conclusionLabel];
    
    
    UILabel *happyLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.view.bounds.size.height + 6500.0f, self.view.frame.size.width - 10, 300.0f)];
    [happyLabel setBackgroundColor:[UIColor clearColor]];
    [happyLabel setText:@":)"];
    [happyLabel setNumberOfLines:0];
    [happyLabel setTextColor:[UIColor whiteColor]];
    [happyLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:48.0f]];
    [happyLabel setTextAlignment:NSTextAlignmentCenter];
    [self.textLabelStack addObject:happyLabel];



    //Add all labels in array to scrollView
    for (UIView *labelView in self.textLabelStack){
        
        [self.baseScrollView addSubview:labelView];
    }
    
    
}

- (void)returnToTop{

    [self.baseScrollView setContentOffset:CGPointZero animated:YES];
    
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y == 0){
        transitionImageView.imageOne = [UIImage imageNamed:@"intro_bg.png"];
        transitionImageView.imageRatio = 0.0f;
        
    }
    
    [self transitionBackgroundImageWithYOffset:scrollView.contentOffset.y];
    
    //Check if scrollView is dragging
    if (scrollView.contentOffset.y < 0 || scrollView.contentOffset.y > (scrollViewContentHeight - scrollView.frame.size.height)){
        [self scrollViewIsDraggingWithYOffset:scrollView.contentOffset.y];
    }

    
    //Header view parallax effect
    if (scrollView.contentOffset.y < headerImageHeight && scrollView.contentOffset.y>0){
        [self.view viewWithTag:1].transform = CGAffineTransformMakeTranslation(0, -scrollView.contentOffset.y*0.50f);
        [self.view sendSubviewToBack:transitionImageView];

    }
    
    //Tranistion ImageView Parallax Effect
    if (scrollView.contentOffset.y < self.view.bounds.size.height && scrollView.contentOffset.y>0){
        
        
        if (scrollView.contentOffset.y >= headerImageHeight && ![self.view viewWithTag:1].hidden)
            [self.view viewWithTag:1].hidden = true;
        else if (scrollView.contentOffset.y <= headerImageHeight && [self.view viewWithTag:1].hidden)
            [self.view viewWithTag:1].hidden = false;
        
        //Transition in introduction labels
        [(UILabel *) [self.textLabelStack objectAtIndex:0] setAlpha:scrollView.contentOffset.y/500.0f];
        
        CGFloat parallaxTransform = (scrollView.frame.size.height - scrollView.contentOffset.y) * 0.44f;
                
        transitionImageView.transform = CGAffineTransformMakeTranslation(0, (parallaxTransform < 2) ? 0.0f : parallaxTransform);
        [self.view sendSubviewToBack:[self.view viewWithTag:1]];

    }
    
    if (scrollView.contentOffset.y > 4100 && scrollView.contentOffset.y < 4400){
        
        
        //Transition Company Label
        [(UILabel *)[self.textLabelStack objectAtIndex:11] setAlpha:(scrollView.contentOffset.y - 4100)/200.0f];
        
        
        float perspective = (scrollView.contentOffset.y - 4280)/114.0f;
        
        
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = -1 / 500.0;
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 0.5 - (perspective * 0.5), 1.0f, 0.0f, 0.0f);
        rotationAndPerspectiveTransform = CATransform3DScale(rotationAndPerspectiveTransform, 0.9 + (perspective * 0.1), 0.9 + (perspective * 0.1), 1.0);
        [[leefLogo layer] setTransform:rotationAndPerspectiveTransform];
        
        leefLogo.alpha = perspective + 0.8f;
    }
    
    
    if (scrollView.contentOffset.y > (6832 + heightScale) - 5.0f){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25f];
        ((UIView * )[self.contentViewStack objectAtIndex:3]).alpha = 1.0f;
        [UIView commitAnimations];
        
    }else if (scrollView.contentOffset.y < (6832 + heightScale) - 5.0f && scrollView.contentOffset.y > 6800){
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25f];
        ((UIView * )[self.contentViewStack objectAtIndex:3]).alpha = 0.0f;
        [UIView commitAnimations];
    }
}

//Custom scrollView methods

- (void)transitionBackgroundImageWithYOffset:(CGFloat)yOffset{
        
    if (yOffset > [[tranistionPoints objectAtIndex:1]floatValue] && yOffset < [[tranistionPoints objectAtIndex:2]floatValue]){
                
        [transitionImageView transitionBetweenImages:[self backgroundImageWithIndex:0] imageTwo:[self backgroundImageWithIndex:1] ratio:(yOffset - [[tranistionPoints objectAtIndex:1]floatValue])/imageTransitionOffsetDistance];
        
    }else if (yOffset > [[tranistionPoints objectAtIndex:2]floatValue] && yOffset < [[tranistionPoints objectAtIndex:3]floatValue]){
        
        
        [transitionImageView transitionBetweenImages:[self backgroundImageWithIndex:1] imageTwo:[self backgroundImageWithIndex:2] ratio:(yOffset - [[tranistionPoints objectAtIndex:2]floatValue])/imageTransitionOffsetDistance];
        
    }else if (yOffset > [[tranistionPoints objectAtIndex:3]floatValue] && yOffset < [[tranistionPoints objectAtIndex:4]floatValue]){
        
        
        [transitionImageView transitionBetweenImages:[self backgroundImageWithIndex:2] imageTwo:[self backgroundImageWithIndex:3] ratio:(yOffset - [[tranistionPoints objectAtIndex:3]floatValue])/imageTransitionOffsetDistance];
        
    }else if (yOffset > [[tranistionPoints objectAtIndex:4]floatValue] && yOffset < [[tranistionPoints objectAtIndex:5]floatValue]){
        
        
        [transitionImageView transitionBetweenImages:[self backgroundImageWithIndex:3] imageTwo:[self backgroundImageWithIndex:4] ratio:(yOffset - [[tranistionPoints objectAtIndex:4]floatValue])/imageTransitionOffsetDistance];
        
    }else if (yOffset > [[tranistionPoints objectAtIndex:5]floatValue] && yOffset < [[tranistionPoints objectAtIndex:6]floatValue]){
        
        
        [transitionImageView transitionBetweenImages:[self backgroundImageWithIndex:4] imageTwo:[self backgroundImageWithIndex:5] ratio:(yOffset - [[tranistionPoints objectAtIndex:5]floatValue])/imageTransitionOffsetDistance];
        
    }else if (yOffset > [[tranistionPoints objectAtIndex:6]floatValue] && yOffset < [[tranistionPoints objectAtIndex:7]floatValue]){
        
        
        [transitionImageView transitionBetweenImages:[self backgroundImageWithIndex:5] imageTwo:[self backgroundImageWithIndex:6] ratio:(yOffset - [[tranistionPoints objectAtIndex:6]floatValue])/imageTransitionOffsetDistance];
        
    }else if (yOffset > [[tranistionPoints objectAtIndex:7]floatValue] && yOffset < [[tranistionPoints objectAtIndex:8]floatValue]){
        
        
        [transitionImageView transitionBetweenImages:[self backgroundImageWithIndex:6] imageTwo:[self backgroundImageWithIndex:7] ratio:(yOffset - [[tranistionPoints objectAtIndex:7]floatValue])/imageTransitionOffsetDistance];
        
    }else if (yOffset > [[tranistionPoints objectAtIndex:8]floatValue] && yOffset < [[tranistionPoints objectAtIndex:9]floatValue]){
        
        
        [transitionImageView transitionBetweenImages:[self backgroundImageWithIndex:7] imageTwo:[self backgroundImageWithIndex:8] ratio:(yOffset - [[tranistionPoints objectAtIndex:8]floatValue])/imageTransitionOffsetDistance];
        
    }else if (yOffset > [[tranistionPoints objectAtIndex:9]floatValue]){
        
        [transitionImageView transitionBetweenImages:[self backgroundImageWithIndex:8] imageTwo:[self backgroundImageWithIndex:9] ratio:(yOffset - [[tranistionPoints objectAtIndex:9]floatValue])/imageTransitionOffsetDistance];
    }
    
//    if (yOffset > 4066.0f && yOffset < tranistionPoints[6]){
//        
//        [transitionImageView setImageTwo:[self backgroundImageWithIndex:6]];
//        
//    }else if (yOffset < 4066.0f && yOffset > tranistionPoints[5]){
//        
//        [transitionImageView setImageTwo:[self backgroundImageWithIndex:5]];
//
//    }
    
}

 - (UIImage *)backgroundImageWithIndex:(NSInteger)index{
     
     return [UIImage imageNamed:[self.backgroundImageNames objectAtIndex:index]];
 }

- (void)scrollViewIsDraggingWithYOffset:(CGFloat)yOffset{
    
    if (yOffset < 0){
        //Dragging up
        [self.view sendSubviewToBack:transitionImageView];

        //Reset the tranisiton imageView class
        [transitionImageView setImageRatio:0.0f];

        //Scale factor for header image
        CGFloat scaleFactor = (ABS(yOffset) + headerImageHeight)/headerImageHeight;
        
        CGRect headerImageRect = [self.view viewWithTag:1].frame;
        headerImageRect.size.height = headerImageHeight*scaleFactor;
        
        [self.view viewWithTag:1].frame = headerImageRect;
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
