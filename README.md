# fiji-interval-math
## What?
A simple ImageJ Fiji macro to apply maths to every nth slice in a single-channel image. Possible uses include averaging every 5 frames, projecting maximum intensity of every 3 frames, and similar.
## How to use
The macro works on a single-channel image and applies math on the time axis.
1. Open the image you want to use.
2. Open the macro.
3. Change the <i>n</i> parameter to the frame interval you want.
4. Change the <i>cf</i> parameter to the exact, case-sensitive math operation you want to use. 
5. (OPTIONAL) There is a small amount of blur applied to the final output. This removes a lot of noise and improves the collective signal of many sources while decreasing the signal  of single sources. If you wish, you can turn this off by simply "commenting out" the corresponding line of code (adding '//' before) or removing it completely from your local copy.
6. Run the macro.
