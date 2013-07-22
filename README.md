Converter
=========

A Simple Decimal to Base 62 Converter

## Sample Usage

- Download the Project
- Copy STBase62Converter and BaseContent.txt files in your project
- Import "STBase62Converter.h" in your class
- Call the following method 

```objective-c
    STBase62Converter *baseConverter = [[STBase62Converter alloc] init];
    NSString *convertedString = [baseConverter getBase62FromDecimal:9876543210]; // Sample 10 digit number
    long long originalNumber = [baseConverter getDecimalFromBase62:convertedString];
```

## Custom Base Mapping

- If you need custom base mapping, modify the BaseContent.txt and make sure there are no duplicate entries present.
