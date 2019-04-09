//
//  MTLVertices.m
//  MetalLearning
//
//  Created by txooo on 2019/3/29.
//  Copyright © 2019 txooo. All rights reserved.
//

#import "MTLVertices.h"

@implementation MTLVertices

- (instancetype)init {
    if (self = [super init]) {
        float tmp_vertexData[120] = {
            // Internal Triangles
            0.0, 0.0, 0.0, 1.0,
            -0.2, 0.2, 0.0, 1.0,
            0.2, 0.2, 0.0, 1.0,
            
            0.0, 0.0, 0.0, 1.0,
            0.2, 0.2, 0.0, 1.0,
            0.3, 0.0, 0.0, 1.0,
            
            0.0, 0.0, 0.0, 1.0,
            0.3, 0.0, 0.0, 1.0,
            0.0, -0.2, 0.0, 1.0,
            
            0.0, 0.0, 0.0, 1.0,
            0.0, -0.2, 0.0, 1.0,
            -0.3, 0.0, 0.0, 1.0,
            
            0.0, 0.0, 0.0, 1.0,
            -0.3, 0.0, 0.0, 1.0,
            -0.2, 0.2, 0.0, 1.0,
            
            // External Triangles
            0.0, 0.6, 0.0, 1.0,
            -0.2, 0.2, 0.0, 1.0,
            0.2, 0.2, 0.0, 1.0,
            
            0.6, 0.2, 0.0, 1.0,
            0.2, 0.2, 0.0, 1.0,
            0.3, 0.0, 0.0, 1.0,
            
            0.6, -0.4, 0.0, 1.0,
            0.0, -0.2, 0.0, 1.0,
            0.3, 0.0, 0.0, 1.0,
            
            -0.6, -0.4, 0.0, 1.0,
            0.0, -0.2, 0.0, 1.0,
            -0.3, 0.0, 0.0, 1.0,
            
            -0.6, 0.2, 0.0, 1.0,
            -0.2, 0.2, 0.0, 1.0,
            -0.3, 0.0, 0.0, 1.0,
        };
        
        float tmp_vertexColorData[120] = {
            // Internal Triangles
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            
            // External Triangles
            1.0, 0.0, 0.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            
            1.0, 0.0, 0.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            
            1.0, 0.0, 0.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            
            1.0, 0.0, 0.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            
            1.0, 0.0, 0.0, 1.0,
            1.0, 1.0, 1.0, 1.0,
            1.0, 1.0, 1.0, 1.0
        };

        for (int i = 0; i < 120; i++) {
            self -> vertexData[i] = tmp_vertexData[i];
            self -> vertexColorData[i] = tmp_vertexColorData[i];
        }
        
    }
    return self;
}

@end
