!--------------------------------------------------------------------------------
!
!  Copyright (C) 2017  L. J. Allen, H. G. Brown, A. J. D’Alfonso, S.D. Findlay, B. D. Forbes
!
!  This program is free software: you can redistribute it and/or modify
!  it under the terms of the GNU General Public License as published by
!  the Free Software Foundation, either version 3 of the License, or
!  (at your option) any later version.
!  
!  This program is distributed in the hope that it will be useful,
!  but WITHOUT ANY WARRANTY; without even the implied warranty of
!  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!  GNU General Public License for more details.
!   
!  You should have received a copy of the GNU General Public License
!  along with this program.  If not, see <http://www.gnu.org/licenses/>.
!                       
!--------------------------------------------------------------------------------

!---------------------------------------------
module m_xray_factors
use m_precision
implicit none
save

!X-RAY FORM FACTORS
character(2), parameter :: element(92) = &
(/'H ','He','Li','Be','B ','C ','N ','O ','F ','Ne','Na','Mg','Al','Si','P ','S ','Cl','Ar','K ','Ca','Sc','Ti','V ', &
  'Cr','Mn','Fe','Co','Ni','Cu','Zn','Ga','Ge','As','Se','Br','Kr','Rb','Sr','Y ','Zr','Nb','Mo','Tc','Ru','Rh','Pd', &
  'Ag','Cd','In','Sn','Sb','Te','I ','Xe','Cs','Ba','La','Ce','Pr','Nd','Pm','Sm','Eu','Gd','Tb','Dy','Ho','Er','Tm', &
  'Yb','Lu','Hf','Ta','W ','Re','Os','Ir','Pt','Au','Hg','Tl','Pb','Bi','Po','At','Rn','Fr','Ra','Ac','Th','Pa','U '  /)
