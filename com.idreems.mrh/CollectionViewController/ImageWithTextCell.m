//
//  ImageWithTextCell.m
//  com.idreems.mrh
//
//  Created by ramonqlee on 2/3/13.
//  Copyright (c) 2013 ramonqlee. All rights reserved.
//

#import "ImageWithTextCell.h"
#import "Response.h"
#import "ImageBrowser.h"
#import <QuartzCore/QuartzCore.h>

#define FONT_SIZE 14.0f

#define CELL_CONTENT_MARGIN 10.0f
#define kPlaceholderImage @"loadingImage_50x118.png"

@implementation ImageWithTextCell
@synthesize response;
@synthesize label;
@synthesize imageView;
@synthesize separatorLine;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)setResponse:(Response *)status
{
    if(response)
    {
        [response release];
    }
    response = [status retain];
    BOOL viewWithImage = ((nil!=status.thumbnailUrl)&&(0!=status.thumbnailUrl.length));
    BOOL nullText = ((nil==status.description)|(0==status.description.length));
    UIView* cell = self;
    UIImage* placeholderImage = [UIImage imageNamed:kPlaceholderImage];
    CGRect placeholderImageRect = CGRectMake(0, 0, placeholderImage.size.width, placeholderImage.size.height);
    
    if(nil==label)
    {
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        [label setMinimumFontSize:FONT_SIZE];
        [label setNumberOfLines:0];
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [cell addSubview:label];
    }
    if(nil == separatorLine)
    {
        UIColor* color = [UIColor magentaColor];
        separatorLine = [[UILabel alloc] initWithFrame:CGRectMake(-10, 0, kDeviceWidth, 1)];
        [separatorLine setBackgroundColor:color];
//        separatorLine.layer.borderWidth = 2;
        //separatorLine.layer.borderColor = [[UIColor grayColor]CGColor];
        separatorLine.layer.shadowColor = color.CGColor;
        separatorLine.layer.shadowOpacity = 1.0;
        separatorLine.layer.shadowRadius = 2;
        separatorLine.layer.shadowOffset = CGSizeMake(0, 1);
        separatorLine.clipsToBounds = NO;
        [cell addSubview:separatorLine];
    }
        
    
    if(nil==imageView)
    {
        imageView = [[[UIImageView alloc]initWithFrame:placeholderImageRect]autorelease];
        imageView.userInteractionEnabled = YES;
        if([imageView respondsToSelector:@selector(setImageWithURL:placeholderImage:)])
        {
            [imageView performSelector:@selector(setImageWithURL:placeholderImage:) withObject:[NSURL URLWithString:status.thumbnailUrl] withObject:placeholderImage];
//            [imageView setImageWithURL:[NSURL URLWithString:status.thumbnailUrl] placeholderImage:placeholderImage];
        }
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.bounds = placeholderImageRect;
        [imageView setClipsToBounds:YES];
        
        //tap
        UITapGestureRecognizer* tap = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageBtnClicked:)]autorelease];
        [imageView addGestureRecognizer:tap];
        
        [cell addSubview:imageView];
    }
   
    CGFloat CELL_CONTENT_WIDTH = self.frame.size.width;
    NSString *text = status.description;
    CGSize size = CGSizeZero;
    CGFloat width = CELL_CONTENT_WIDTH - CELL_CONTENT_MARGIN * 2;
    if(!nullText)
    {
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    }
    CGFloat textHeight = nullText?0:size.height;
    
    if(!nullText)
    {
        label.hidden = NO;
        [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, width, textHeight)];
        [label setText:text];
    }
    else
    {
        [label setFrame:CGRectZero];
        label.hidden = YES;
    }
    
    if(viewWithImage && [imageView respondsToSelector:@selector(setImageWithURL:placeholderImage:)])
    {
        imageView.hidden = NO;
        placeholderImageRect.origin.x += (CELL_CONTENT_WIDTH-placeholderImage.size.width)/2;
        //without text
        if(!nullText)
        {
            [imageView performSelector:@selector(setImageWithURL:placeholderImage:) withObject:[NSURL URLWithString:status.thumbnailUrl] withObject:placeholderImage];
//            [imageView setImageWithURL:[NSURL URLWithString:status.thumbnailUrl] placeholderImage:placeholderImage];
            
            placeholderImageRect.origin.y += (CELL_CONTENT_MARGIN+textHeight+CELL_CONTENT_MARGIN);
        }
        else
        {
            placeholderImageRect.origin.y += CELL_CONTENT_MARGIN;
        }
        [imageView setFrame:placeholderImageRect];
    }else{
        [imageView setFrame:CGRectZero];
        imageView.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)dealloc
{
    self.response = nil;
    self.separatorLine = nil;
    self.imageView = nil;
    self.label = nil;
    [super dealloc];
}
#pragma mark util
-(void) ImageBtnClicked:(id)sender
{
    UIApplication *app = [UIApplication sharedApplication];
    ImageBrowser* browserView = [[[ImageBrowser alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)] autorelease];
    [browserView setUp];
    
    browserView.image = imageView.image;
    browserView.bigImageURL = response.largeUrl;
    [browserView loadImage];
    
    app.statusBarHidden = YES;
    [[app keyWindow]addSubview:browserView];
}

+(CGSize)measureCell:(Response*)status width:(CGFloat)width
{
    BOOL nullText = ((nil==status.description)|(0==status.description.length));
    NSString *text = status.description;
    CGFloat CELL_CONTENT_WIDTH = width;
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGFloat height = nullText?0:size.height;
    
    BOOL viewWithImage = ((nil!=status.thumbnailUrl)&&(0!=status.thumbnailUrl.length));
    if(viewWithImage)
    {
        UIImage* placeholderImage = [UIImage imageNamed:kPlaceholderImage];
        //WITH TEXT
        if(!nullText)
        {
            constraint.height = CELL_CONTENT_MARGIN+height+CELL_CONTENT_MARGIN+placeholderImage.size.height+CELL_CONTENT_MARGIN;
        }
        else//WITHOUT TEXT
        {
            constraint.height = 2*CELL_CONTENT_MARGIN+placeholderImage.size.height;
        }
        
    }
    else
    {
        //ONLY WITH TEXT
        constraint.height = 2*CELL_CONTENT_MARGIN+height;
    }
    return constraint;
}

@end
