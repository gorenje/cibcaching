@import <Foundation/CPObject.j>

@implementation BaseClass : CPObject
{
  CPString idStr @accessors;
}

- (id)initWithJSONObject:(JSObject)anObject
{
  self = [super init];
  if (self) {
    idStr = anObject.id_str;
  }
  return self;
}

- (void)resetIdStr
{
  var regexp = new RegExp(/\d+$/);
  // shadowing instance variable right here.
  var idStr = regexp.exec("http://twitter.com/#!/engineyard/status/37678550509158400");
  if ( !idStr ) {
    alert( 'unable to find id string' );
  } else {
    idStr = idStr[0]; // wanting to set the instance variable.
  }
}
@end

@implementation AppController : CPObject

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
  var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() 
                                              styleMask:CPBorderlessBridgeWindowMask],
    contentView = [theWindow contentView];

  var jsStr = '{ "id_str" : "1234" }';
  var jsObj = [jsStr objectFromJSON];

  var testObject = [[BaseClass alloc] initWithJSONObject:jsObj];
  
  var label = [CPTextField labelWithTitle:@"To start with, idStr has value: " + [testObject idStr]];
  [label setFrameOrigin:CGPointMake( 100, 80 )];
  [contentView addSubview:label];

  // reset the idStr value to be something else ....
  [testObject resetIdStr];
  var label = [CPTextField labelWithTitle:@"After resetting the value, we get a new value...."];
  [label setFrameOrigin:CGPointMake( 100, 100 )];
  [contentView addSubview:label];

  var label = [CPTextField labelWithTitle:@"After building project, value will be 1234. That is Release, Press and Flatten will all have the same correct behaviour and not reset the value."];
  [label setFrameOrigin:CGPointMake( 100, 120 )];
  [contentView addSubview:label];

  var label = [CPTextField labelWithTitle:@"However opening the index.html directly (i.e. 'development' mode), gives an incorrect 'reset' value of 37678550509158400"];
  [label setFrameOrigin:CGPointMake( 100, 140 )];
  [contentView addSubview:label];

  var label = [CPTextField labelWithTitle:@"And the value is: " + [testObject idStr]];
  [label setFrameOrigin:CGPointMake( 100, 160 )];
  [contentView addSubview:label];
  
  [theWindow orderFront:self];
}

@end