real(fp_kind), parameter :: xrayFF(14,92) = reshape( &
(/1.00_fp_kind,0.73235400_fp_kind,0.7538960_fp_kind,0.2838190_fp_kind,0.1900030_fp_kind,0.0391390_fp_kind,11.553918_fp_kind,4.59583100_fp_kind,1.54629900_fp_kind,26.4639640_fp_kind,0.37752300_fp_kind,0.00048700_fp_kind,2.0_fp_kind,8.769017454422158E-3_fp_kind,&
  2.00_fp_kind,0.73235400_fp_kind,0.7538960_fp_kind,0.2838190_fp_kind,0.1900030_fp_kind,0.0391390_fp_kind,11.553918_fp_kind,4.59583100_fp_kind,1.54629900_fp_kind,26.4639640_fp_kind,0.37752300_fp_kind,0.00048700_fp_kind,2.0_fp_kind,8.769017454422158E-3_fp_kind,&
  3.00_fp_kind,0.97463700_fp_kind,0.1584720_fp_kind,0.8118550_fp_kind,0.2624160_fp_kind,0.7901080_fp_kind,4.3349460_fp_kind,0.34245100_fp_kind,97.1029690_fp_kind,201.363824_fp_kind,1.40923400_fp_kind,0.00254200_fp_kind,3.0_fp_kind,3.053829815542358E-2_fp_kind,&
  4.00_fp_kind,1.53371200_fp_kind,0.6382830_fp_kind,0.6010520_fp_kind,0.1061390_fp_kind,1.1184140_fp_kind,42.662078_fp_kind,0.59542000_fp_kind,99.1065010_fp_kind,0.15134000_fp_kind,1.84309300_fp_kind,0.00251100_fp_kind,4.0_fp_kind,2.673011412693727E-2_fp_kind,&
  5.00_fp_kind,2.08518500_fp_kind,1.0645800_fp_kind,1.0627880_fp_kind,0.1405150_fp_kind,0.6417840_fp_kind,23.494069_fp_kind,1.13789400_fp_kind,61.2389750_fp_kind,0.11488600_fp_kind,0.39903600_fp_kind,0.00382300_fp_kind,5.0_fp_kind,4.375691177284862E-2_fp_kind,&
  6.00_fp_kind,2.65750600_fp_kind,1.0780790_fp_kind,1.4909090_fp_kind,-4.241070_fp_kind,0.7137910_fp_kind,14.780758_fp_kind,0.77677500_fp_kind,42.0868430_fp_kind,-0.0002940_fp_kind,0.23953500_fp_kind,4.29798300_fp_kind,6.0_fp_kind,7.163539380752063E-2_fp_kind,&
  7.00_fp_kind,11.8937800_fp_kind,3.2774790_fp_kind,1.8580920_fp_kind,0.8589270_fp_kind,0.9129850_fp_kind,0.0001580_fp_kind,10.2327230_fp_kind,30.3446900_fp_kind,0.65606500_fp_kind,0.21728700_fp_kind,-11.804902_fp_kind,7.0_fp_kind,0.112381925459201_fp_kind,&
  8.00_fp_kind,2.96042700_fp_kind,2.5088180_fp_kind,0.6378530_fp_kind,0.7228380_fp_kind,1.1427560_fp_kind,14.182259_fp_kind,5.93685800_fp_kind,0.11272600_fp_kind,34.9584810_fp_kind,0.39024000_fp_kind,0.02701400_fp_kind,8.0_fp_kind,0.171987724092682_fp_kind,&
  9.00_fp_kind,3.51195400_fp_kind,2.7722440_fp_kind,0.6783850_fp_kind,0.9151590_fp_kind,1.0892610_fp_kind,10.687859_fp_kind,4.38046600_fp_kind,0.09398200_fp_kind,27.2552030_fp_kind,0.31306600_fp_kind,0.03255700_fp_kind,9.0_fp_kind,0.223745513843300_fp_kind,&
  10.0_fp_kind,4.1837490_fp_kind,2.9057260_fp_kind,0.5205130_fp_kind,1.1356410_fp_kind,1.2280650_fp_kind,8.1754570_fp_kind,3.25253600_fp_kind,0.06329500_fp_kind,21.8139090_fp_kind,0.22495200_fp_kind,0.02557600_fp_kind,10.0_fp_kind,0.287627317325155_fp_kind,&
  11.0_fp_kind,4.9101270_fp_kind,3.0817830_fp_kind,1.2620670_fp_kind,1.0989380_fp_kind,0.5609910_fp_kind,3.2814340_fp_kind,9.11917800_fp_kind,0.10276300_fp_kind,132.013942_fp_kind,0.40587800_fp_kind,0.07971200_fp_kind,11.0_fp_kind,0.366747421044202_fp_kind,&
  12.0_fp_kind,4.7089710_fp_kind,1.1948140_fp_kind,1.5581570_fp_kind,1.1704130_fp_kind,3.2394030_fp_kind,4.8752070_fp_kind,108.506079_fp_kind,0.11151600_fp_kind,48.2924070_fp_kind,1.92817100_fp_kind,0.12684200_fp_kind,12.0_fp_kind,0.470985327996563_fp_kind,&
  13.0_fp_kind,4.7307960_fp_kind,2.3139510_fp_kind,1.5419800_fp_kind,1.1175640_fp_kind,3.1547540_fp_kind,3.6289310_fp_kind,43.0511660_fp_kind,0.09596000_fp_kind,108.932389_fp_kind,1.55591800_fp_kind,0.13950900_fp_kind,13.0_fp_kind,0.528931702148052_fp_kind,&
  14.0_fp_kind,5.2753290_fp_kind,3.1910380_fp_kind,1.5115140_fp_kind,1.3568490_fp_kind,2.5191140_fp_kind,2.6313380_fp_kind,33.7307280_fp_kind,0.08111900_fp_kind,86.2886400_fp_kind,1.17008700_fp_kind,0.14507300_fp_kind,14.0_fp_kind,0.592196010700308_fp_kind,&
  15.0_fp_kind,1.9505410_fp_kind,4.1469300_fp_kind,1.4945600_fp_kind,1.5220420_fp_kind,5.7297110_fp_kind,0.9081390_fp_kind,27.0449530_fp_kind,0.07128000_fp_kind,67.5201900_fp_kind,1.98117300_fp_kind,0.15523300_fp_kind,15.0_fp_kind,0.660050129218602_fp_kind,&
  16.0_fp_kind,6.3721570_fp_kind,5.1545680_fp_kind,1.4737320_fp_kind,1.6350730_fp_kind,1.2093720_fp_kind,1.5143470_fp_kind,22.0925280_fp_kind,0.06137300_fp_kind,55.4451760_fp_kind,0.64692500_fp_kind,0.15472200_fp_kind,16.0_fp_kind,0.726458197799532_fp_kind,&
  17.0_fp_kind,1.4460710_fp_kind,6.8706090_fp_kind,6.1518010_fp_kind,1.7503470_fp_kind,0.6341680_fp_kind,0.0523570_fp_kind,1.19316500_fp_kind,18.3434160_fp_kind,46.3983940_fp_kind,0.40100500_fp_kind,0.14677300_fp_kind,17.0_fp_kind,0.792912007492641_fp_kind,&
  18.0_fp_kind,7.1880040_fp_kind,6.6384540_fp_kind,0.4541800_fp_kind,1.9295930_fp_kind,1.5236540_fp_kind,0.9562210_fp_kind,15.3398770_fp_kind,15.3398620_fp_kind,39.0438240_fp_kind,0.06240900_fp_kind,0.26595400_fp_kind,18.0_fp_kind,0.874904035952563_fp_kind,&
  19.0_fp_kind,8.1639910_fp_kind,7.1469450_fp_kind,1.0701400_fp_kind,0.8773160_fp_kind,1.4864340_fp_kind,12.816323_fp_kind,0.80894500_fp_kind,210.327009_fp_kind,39.5976510_fp_kind,0.05282100_fp_kind,0.25361400_fp_kind,19.0_fp_kind,0.924257331263367_fp_kind,&
  20.0_fp_kind,8.5936550_fp_kind,1.4773240_fp_kind,1.4362540_fp_kind,1.1828390_fp_kind,7.1132580_fp_kind,10.460644_fp_kind,0.04189100_fp_kind,81.3903820_fp_kind,169.847839_fp_kind,0.68809800_fp_kind,0.19625500_fp_kind,20.0_fp_kind,0.967132503306553_fp_kind,&
  21.0_fp_kind,1.4765660_fp_kind,1.4872780_fp_kind,1.6001870_fp_kind,9.1774630_fp_kind,7.0997500_fp_kind,53.131022_fp_kind,0.03532500_fp_kind,137.319495_fp_kind,9.09803100_fp_kind,0.60210200_fp_kind,0.15776500_fp_kind,21.0_fp_kind,1.012975070461970_fp_kind,&
  22.0_fp_kind,9.8185240_fp_kind,1.5226460_fp_kind,1.7031010_fp_kind,1.7687740_fp_kind,7.0825550_fp_kind,8.0018790_fp_kind,0.02976300_fp_kind,39.8854230_fp_kind,120.158000_fp_kind,0.53240500_fp_kind,0.10247300_fp_kind,22.0_fp_kind,1.050876425199770_fp_kind,&
  23.0_fp_kind,10.473575_fp_kind,1.5478810_fp_kind,1.9863810_fp_kind,1.8656160_fp_kind,7.0562500_fp_kind,7.0819400_fp_kind,0.02604000_fp_kind,31.9096720_fp_kind,108.022844_fp_kind,0.47488200_fp_kind,0.06774400_fp_kind,23.0_fp_kind,1.086704198113510_fp_kind,&
  24.0_fp_kind,11.007069_fp_kind,1.5554770_fp_kind,2.9852930_fp_kind,1.3478550_fp_kind,7.0347790_fp_kind,6.3662810_fp_kind,0.02398700_fp_kind,23.2448380_fp_kind,105.774500_fp_kind,0.42936900_fp_kind,0.06551000_fp_kind,24.0_fp_kind,1.115649280845480_fp_kind,&
  25.0_fp_kind,11.709542_fp_kind,1.7334140_fp_kind,2.6731410_fp_kind,2.0233680_fp_kind,7.0031800_fp_kind,5.5971200_fp_kind,0.01780000_fp_kind,21.7884190_fp_kind,89.5179150_fp_kind,0.38305400_fp_kind,-0.1472930_fp_kind,25.0_fp_kind,1.137904401534530_fp_kind,&
  26.0_fp_kind,12.311098_fp_kind,1.8766230_fp_kind,3.0661770_fp_kind,2.0704510_fp_kind,6.9751850_fp_kind,5.0094150_fp_kind,0.01446100_fp_kind,18.7430410_fp_kind,82.7678740_fp_kind,0.34650600_fp_kind,-0.3049310_fp_kind,26.0_fp_kind,1.157781969494130_fp_kind,&
  27.0_fp_kind,12.914510_fp_kind,2.4819080_fp_kind,3.4668940_fp_kind,2.1063510_fp_kind,6.9608920_fp_kind,4.5071380_fp_kind,0.00912600_fp_kind,16.4381300_fp_kind,76.9873170_fp_kind,0.31441800_fp_kind,-0.9365720_fp_kind,27.0_fp_kind,1.170782166833100_fp_kind,&
  28.0_fp_kind,13.521865_fp_kind,6.9472850_fp_kind,3.8660280_fp_kind,2.1359000_fp_kind,4.2847310_fp_kind,4.0772770_fp_kind,0.28676300_fp_kind,14.6226340_fp_kind,71.9660780_fp_kind,0.00443700_fp_kind,-2.7626970_fp_kind,28.0_fp_kind,1.181463309062120_fp_kind,&
  29.0_fp_kind,14.014192_fp_kind,4.7845770_fp_kind,5.0568060_fp_kind,1.4579710_fp_kind,6.9329960_fp_kind,3.7382800_fp_kind,0.00374400_fp_kind,13.0349820_fp_kind,72.5547930_fp_kind,0.26566600_fp_kind,-3.2544770_fp_kind,29.0_fp_kind,1.189120722007890_fp_kind,&
  30.0_fp_kind,14.741002_fp_kind,6.9077480_fp_kind,4.6423370_fp_kind,2.1917660_fp_kind,38.424042_fp_kind,3.3882320_fp_kind,0.24331500_fp_kind,11.9036890_fp_kind,63.3121300_fp_kind,0.00039700_fp_kind,-36.915828_fp_kind,30.0_fp_kind,1.195267016288100_fp_kind,&
  31.0_fp_kind,15.758946_fp_kind,6.8411230_fp_kind,4.1210160_fp_kind,2.7146810_fp_kind,2.3952460_fp_kind,3.1217540_fp_kind,0.22605700_fp_kind,12.4821960_fp_kind,66.2036220_fp_kind,0.00723800_fp_kind,-0.8473950_fp_kind,31.0_fp_kind,1.200512778463350_fp_kind,&
  32.0_fp_kind,16.540614_fp_kind,1.5679000_fp_kind,3.7278290_fp_kind,3.3450980_fp_kind,6.7850790_fp_kind,2.8666180_fp_kind,0.01219800_fp_kind,13.4321630_fp_kind,58.8660460_fp_kind,0.21097400_fp_kind,0.01872600_fp_kind,32.0_fp_kind,1.200655847244250_fp_kind,&
  33.0_fp_kind,17.025643_fp_kind,4.5034410_fp_kind,3.7159040_fp_kind,3.9372000_fp_kind,6.7901750_fp_kind,2.5977390_fp_kind,0.00301200_fp_kind,14.2721190_fp_kind,50.4379970_fp_kind,0.19301500_fp_kind,-2.9841170_fp_kind,33.0_fp_kind,1.198314141346290_fp_kind,&
  34.0_fp_kind,17.354071_fp_kind,4.6532480_fp_kind,4.2594890_fp_kind,4.1364550_fp_kind,6.7491630_fp_kind,2.3497870_fp_kind,0.00255000_fp_kind,15.5794600_fp_kind,45.1812010_fp_kind,0.17743200_fp_kind,-3.1609820_fp_kind,34.0_fp_kind,1.198528926857700_fp_kind,&
  35.0_fp_kind,17.550570_fp_kind,5.4118820_fp_kind,3.9371800_fp_kind,3.8806450_fp_kind,6.7077930_fp_kind,2.1192260_fp_kind,16.5571850_fp_kind,0.00248100_fp_kind,42.1640090_fp_kind,0.16212100_fp_kind,-2.4920880_fp_kind,35.0_fp_kind,1.199161541836410_fp_kind,&
  36.0_fp_kind,17.655279_fp_kind,6.8481050_fp_kind,4.1710040_fp_kind,3.4467600_fp_kind,6.6852000_fp_kind,1.9082310_fp_kind,16.6062350_fp_kind,0.00159800_fp_kind,39.9174710_fp_kind,0.14689600_fp_kind,-2.8105920_fp_kind,36.0_fp_kind,1.199687791703070_fp_kind,&
  37.0_fp_kind,8.1231340_fp_kind,2.1380420_fp_kind,6.7617020_fp_kind,1.1560510_fp_kind,17.679547_fp_kind,15.142385_fp_kind,33.5426660_fp_kind,0.12937200_fp_kind,224.132506_fp_kind,1.71336800_fp_kind,1.13954800_fp_kind,37.0_fp_kind,1.210575215851800_fp_kind,&
  38.0_fp_kind,17.730219_fp_kind,9.7958670_fp_kind,6.0997630_fp_kind,2.6200250_fp_kind,0.6000530_fp_kind,1.5630600_fp_kind,14.3108680_fp_kind,0.12057400_fp_kind,135.771318_fp_kind,0.12057400_fp_kind,1.14025100_fp_kind,38.0_fp_kind,1.201749013781440_fp_kind,&
  39.0_fp_kind,17.792040_fp_kind,10.253252_fp_kind,5.7149490_fp_kind,3.1705160_fp_kind,0.9182510_fp_kind,1.4296910_fp_kind,13.1328160_fp_kind,0.11217300_fp_kind,108.197029_fp_kind,0.11217300_fp_kind,1.31787000_fp_kind,39.0_fp_kind,1.375021858691620_fp_kind,&
  40.0_fp_kind,17.859771_fp_kind,10.911038_fp_kind,5.8211150_fp_kind,3.5125130_fp_kind,0.7469650_fp_kind,1.3106920_fp_kind,12.3192850_fp_kind,0.10435300_fp_kind,91.7775440_fp_kind,0.10435300_fp_kind,1.12485900_fp_kind,40.0_fp_kind,1.188442917505480_fp_kind,&
  41.0_fp_kind,17.958398_fp_kind,12.063054_fp_kind,5.0070150_fp_kind,3.2876670_fp_kind,1.5310190_fp_kind,1.2115900_fp_kind,12.2466870_fp_kind,0.09861500_fp_kind,75.0119440_fp_kind,0.09861500_fp_kind,1.12345200_fp_kind,41.0_fp_kind,1.189359603719730_fp_kind,&
  42.0_fp_kind,6.2362180_fp_kind,17.987711_fp_kind,12.973127_fp_kind,3.4514260_fp_kind,0.2108990_fp_kind,0.0907800_fp_kind,1.10831000_fp_kind,11.4687200_fp_kind,66.6841530_fp_kind,0.09078000_fp_kind,1.10877000_fp_kind,42.0_fp_kind,1.199482060769910_fp_kind,&
  43.0_fp_kind,17.840964_fp_kind,3.4282360_fp_kind,1.3730120_fp_kind,12.947364_fp_kind,6.3354690_fp_kind,1.0057290_fp_kind,41.9013830_fp_kind,119.320541_fp_kind,9.78154200_fp_kind,0.08339100_fp_kind,1.07478400_fp_kind,43.0_fp_kind,1.202197031328830_fp_kind,&
  44.0_fp_kind,6.2716240_fp_kind,17.906739_fp_kind,14.123269_fp_kind,3.7460080_fp_kind,0.9082350_fp_kind,0.0770400_fp_kind,0.92822200_fp_kind,9.55534500_fp_kind,35.8606780_fp_kind,123.552247_fp_kind,1.04399200_fp_kind,44.0_fp_kind,1.214228346945880_fp_kind,&
  45.0_fp_kind,6.2166480_fp_kind,17.919738_fp_kind,3.8542520_fp_kind,0.8403260_fp_kind,15.173498_fp_kind,0.0707890_fp_kind,0.85612100_fp_kind,33.8894840_fp_kind,121.686688_fp_kind,9.02951700_fp_kind,0.99545200_fp_kind,45.0_fp_kind,1.225662002307150_fp_kind,&
  46.0_fp_kind,6.1215110_fp_kind,4.7840630_fp_kind,16.631683_fp_kind,4.3182580_fp_kind,13.246773_fp_kind,0.0625490_fp_kind,0.78403100_fp_kind,8.75139100_fp_kind,34.4899830_fp_kind,0.78403100_fp_kind,0.88309900_fp_kind,46.0_fp_kind,1.236213451657990_fp_kind,&
  47.0_fp_kind,6.0738740_fp_kind,17.155437_fp_kind,4.1733440_fp_kind,0.8522380_fp_kind,17.988685_fp_kind,0.0553330_fp_kind,7.89651200_fp_kind,28.4437390_fp_kind,110.376108_fp_kind,0.71680900_fp_kind,0.75660300_fp_kind,47.0_fp_kind,1.256597538627620_fp_kind,&
  48.0_fp_kind,6.0809860_fp_kind,18.019468_fp_kind,4.0181970_fp_kind,1.3035100_fp_kind,17.974669_fp_kind,0.0489900_fp_kind,7.27364600_fp_kind,29.1192830_fp_kind,95.8312080_fp_kind,0.66123100_fp_kind,0.60350400_fp_kind,48.0_fp_kind,1.278260006400250_fp_kind,&
  49.0_fp_kind,6.1964770_fp_kind,18.816183_fp_kind,4.0504790_fp_kind,1.6389290_fp_kind,17.962912_fp_kind,0.0420720_fp_kind,6.69566500_fp_kind,31.0097910_fp_kind,103.284350_fp_kind,0.61071400_fp_kind,0.33309700_fp_kind,49.0_fp_kind,1.290470357489140_fp_kind,&
  50.0_fp_kind,19.325171_fp_kind,6.2815710_fp_kind,4.4988660_fp_kind,1.8569340_fp_kind,17.917318_fp_kind,6.1181040_fp_kind,0.03691500_fp_kind,32.5290470_fp_kind,95.0371820_fp_kind,0.56565100_fp_kind,0.11902400_fp_kind,50.0_fp_kind,1.330549377714000_fp_kind,&
  51.0_fp_kind,5.3949560_fp_kind,6.5495700_fp_kind,19.650681_fp_kind,1.8278200_fp_kind,17.867833_fp_kind,33.326523_fp_kind,0.03097400_fp_kind,5.56492900_fp_kind,87.1309650_fp_kind,0.52399200_fp_kind,-0.2905060_fp_kind,51.0_fp_kind,1.360402686938670_fp_kind,&
  52.0_fp_kind,6.6603020_fp_kind,6.9407560_fp_kind,19.847015_fp_kind,1.5571750_fp_kind,17.802427_fp_kind,33.031656_fp_kind,0.02575000_fp_kind,5.06554700_fp_kind,84.1016130_fp_kind,0.48766000_fp_kind,-0.8066680_fp_kind,52.0_fp_kind,1.395171636062690_fp_kind,&
  53.0_fp_kind,19.884502_fp_kind,6.7365930_fp_kind,8.1105160_fp_kind,1.1709530_fp_kind,17.548715_fp_kind,4.6285910_fp_kind,0.02775400_fp_kind,31.8490960_fp_kind,84.4063910_fp_kind,0.46355000_fp_kind,-0.4488110_fp_kind,53.0_fp_kind,1.434934988906490_fp_kind,&
  54.0_fp_kind,19.978920_fp_kind,11.774945_fp_kind,9.3321820_fp_kind,1.2447490_fp_kind,17.737501_fp_kind,4.1433560_fp_kind,0.01014200_fp_kind,28.7961990_fp_kind,75.2806880_fp_kind,0.41361600_fp_kind,-6.0659020_fp_kind,54.0_fp_kind,1.461928150660960_fp_kind,&
  55.0_fp_kind,17.418675_fp_kind,8.3144440_fp_kind,10.323193_fp_kind,1.3838340_fp_kind,19.876252_fp_kind,0.3998280_fp_kind,0.01687200_fp_kind,25.6058280_fp_kind,233.339674_fp_kind,3.82691500_fp_kind,-2.3228020_fp_kind,55.0_fp_kind,1.504734672998740_fp_kind,&
  56.0_fp_kind,19.747344_fp_kind,17.368476_fp_kind,10.465718_fp_kind,2.5926020_fp_kind,11.003653_fp_kind,3.4818230_fp_kind,0.37122400_fp_kind,21.2266410_fp_kind,173.834271_fp_kind,0.01071900_fp_kind,-5.1834970_fp_kind,56.0_fp_kind,1.540051791581430_fp_kind,&
  57.0_fp_kind,19.966018_fp_kind,27.329654_fp_kind,11.018425_fp_kind,3.0866960_fp_kind,17.335454_fp_kind,3.1974080_fp_kind,0.00344600_fp_kind,19.9554920_fp_kind,141.381979_fp_kind,0.34181700_fp_kind,-21.745489_fp_kind,57.0_fp_kind,1.579460053005520_fp_kind,&
  58.0_fp_kind,17.355121_fp_kind,43.988498_fp_kind,20.546650_fp_kind,3.1306700_fp_kind,11.353665_fp_kind,0.3283690_fp_kind,0.00204700_fp_kind,3.08819600_fp_kind,134.907661_fp_kind,18.8329610_fp_kind,-38.386017_fp_kind,58.0_fp_kind,1.606421481188560_fp_kind,&
  59.0_fp_kind,21.551311_fp_kind,17.161729_fp_kind,11.903859_fp_kind,2.6791030_fp_kind,9.5641970_fp_kind,2.9956750_fp_kind,0.31249100_fp_kind,17.7167050_fp_kind,152.192827_fp_kind,0.01046800_fp_kind,-3.8710680_fp_kind,59.0_fp_kind,1.720026152321630_fp_kind,&
  60.0_fp_kind,17.331244_fp_kind,62.783923_fp_kind,12.160097_fp_kind,2.6634830_fp_kind,22.239951_fp_kind,0.3002690_fp_kind,0.00132000_fp_kind,17.0260010_fp_kind,148.748986_fp_kind,2.91026800_fp_kind,-57.189844_fp_kind,60.0_fp_kind,1.683652354338470_fp_kind,&
  61.0_fp_kind,17.286388_fp_kind,51.560161_fp_kind,12.478557_fp_kind,2.6755150_fp_kind,22.960947_fp_kind,0.2866200_fp_kind,0.00155000_fp_kind,16.2237550_fp_kind,143.984513_fp_kind,2.79648000_fp_kind,-45.973681_fp_kind,61.0_fp_kind,1.724693404362830_fp_kind,&
  62.0_fp_kind,23.700364_fp_kind,23.072215_fp_kind,12.777782_fp_kind,2.6842170_fp_kind,17.204366_fp_kind,2.6895390_fp_kind,0.00349100_fp_kind,15.4954370_fp_kind,139.862475_fp_kind,0.27453600_fp_kind,-17.452166_fp_kind,62.0_fp_kind,1.764012158926800_fp_kind,&
  63.0_fp_kind,17.186195_fp_kind,37.156839_fp_kind,13.103387_fp_kind,2.7072460_fp_kind,24.419271_fp_kind,0.2616780_fp_kind,0.00199500_fp_kind,14.7873600_fp_kind,134.816293_fp_kind,2.58188300_fp_kind,-31.586687_fp_kind,63.0_fp_kind,1.797805735087610_fp_kind,&
  64.0_fp_kind,24.898118_fp_kind,17.104951_fp_kind,13.222581_fp_kind,3.2661520_fp_kind,48.995214_fp_kind,2.4350280_fp_kind,0.24696100_fp_kind,13.9963250_fp_kind,110.863093_fp_kind,0.00138300_fp_kind,-43.505684_fp_kind,64.0_fp_kind,1.840118637821660_fp_kind,&
  65.0_fp_kind,25.910013_fp_kind,32.344139_fp_kind,13.765117_fp_kind,2.7514040_fp_kind,17.064405_fp_kind,2.3739120_fp_kind,0.00203400_fp_kind,13.4819690_fp_kind,125.836511_fp_kind,0.23691600_fp_kind,-26.851970_fp_kind,65.0_fp_kind,1.871313100571290_fp_kind,&
  66.0_fp_kind,26.671785_fp_kind,88.687577_fp_kind,14.065445_fp_kind,2.7684970_fp_kind,17.067782_fp_kind,2.2825930_fp_kind,0.00066500_fp_kind,12.9202300_fp_kind,121.937188_fp_kind,0.22553100_fp_kind,-83.279831_fp_kind,66.0_fp_kind,1.903720643077100_fp_kind,&
  67.0_fp_kind,27.150190_fp_kind,16.999819_fp_kind,14.059334_fp_kind,3.3869790_fp_kind,46.546471_fp_kind,2.1696600_fp_kind,0.21541400_fp_kind,12.2131480_fp_kind,100.506781_fp_kind,0.00121100_fp_kind,-41.165253_fp_kind,67.0_fp_kind,1.926235156557560_fp_kind,&
  68.0_fp_kind,28.174886_fp_kind,82.493269_fp_kind,14.624002_fp_kind,2.8027560_fp_kind,17.018515_fp_kind,2.1209950_fp_kind,0.00064000_fp_kind,11.9152560_fp_kind,114.529936_fp_kind,0.20751900_fp_kind,-77.135221_fp_kind,68.0_fp_kind,1.946913272263270_fp_kind,&
  69.0_fp_kind,28.925894_fp_kind,76.173796_fp_kind,14.904704_fp_kind,2.8148120_fp_kind,16.998117_fp_kind,2.0462030_fp_kind,0.00065600_fp_kind,11.4653750_fp_kind,111.411979_fp_kind,0.19937600_fp_kind,-70.839813_fp_kind,69.0_fp_kind,1.963724205103120_fp_kind,&
  70.0_fp_kind,29.676760_fp_kind,65.624068_fp_kind,15.160854_fp_kind,2.8302880_fp_kind,16.997850_fp_kind,1.9776300_fp_kind,0.00072000_fp_kind,11.0446220_fp_kind,108.139150_fp_kind,0.19211000_fp_kind,-60.313812_fp_kind,70.0_fp_kind,1.979258983014140_fp_kind,&
  71.0_fp_kind,30.122865_fp_kind,15.099346_fp_kind,56.314899_fp_kind,3.5409800_fp_kind,16.943730_fp_kind,1.8830900_fp_kind,10.3427640_fp_kind,0.00078000_fp_kind,89.5592480_fp_kind,0.18384900_fp_kind,-51.049417_fp_kind,71.0_fp_kind,1.995446352857520_fp_kind,&
  72.0_fp_kind,30.617033_fp_kind,15.145351_fp_kind,54.933548_fp_kind,4.0962530_fp_kind,16.896157_fp_kind,1.7956130_fp_kind,9.93446900_fp_kind,0.00073900_fp_kind,76.1897070_fp_kind,0.17591400_fp_kind,-49.719838_fp_kind,72.0_fp_kind,2.006728379573300_fp_kind,&
  73.0_fp_kind,31.066358_fp_kind,15.341823_fp_kind,49.278296_fp_kind,4.5776650_fp_kind,16.828321_fp_kind,1.7087320_fp_kind,9.61845500_fp_kind,0.00076000_fp_kind,66.3462020_fp_kind,0.16800200_fp_kind,-44.119025_fp_kind,73.0_fp_kind,2.014810640008000_fp_kind,&
  74.0_fp_kind,31.507901_fp_kind,15.682498_fp_kind,37.960127_fp_kind,4.8855090_fp_kind,16.792113_fp_kind,1.6294850_fp_kind,9.44644800_fp_kind,0.00089800_fp_kind,59.9806750_fp_kind,0.16079800_fp_kind,-32.864576_fp_kind,74.0_fp_kind,2.024233087057100_fp_kind,&
  75.0_fp_kind,31.888456_fp_kind,16.117103_fp_kind,42.390296_fp_kind,5.2116690_fp_kind,16.767591_fp_kind,1.5492380_fp_kind,9.23347400_fp_kind,0.00068900_fp_kind,54.5163710_fp_kind,0.15281500_fp_kind,-37.412681_fp_kind,75.0_fp_kind,2.032203945323960_fp_kind,&
  76.0_fp_kind,32.210298_fp_kind,16.678440_fp_kind,48.559907_fp_kind,5.4558390_fp_kind,16.735532_fp_kind,1.4735310_fp_kind,9.04969500_fp_kind,0.00051900_fp_kind,50.2102010_fp_kind,0.14577100_fp_kind,-43.677954_fp_kind,76.0_fp_kind,2.037562299152530_fp_kind,&
  77.0_fp_kind,32.004437_fp_kind,1.9754540_fp_kind,17.070104_fp_kind,15.939454_fp_kind,5.9900030_fp_kind,1.3537670_fp_kind,81.0141720_fp_kind,0.12809300_fp_kind,7.66119600_fp_kind,26.6594030_fp_kind,4.01889300_fp_kind,77.0_fp_kind,2.070931471354530_fp_kind,&
  78.0_fp_kind,31.273891_fp_kind,18.445441_fp_kind,17.063745_fp_kind,5.5559330_fp_kind,1.5752700_fp_kind,1.3169920_fp_kind,8.79715400_fp_kind,0.12474100_fp_kind,40.1779940_fp_kind,1.31699700_fp_kind,4.05039400_fp_kind,78.0_fp_kind,2.070307656542580_fp_kind,&
  79.0_fp_kind,16.777389_fp_kind,19.317156_fp_kind,32.979682_fp_kind,5.5954530_fp_kind,10.576854_fp_kind,0.1227370_fp_kind,8.62157000_fp_kind,1.25690200_fp_kind,38.0088210_fp_kind,0.00060100_fp_kind,-6.2790780_fp_kind,79.0_fp_kind,2.058834893082310_fp_kind,&
  80.0_fp_kind,16.839889_fp_kind,20.023823_fp_kind,28.428565_fp_kind,5.8815640_fp_kind,4.7147060_fp_kind,0.1159050_fp_kind,8.25692700_fp_kind,1.19525000_fp_kind,39.2472260_fp_kind,1.19525000_fp_kind,4.07647800_fp_kind,80.0_fp_kind,2.063026432193550_fp_kind,&
  81.0_fp_kind,16.630795_fp_kind,19.386615_fp_kind,32.808570_fp_kind,1.7471910_fp_kind,6.3568620_fp_kind,0.1107040_fp_kind,7.18140100_fp_kind,1.11973000_fp_kind,90.6602620_fp_kind,26.0149780_fp_kind,4.06693900_fp_kind,81.0_fp_kind,2.055981336260000_fp_kind,&
  82.0_fp_kind,16.419567_fp_kind,32.738592_fp_kind,6.5302470_fp_kind,2.3427420_fp_kind,19.916475_fp_kind,0.1054990_fp_kind,1.05504900_fp_kind,25.0258900_fp_kind,80.9065960_fp_kind,6.66444900_fp_kind,4.04982400_fp_kind,82.0_fp_kind,2.050009704660440_fp_kind,&
  83.0_fp_kind,16.282274_fp_kind,32.725137_fp_kind,6.6783020_fp_kind,2.6947500_fp_kind,20.576559_fp_kind,0.1011800_fp_kind,1.00228700_fp_kind,25.7141450_fp_kind,77.0575500_fp_kind,6.29188200_fp_kind,4.04091400_fp_kind,83.0_fp_kind,2.047846539848800_fp_kind,&
  84.0_fp_kind,16.289164_fp_kind,32.807170_fp_kind,21.095164_fp_kind,2.5059010_fp_kind,7.2545890_fp_kind,0.0981210_fp_kind,0.96626500_fp_kind,6.04662200_fp_kind,76.5980710_fp_kind,28.0961280_fp_kind,4.04655600_fp_kind,84.0_fp_kind,2.048640858343320_fp_kind,&
  85.0_fp_kind,16.011461_fp_kind,32.615549_fp_kind,8.1138990_fp_kind,2.8840820_fp_kind,21.377867_fp_kind,0.0926390_fp_kind,0.90441600_fp_kind,26.5432560_fp_kind,68.3729610_fp_kind,5.49951200_fp_kind,3.99568400_fp_kind,85.0_fp_kind,2.043577109058100_fp_kind,&
  86.0_fp_kind,16.070228_fp_kind,32.641105_fp_kind,21.489659_fp_kind,2.2992180_fp_kind,9.4801840_fp_kind,0.0904370_fp_kind,0.87640900_fp_kind,5.23968700_fp_kind,69.1884770_fp_kind,27.6326400_fp_kind,4.02097700_fp_kind,86.0_fp_kind,2.053343320831720_fp_kind,&
  87.0_fp_kind,16.007386_fp_kind,32.663830_fp_kind,21.594351_fp_kind,1.5984970_fp_kind,11.121192_fp_kind,0.0870310_fp_kind,0.84018700_fp_kind,4.95446700_fp_kind,199.805805_fp_kind,26.9051060_fp_kind,4.00347200_fp_kind,87.0_fp_kind,2.056402858312870_fp_kind,&
  88.0_fp_kind,32.563691_fp_kind,21.396671_fp_kind,11.298093_fp_kind,2.8346880_fp_kind,15.914965_fp_kind,0.8019800_fp_kind,4.59066600_fp_kind,22.7589730_fp_kind,160.404392_fp_kind,0.08354400_fp_kind,3.98177300_fp_kind,88.0_fp_kind,2.062350469636460_fp_kind,&
  89.0_fp_kind,15.914053_fp_kind,32.535042_fp_kind,21.553976_fp_kind,11.433394_fp_kind,3.6124090_fp_kind,0.0805110_fp_kind,0.77066900_fp_kind,4.35220600_fp_kind,21.3816220_fp_kind,130.500748_fp_kind,3.93921200_fp_kind,89.0_fp_kind,2.059606329205960_fp_kind,&
  90.0_fp_kind,15.784024_fp_kind,32.454898_fp_kind,21.849222_fp_kind,4.2390770_fp_kind,11.736191_fp_kind,0.0770670_fp_kind,0.73513700_fp_kind,4.09797600_fp_kind,109.464113_fp_kind,20.5121380_fp_kind,3.92253300_fp_kind,90.0_fp_kind,2.076093709574790_fp_kind,&
  91.0_fp_kind,32.740208_fp_kind,21.973674_fp_kind,12.957398_fp_kind,3.6838320_fp_kind,15.744058_fp_kind,0.7095450_fp_kind,4.05088100_fp_kind,19.2315420_fp_kind,117.255006_fp_kind,0.07404000_fp_kind,3.88606600_fp_kind,91.0_fp_kind,2.084768702621660_fp_kind,&
  92.0_fp_kind,15.679275_fp_kind,32.824305_fp_kind,13.660459_fp_kind,3.6872610_fp_kind,22.279435_fp_kind,0.0712060_fp_kind,0.68117700_fp_kind,18.2361570_fp_kind,112.500040_fp_kind,3.93032500_fp_kind,3.85444400_fp_kind,92.0_fp_kind,2.096286630784310_fp_kind/),&
  shape(xrayFF))

end module m_xray_factors
!---------------------------------------------