#import "MenuView.h"

static float globalSpeed = 1.0;

@implementation MenuView
{
    CGPoint lastPoint;
}

-(instancetype)init{
    
    self = [super initWithFrame:CGRectMake(100,150,220,150)];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    self.layer.cornerRadius = 10;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10,5,200,20)];
    title.text = @"Speed Menu";
    title.textColor = [UIColor whiteColor];
    [self addSubview:title];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,40,80,30)];
    label.text = @"Speed:";
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    
    self.speedField = [[UITextField alloc] initWithFrame:CGRectMake(80,40,100,30)];
    self.speedField.borderStyle = UITextBorderStyleRoundedRect;
    self.speedField.keyboardType = UIKeyboardTypeDecimalPad;
    self.speedField.text = @"1.0";
    [self addSubview:self.speedField];
    
    self.toggleSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(10,80,60,30)];
    [self.toggleSwitch addTarget:self action:@selector(toggleSpeed) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.toggleSwitch];
    
    UILabel *toggleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80,80,120,30)];
    toggleLabel.text = @"Enable Speed";
    toggleLabel.textColor = [UIColor whiteColor];
    [self addSubview:toggleLabel];
    
    UIPanGestureRecognizer *pan =
    [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragMenu:)];
    [self addGestureRecognizer:pan];
    
    return self;
}

-(void)toggleSpeed{
    
    if(self.toggleSwitch.isOn){
        globalSpeed = [self.speedField.text floatValue];
    }else{
        globalSpeed = 1.0;
    }
    
    NSLog(@"Speed set: %f",globalSpeed);
}

-(void)dragMenu:(UIPanGestureRecognizer*)gesture{
    
    CGPoint translation = [gesture translationInView:self.superview];
    
    self.center = CGPointMake(self.center.x + translation.x,
                              self.center.y + translation.y);
    
    [gesture setTranslation:CGPointZero inView:self.superview];
}

@end

float getSpeed(){
    return globalSpeed;
}