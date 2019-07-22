/*  Macro to create a projection of a maths operation
 *  not over all frames but a subset per frame, e.g.
 *  to get average per every 3 frames.
 *  
 *  Author: Viktor Ek, June 2019
 */ 

// Settings =================================================================

n = 3; 				//uneven int; frames to average between
cf = "Average Intensity" 	//string; exact math function to use 


// Start ====================================================================

//Save some info about the image.
fn = getTitle();
tot_slices = nSlices();

//Hide all in-progress windows (also speeds up processing a lot).
setBatchMode(true);

//Create an "output" image using the same settings as the input.
//This image will accept all slices as they are processed.
run("Duplicate...", "duplicate range=1-1");
rename("Output");

//Main loop.
selectWindow(fn);
for(i=0; i<tot_slices; i++){
	//Adjust the bounds each loop, i.e. so that the first slice is processed with the four following
	//slices and not the (non-existant) images before the first slice.
	low_bounds = -(n-1)/2; // -1 for n=3
	high_bounds = (n-1)/2; // +1 for n=3
	while(i+low_bounds<0){ 
		low_bounds+=1;
		high_bounds+=1;		
	}
	while(i+high_bounds>tot_slices){ 
		low_bounds-=1;
		high_bounds-=1;		
	}
	
	//Do the maths.
	selectWindow(fn);	
	run("Duplicate...", "duplicate range=" + i + "-" + (i+n));
	rename("#slide");
	run("Z Project...", "projection=[" + cf + "]");
	selectWindow("#slide");close();
	rename("new_slice");
	
	//Save the processed slice into the "output" image
	run("Concatenate...", "open image1=Output image2=new_slice image3=[-- None --]");
	rename("Output");
}

//Remove the first slice of the output, which was a copy of the first slice of the input
//and is of course not needed.
setSlice(1);
run("Delete Slice");

//OPTIONAL: Blur each slice a little to smooth the output. Good for bacteria foci and 
//similar (which the script is made for), but might make other images worse. 
run("Gaussian Blur...", "sigma=3"); 
	
//Allow showing windows again and show the output.
setBatchMode(false);
setBatchMode("Show");

// End ======================================================================
