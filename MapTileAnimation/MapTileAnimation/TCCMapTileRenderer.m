//
//  TCCMapTileRenderer.m
//  MapTileAnimationDemo
//
//  Created by Bruce Johnson on 6/12/14.
//  Copyright (c) 2014 The Climate Corporation. All rights reserved.
//

#import "TCCMapTileRenderer.h"
#import "TCCMapTileOverlay.h"
#import "TCCMapTile.h"

@implementation TCCMapTileRenderer

- (id) initWithOverlay:(id<MKOverlay>)overlay
{
	self = [super initWithOverlay: overlay];
	if (self)
	{
		
	}
	return self;
}

- (BOOL)canDrawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale
{
	return YES;
}

-(void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context
{
    TCCMapTileOverlay *mapOverlay = (TCCMapTileOverlay *)self.overlay;
    
    // Get a list of one or more tile images for this map's rect.
	
    NSArray *rectTiles = mapOverlay.mapTiles;
    
    CGContextSetAlpha(context, 1.0);
    
    for (TCCMapTile *tile in rectTiles)
    {
		if (tile.imageTile == nil)
			continue;
		
        // draw each tile in its frame
        CGRect rect = [self rectForMapRect: tile.mapRectFrame];
		
        UIImage *image = tile.imageTile;
        
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextScaleCTM(context, 1 / zoomScale, 1 / zoomScale);
        CGContextTranslateCTM(context, 0, image.size.height);
        CGContextScaleCTM(context, 1, -1);
        CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), [image CGImage]);
        CGContextRestoreGState(context);
    }
}

@end
