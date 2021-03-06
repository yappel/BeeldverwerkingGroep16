% This is how you should structure your output
sampleOutput = {
    'XT-LX-69', 2, 0.919;
    'RP-NL-93', 39, 5.710;
    '63-HK-HD', 103, 7.237;
    '01-XJ-ND', 115, 10.339;
    '96-ND-JB', 159, 14.209;
    '57-LF-JB', 195, 17.859;
    'VD-020-P', 249, 20.858;
    'XS-NB-23', 265, 21.930;
    '98-THD-4', 320, 24.696;
    '23-GSX-6', 329, 28.602;
    '24-LB-HT', 393, 31.257;
    '56-JTT-5', 404, 33.313;
    'ZD-PB-67', 466, 37.842;
    '92-GS-VH', 482, 41.023;
    '53-DH-TT', 533, 43.056;
    '58-RV-BL', 565, 45.678;
    '92-LHR-6', 611, 50.160;
    '73-JT-JN', 619, 52.375;
    '3-VFX-39', 671, 56.796;
    '03-TD-JH', 704, 58.911;
    '32-LBD-6', 745, 62.776;
    '53-NB-KZ', 762, 64.267;
    '63-LZ-DL', 804, 68.107;
    '20-JL-DS', 861, 70.514;
    'BV-PN-40', 894, 73.035;
    '55-BBH-8', 920, 76.217;
    'BS-BS-48', 969, 80.055;
    '16-BBT-4', 1002, 81.404;
    'BZ-DN-25', 1019, 86.322;
    '56-ZBP-4', 1052, 87.183;
    '11-HL-ZR', 1098, 93.055;
    'DD-NR-82', 1145, 96.388;
    '77-TXB-3', 1197, 98.671;
    'TT-BJ-59', 1251, 105.340;
    '26-XV-KK', 1293, 107.138;
    '91-JGL-4', 1328, 111.790;
    '65-NSJ-5', 1373, 115.395;
    '32-ZNG-8', 1408, 119.009;
    '31-PVD-1', 1464, 121.009;
    '90-PJK-7', 1527, 128.676;
    '87-XFN-4', 1594, 132.953;
    '11-RL-SJ', 1596, 132.698;
    'ST-BD-82', 1628, 135.419;
    'PX-HB-62', 1616, 134.305;
    '72-VGX-6', 1637, 137.993;
    '04-BK-HL', 1664, 136.884;
    '38-DD-GG', 1699, 139.290;
    '75-SK-HD', 1682, 139.865;
    '19-GG-SX', 1710, 143.924;
    '86-ZB-NR', 1716, 144.881;
    '77-TR-SH', 1758, 147.238;
    '85-GJ-45', 1777, 149.849;
    'NWMMX45', 1833, 153.438;
    '1CMV331', 1872, 156.645;
    'DS346WG', 1918, 157.540;
};

% Compare your output with the file 'trainingSolutions.mat', which contains the solution of 'Trainingsvideo.avi'
checkSolution(sampleOutput, 'trainingSolutions.mat');
