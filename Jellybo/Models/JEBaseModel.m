//
//  JEBaseModel.m
//  Jellybo
//
//  Created by POON on 16/5/2.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JEBaseModel.h"

@implementation JEBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if(self = [super init]){
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [[self class] classPropsForClassHierarchy:[self class] onDictionary:dict];
    
    for (NSString *key in dict.allKeys) {
        [self setValue:[decoder decodeObjectForKey:key] forKey:key];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [[self class] classPropsForClassHierarchy:[self class] onDictionary:dict];
    
    for (NSString *key in dict.allKeys) {
        [encoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

+ (NSMutableArray *)parseDictionaryArray:(NSArray *)dictArray className:(NSString *) modelClassName {
    Class classFromName = NSClassFromString(modelClassName);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    if (!([[classFromName alloc] respondsToSelector:@selector(initWithDictionary:)])) {
        return array;
    }
    
    for (NSDictionary *dict in dictArray) {
        id instance = [[classFromName alloc] initWithDictionary:dict];
        [array addObject:instance];
    }
    
    return array;
}

+ (NSDictionary *)classPropsForClassHierarchy:(Class)klass onDictionary:(NSMutableDictionary *)results
{
    if (klass == NULL) {
        return nil;
    }
    
    if (klass == [NSObject class]) {
        return [NSDictionary dictionaryWithDictionary:results];
    }
    else{
        
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(klass, &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char *propName = property_getName(property);
            const char *propType = getPropertyType(property);
            if(propName && propType) {
                NSString *propertyName = [NSString stringWithUTF8String:propName];
                NSString *propertyType = [NSString stringWithUTF8String:propType];
                [results setObject:propertyType forKey:propertyName];
            }
        }
        free(properties);
        
        //go for the superclass
        return [self classPropsForClassHierarchy:[klass superclass] onDictionary:results];
        
    }
}


static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // A C primitive type:
            /*
             For example, int "i", long "l", unsigned "I", struct.
             Apple docs list plenty of examples of values returned. For a list
             of what will be returned for these primitives, search online for
             "Objective-c" "Property Attribute Description Examples"
             */
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // An Objective C id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // Another Objective C id type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}

@end
