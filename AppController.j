/*
 * AppController.j
 * cibcaching
 *
 * Created by You on March 12, 2011.
 * Copyright 2011, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>


var SecondWindowControllerInstance = nil;

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    var button1 = [CPButton buttonWithTitle:"Multiple Windows"];
    [button1 setTarget:self];
    [button1 setAction:@selector(buttonOnePressed:)];
    [button1 setFrameOrigin:CGPointMake( 100, 100 )];
    [contentView addSubview:button1];

    var button2 = [CPButton buttonWithTitle:"Single Window"];
    [button2 setTarget:self];
    [button2 setAction:@selector(buttonTwoPressed:)];
    [button2 setFrameOrigin:CGPointMake( 250, 100 )];
    [contentView addSubview:button2];

    [theWindow orderFront:self];
}

- (void)buttonOnePressed:(id)sender
{
  var controller = [FirstWindowController alloc];
  [controller initWithWindowCibName:"FirstWindow"];
  [controller showWindow:self];
}

- (void)buttonTwoPressed:(id)sender
{
  if ( !SecondWindowControllerInstance ) {
    SecondWindowControllerInstance = [SecondWindowController alloc];
    [SecondWindowControllerInstance initWithWindowCibName:"SecondWindow"];
  }
  [SecondWindowControllerInstance showWindow:self];
}

@end

@implementation FirstWindowController : CPWindowController

- (void)awakeFromCib
{
}

- (CPAction)cancel:(id)sender
{
  [_window close];
}

- (CPAction)accept:(id)sender
{
  [_window close];
}

@end

@implementation SecondWindowController : CPWindowController

- (void)awakeFromCib
{
}

- (CPAction)cancel:(id)sender
{
  [_window close];
}

- (CPAction)accept:(id)sender
{
  [_window close];
}

@end
