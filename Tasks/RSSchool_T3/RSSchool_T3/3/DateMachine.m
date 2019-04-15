
#import "DateMachine.h"

@implementation DateMachine
@synthesize testPicker;
@synthesize onecolumlist;
@synthesize dateUnit;
- (void)viewDidLoad {
  [super viewDidLoad];
    
  onecolumlist = [[NSArray alloc] initWithObjects:@"day",@"week",@"month",@"year",@"hour",@"minute", nil];
    NSString *formatter = @"dd/MM/yyyy HH:mm";
    _dateFormarter = [NSDateFormatter new];
    [_dateFormarter setDateFormat:formatter];
    [_dateLabel setText: [_dateFormarter stringFromDate:[NSDate date]]];
    [_add addTarget:self action:@selector(addStep) forControlEvents:UIControlEventTouchUpInside];
    [_sub addTarget:self action:@selector(substep) forControlEvents:UIControlEventTouchUpInside];
    }


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [onecolumlist count];
}
-(NSString *)pickerView:(UIPickerView*) pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [onecolumlist objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.dateUnit.text= [onecolumlist objectAtIndex:row];
}
- (void)dealloc {
    [_add release];
    [_sub release];
    [_step release];
    [_startDate release];
    [dateUnit release];
    [testPicker release];
    [_dateLabel release];
    [_calendarComponents release];
    [_components release];
    [_dateFormarter release];
    [onecolumlist release];
    [super dealloc];
}

- (IBAction)touchDownStep {
    _step.text=@"";
}
- (IBAction)touchStartDate {
    _startDate.text = @"";
}

- (IBAction)changingStartdate {
    _dateLabel.text = _startDate.text;
}
- (IBAction)touchDownDateUnit {
    dateUnit.text = @"";
}


- (IBAction)editingDateUnit {
    NSString* str =dateUnit.text;
    if([str rangeOfString:@"^[a-zA-Z]+$" options:NSRegularExpressionSearch].location == NSNotFound){
        dateUnit.text= @"Date unit";
    }
}
- (IBAction)editingStep {
    NSString* str =_step.text;
    if([str integerValue]==0){
        _step.text= @"Step";
    }
}
- (IBAction)editingEndDateUnit {
    NSString* str =dateUnit.text;
    if(![onecolumlist containsObject:str])
         dateUnit.text= @"Date unit";
}

-(void)addStep{
    _calendarComponents = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear  |  NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[_dateFormarter dateFromString:[_dateLabel text]]];
    _components = [_dateFormarter dateFromString:[_dateLabel text]];
    switch ([onecolumlist indexOfObject:dateUnit.text]) {
        case 0:
            _calendarComponents.day+= [_step.text integerValue ];
            break;
        case 1:
            _calendarComponents.day+= 7*[_step.text integerValue ];
            break;
        case 2:
            _calendarComponents.month+= [_step.text integerValue ];
            break;
        case 3:
            _calendarComponents.year+= [_step.text integerValue ];
            break;
        case 4:
            _calendarComponents.hour+= [_step.text integerValue ];
            break;
        case 5:
            _calendarComponents.minute+= [_step.text integerValue ];
            break;
        default:
            break;
    }
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* resDate = [calendar dateFromComponents:_calendarComponents];
    [_dateLabel setText:[_dateFormarter stringFromDate:resDate]];
    }

-(void)substep{
    _calendarComponents = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth |NSCalendarUnitYear  |  NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[_dateFormarter dateFromString:[_dateLabel text]]];
    _components = [_dateFormarter dateFromString:[_dateLabel text]];
    switch ([onecolumlist indexOfObject:dateUnit.text]) {
        case 0:
            _calendarComponents.day-= [_step.text integerValue ];
            break;
        case 1:
            _calendarComponents.day-= 7*[_step.text integerValue ];
            break;
        case 2:
            _calendarComponents.month-= [_step.text integerValue ];
            break;
        case 3:
            _calendarComponents.year-= [_step.text integerValue ];
            break;
        case 4:
            _calendarComponents.hour -= [_step.text integerValue ];
            break;
        case 5:
            _calendarComponents.minute-= [_step.text integerValue ];
            break;
        default:
            break;
    }
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* resDate = [calendar dateFromComponents:_calendarComponents];
    [_dateLabel setText:[_dateFormarter stringFromDate:resDate]];
    
}


@end
