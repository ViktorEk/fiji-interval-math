/*  Macro to create a projection of a maths operation
 *  not over all frames but a subset per frame, e.g.
 *  to get average per every 3 frames.
 *  
 *  Author: Viktor Ek, June 2019
 */ 

// Settings =================================================

n = 3; 						//uneven int; frames to average between
cf = "Average Intensity" 	//string; exact math function to use 


// Start ====================================================

fn = getTitle();
tot_slices = nSlices();

setBatchMode(true);

run("Duplicate...", "duplicate range=1-1");
rename("Output");

selectWindow(fn);
for(i=0; i<tot_slices; i++){
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
	
	selectWindow(fn);	
	run("Duplicate...", "duplicate range=" + i + "-" + (i+n));
	rename("#slide");
	run("Z Project...", "projection=[" + cf + "]");
	selectWindow("#slide");close();
	rename("new_slice");
	
	run("Concatenate...", "open image1=Output image2=new_slice image3=[-- None --]");
	rename("Output");
}

setSlice(1);
run("Delete Slice");
run("Gaussian Blur...", "sigma=3"); //OPTIONAL: good for bacteria foci
	
setBatchMode(false);
setBatchMode("Show");
