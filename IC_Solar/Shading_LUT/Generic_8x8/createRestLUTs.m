% Given: a quadrant's worth of %shaded LUTs for ICSF
% This script creates % exposed LUTs, for the og LUTs, and for the other quadrants. 
%% 
%STEP1 - pick a generated LUT file:
%filenam = 'C:\Users\Nick\Dropbox\IC Solar in Studio\0-DWGS\02-Schematic Drawings\Range of Motion_New Bay 3\shading\generic_26-05\ForDZ_2d Lookup txt\ICSolarmodule_12_ShadLUT_Generic.txt';
filenam = 'ICSolarmodule_09_ShadLUT_Generic_3.txt';
%STEP2 - give it a position number according to the Fraction_exposed array
%convention:


shadModNum = filenam(15:16);
delimiterIn = '\t';
headerlinesIn = 1;
shadLUTdata = importdata(filenam,delimiterIn, headerlinesIn);
L = 49;
%complement: make this an LUT of "fraction exposed" 
% rather than "fraction shaded"
og_fractExposed = 1-shadLUTdata.data(:,3);
% put the pitch and yaw vectors through same transforms as the data
og_pitchVec = shadLUTdata.data(:,1);
og_yawVec = shadLUTdata.data(:,2);

% reshape the original data vector from the file
% and rotate to make it work
% now flip left-right to fix the mirror in the og file 
% (is % (72,72)=(up,left))
%and here's the original LUT:
ogLUT = fliplr(rot90(reshape(og_fractExposed,[L L]),-1));
%ogLUT = LUT12rev; this dirty little line was just to shortcut something
%that looked better for the corner LUTs. This should be re-run when the
%grasshopper sim can be run again, to get the real corner LUT data.

% now flip LUT left-right to make LUT for the opposite corner
ogLUTPrime = fliplr(ogLUT);
ogLUTPrimePrime = flipud(ogLUTPrime);
ogLUTPrimePrimePrime = fliplr(ogLUTPrimePrime);

%reshape the pitch and yaw vectors to match the LUT tables
og_yawTable = reshape(og_yawVec,[L L]);
og_pitchTable = reshape(og_pitchVec,[L L]);
% and flip the pitch table to fix the LR mirror in the og file
og_pitchTable = fliplr(og_pitchTable);

%% xlswrite to confirm
% xlswrite('C:\Users\Nick\Documents\CASE_to_SCOREC\IC_Solar\Shading_LUT\Generic_8x8\testxlsLUTout.xlsx',ogLUT)
pitchPrintVector = [72:-3:-72]';
yawPrintVector = fliplr(pitchPrintVector');
ssName = strcat('pctExposedLUT_module_',shadModNum,'.xlsx');

sstagPitch = {strcat('Pitch_Mod_',shadModNum)};
sstagYaw = {strcat('Yaw_Mod_',shadModNum)};
sstag = {strcat('Mod_',shadModNum)};
sstagPrime = {strcat('Mod_',shadModNum,'Prime')};
sstagPrimePrime = {strcat('Mod_',shadModNum,'Prime','Prime')};
sstagPrimePrimePrime = {strcat('Mod_',shadModNum,'Prime','Prime','Prime')};

xlswrite(ssName,sstag,1,'a1');
xlswrite(ssName,ogLUT,1,'b2');
xlswrite(ssName,pitchPrintVector,1,'a2');
xlswrite(ssName,yawPrintVector,1,'b1');

xlswrite(ssName,sstagPrime,2,'a1');
xlswrite(ssName,ogLUTPrime,2,'b2');
xlswrite(ssName,pitchPrintVector,2,'a2');
xlswrite(ssName,yawPrintVector,2,'b1');

xlswrite(ssName,sstagPrimePrime,3,'a1');
xlswrite(ssName,ogLUTPrimePrime,3,'b2');
xlswrite(ssName,pitchPrintVector,3,'a2');
xlswrite(ssName,yawPrintVector,3,'b1');

xlswrite(ssName,sstagPrimePrimePrime,4,'a1');
xlswrite(ssName,ogLUTPrimePrimePrime,4,'b2');
xlswrite(ssName,pitchPrintVector,4,'a2');
xlswrite(ssName,yawPrintVector,4,'b1');

xlswrite(ssName,sstagPitch,5,'a1');
xlswrite(ssName,og_pitchTable,5,'b2');
xlswrite(ssName,pitchPrintVector,5,'a2');
xlswrite(ssName,yawPrintVector,5,'b1');

xlswrite(ssName,sstagYaw,6,'a1');
xlswrite(ssName,og_yawTable,6,'b2');
xlswrite(ssName,pitchPrintVector,6,'a2');
xlswrite(ssName,yawPrintVector,6,'b1');


%% 
