function [Tree, Traces] = load_dataset(name)

if strcmp(name, 'NG-1 short')
   
    Tree = load('NG-1_graph_signal_t24_t180.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 24;
    Tree.final_frame = 180;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % manually add missed node
    additional_div_node_names = {'024_008'}; % missed on first frame
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:3) = 16;
    Tree.div_node_stage(4:19) = 32;
    Tree.div_node_stage(20:51) = 64;
    Tree.div_node_stage(52:58) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'180_002', '180_005', '180_007', '180_009', '180_010', '180_011', ...
        '180_013', '180_014', '180_016', '180_017', '180_021', '180_023', '180_025', ...
        '180_029', '180_036', '180_040', '180_042', '180_047', '180_051', '180_052', ...
        '180_063', '180_389', '180_390', '180_391'};

    % For plotting purposes
    Tree.final_EPI1_names = {'180_390', '180_052', '180_011', '180_016', '180_009', ...
        '180_036'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, false);

elseif strcmp(name, 'NG-2 short')

    Tree = load('NG-2_graph_signal_t1_t184.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 1;
    Tree.final_frame = 184;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:8) = 16;
    Tree.div_node_stage([9:21, 33:35]) = 32;
    Tree.div_node_stage([22:32, 36:55]) = 64;
    Tree.div_node_stage(56:57) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'184_326', '184_327', '184_329', '184_331', '184_333', '184_334', ...
        '184_335', '184_336', '184_338', '184_341', '184_342', '184_345', '184_348', ...
        '184_349', '184_350', '184_351', '184_352', '184_353', '184_354', '184_355', ...
        '184_360', '184_361', '184_365'};

    % For plotting purposes
    Tree.final_EPI1_names = {'184_354', '184_361', '184_352', '184_365', '184_336', ...
        '184_348', '184_355'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, false);

elseif strcmp(name, 'NG-3')

    Tree = load('NG-3_graph_signal_t1_t162.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 1;
    Tree.final_frame = 162;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % manually add missed nodes
    additional_div_node_names = {'001_008', '001_007', '001_003'}; % missed on first frame
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:5) = 16;
    Tree.div_node_stage(6:21) = 32;
    Tree.div_node_stage(22:53) = 64;
    Tree.div_node_stage(54:55) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'162_015', '162_019', '162_020', '162_026', '162_029', '162_030', ...
        '162_034', '162_047', '162_053', '162_315', '162_317', '162_318', '162_319', ...
        '162_326'};

    % For plotting purposes
    Tree.final_EPI1_names = {'162_317', '162_047', '162_015'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, false);

elseif strcmp(name, 'NG-4')

    Tree = load('NG-4_graph_signal_t1_t160.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 1;
    Tree.final_frame = 160;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % manually add missed node
    additional_div_node_names = {};
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:8) = 16;
    Tree.div_node_stage(9:24) = 32;
    Tree.div_node_stage(25:55) = 64;
    Tree.div_node_stage(56) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'160_004', '160_005', '160_008', '160_013', '160_014', '160_015', ...
        '160_016', '160_019', '160_023', '160_024', '160_025', '160_027', '160_028', ...
        '160_031', '160_032', '160_033', '160_042', '160_046', '160_047', '160_050', ...
        '160_054', '160_080', '160_081', '160_266'};

    % For plotting purposes
    Tree.final_EPI1_names = {'160_023', '160_019', '160_013'};

    node_frame = split(Tree.G_based_on_nn.Nodes.Name, '_');
    node_frame = str2double(node_frame(:,1));

    % For this embryo we renormalize nanog and gata6, excluding frames 75
    % through 125
    temp = Tree.G_based_on_nn.Nodes.Nanog_interp(node_frame < 75 | node_frame > 125);
    Tree.G_based_on_nn.Nodes.Nanog_norm = (Tree.G_based_on_nn.Nodes.Nanog_interp - min(temp)) / (max(temp) - min(temp));
    temp = Tree.G_based_on_nn.Nodes.Gata6_interp(node_frame < 75 | node_frame > 125);
    Tree.G_based_on_nn.Nodes.Gata6_norm = (Tree.G_based_on_nn.Nodes.Gata6_interp - min(temp)) / (max(temp) - min(temp));

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, false);

elseif strcmp(name, 'NG-5')

    Tree = load('NG-5_graph_signal_t1_t176.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 1;
    Tree.final_frame = 176;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % manually add missed node
    additional_div_node_names = {}; % none for this embryo
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:8) = 16;
    Tree.div_node_stage(9:24) = 32;
    Tree.div_node_stage(25:56) = 64;
    Tree.div_node_stage(57:65) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'176_012', '176_018', '176_027', '176_031', '176_032', '176_034', ...
        '176_037', '176_038', '176_039', '176_040', '176_041', '176_042', '176_045', ...
        '176_046', '176_047', '176_051', '176_056', '176_193', '176_194', '176_195', ...
        '176_197', '176_200', '176_202'};

    % For plotting purposes
    Tree.final_EPI1_names = {};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, false);

elseif strcmp(name, 'NG-6')

    Tree = load('NG-6_graph_signal_t76_t160.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 76;
    Tree.final_frame = 160;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % manually add missed node
    additional_div_node_names = {};
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage([1:14,16,22]) = 32;
    Tree.div_node_stage([15,17:21,23:37,39,41:45,48,50]) = 64;
    Tree.div_node_stage([38,40,46:49,51]) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'160_003', '160_005', '160_008', '160_009', '160_013', '160_014', ...
        '160_016', '160_017', '160_021', '160_023', '160_025', '160_026', '160_029', ...
        '160_031', '160_035', '160_037', '160_038', '160_039', '160_041', '160_042', ...
        '160_054', '160_063', '160_064', '160_179', '160_180', '160_182'};

    % For plotting purposes
    Tree.final_EPI1_names = {'160_021', '160_005', '160_014', '160_026'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, false);

elseif strcmp(name, 'NG-7')

    Tree = load('NG-7_graph_signal_t1_t136.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 1;
    Tree.final_frame = 136;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % manually add missed node
    additional_div_node_names = {};
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:14) = 32;
    Tree.div_node_stage(15:44) = 64;
    Tree.div_node_stage(45:64) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'136_004', '136_006', '136_008', '136_009', '136_011', '136_012', ...
        '136_013', '136_014', '136_015', '136_018', '136_021', '136_028', '136_030', ...
        '136_032', '136_035', '136_044', '136_045', '136_049', '136_074', '136_411', ...
        '136_412'};

    % For plotting purposes
    Tree.final_EPI1_names = {};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, false);

elseif strcmp(name, 'NG-1 long')

    Tree = load('NG-1_graph_signal_t24_t240.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 24;
    Tree.final_frame = 240;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % add missed node
    additional_div_node_names = {'024_008'};
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:3) = 16;
    Tree.div_node_stage(4:19) = 32;
    Tree.div_node_stage(20:51) = 64;
    Tree.div_node_stage(52:101) = 128;
    Tree.div_node_stage([98,101]) = 256;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'240_732', '240_023', '240_032', '240_040', '240_065', '240_731', ...
        '240_736', '240_017', '240_084', '240_703', '240_705', '240_707', '240_708', ...
        '240_008', '240_087', '240_702', '240_709', '240_010', '240_013', '240_035', ...
        '240_039', '240_053', '240_699', '240_064', '240_700', '240_706'};

    Tree.final_ICM_fates = {'PE', 'PE', 'EPI-1', 'PE', 'EPI-2', 'PE', 'PE', ...
        'PE', 'EPI-2', 'EPI-2', 'PE', 'EPI-2', 'EPI-1', 'PE', 'EPI-1', ...
        'EPI-2', 'EPI-2', 'PE', 'PE', 'EPI-1', 'PE', 'PE', 'PE', ...
        'EPI-1', 'EPI-2', 'EPI-1'};

    Tree.dead_node_names = {'161_015', '181_067', '189_075', '193_077', '194_077', '196_013', ...
        '197_082', '199_035', '199_084', '201_087', '203_064', '210_090', '214_411', ...
        '215_423', '218_058', '228_018', '229_010', '229_036', '232_105', '233_006', ...
        '235_095', '235_107'};
    Tree.dead_node_fates = {'ICM', 'ICM', 'ICM', 'ICM', 'TE', 'ICM', 'ICM', ...
        'ICM', 'ICM', 'ICM', 'ICM', 'TE', 'ICM', 'ICM', 'TE', ...
        'TE', 'TE', 'ICM', 'TE', 'TE', 'ICM', 'ICM'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, false);

elseif strcmp(name, 'NG-2 long')

    Tree = load('NG-2_graph_signal_t1_t202.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 1;
    Tree.final_frame = 202;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:8) = 16;
    Tree.div_node_stage([9:21, 33:35]) = 32;
    Tree.div_node_stage([22:32, 36:55]) = 64;
    Tree.div_node_stage(56:65) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'202_402', '202_374', '202_357', '202_381', '202_385', '202_355', ...
        '202_356', '202_360', '202_393', '202_363', '202_367', '202_358', '202_361', ...
        '202_376', '202_366', '202_375', '202_373', '202_387', '202_394'};

    Tree.final_ICM_fates = {'PE', 'PE', 'PE', 'EPI-2', 'EPI-2', 'PE', 'EPI-1', ...
        'EPI-1', 'EPI-1', 'DP', 'PE', 'EPI-2', 'EPI-2', 'EPI-1', 'EPI-1', ...
        'EPI-1', 'EPI-1', 'PE', 'EPI-2'};

    Tree.dead_node_names = {'184_320', '184_364', '192_649', '196_135', '200_298', '200_309', ...
        '200_315'};
    Tree.dead_node_fates = {'TE', 'TE', 'TE', 'ICM', 'ICM', 'ICM', 'ICM'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, false);

elseif strcmp(name, 'NGS-1')

    Tree = load('NGS-1_graph_signal_t16_t160.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 16;
    Tree.final_frame = 160;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % add missed node
    additional_div_node_names = {'016_002'};
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1) = 16;
    Tree.div_node_stage(2:17) = 32;
    Tree.div_node_stage(18:67) = 64;
    Tree.div_node_stage([44:45, 47:53, 56:65]) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'160_011', '160_014', '160_017', '160_018', '160_022', '160_029', ...
        '160_030', '160_038', '160_042', '160_044', '160_050', '160_051', '160_054', ...
        '160_056', '160_057', '160_061', '160_066', '160_069', '160_070', '160_072', ...
        '160_340', '160_341', '160_342', '160_343', '160_344', '160_345', '160_346', ...
        '160_349', '160_350', '160_763'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, true);

elseif strcmp(name, 'NGS-2')

    Tree = load('NGS-2_graph_signal_t60_t148.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 60;
    Tree.final_frame = 148;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % add missed node
    additional_div_node_names = {};
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:16) = 32;
    Tree.div_node_stage(17:48) = 64;
    Tree.div_node_stage(49:50) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'148_008', '148_010', '148_012', '148_014', '148_015', '148_017', ...
        '148_018', '148_019', '148_021', '148_023', '148_024', '148_028', '148_030', ...
        '148_040', '148_041', '148_042', '148_043', '148_047', '148_051', '148_052', ...
        '148_057', '148_059', '148_110', '148_112', '148_113', '148_114', '148_116', ...
        '148_118', '148_164', '148_165', '148_264', '148_265'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, true);

elseif strcmp(name, 'NGS-3')

    Tree = load('NGS-3_graph_signal_t20_t112.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 20;
    Tree.final_frame = 112;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % add missed node
    additional_div_node_names = {};
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:16) = 32;
    Tree.div_node_stage([17:47, 50]) = 64;
    Tree.div_node_stage([48,49,51:53]) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'112_005', '112_008', '112_010', '112_012', '112_013', '112_014', ...
        '112_015', '112_018', '112_020', '112_022', '112_023', '112_025', '112_028', ...
        '112_029', '112_030', '112_032', '112_033', '112_035', '112_039', '112_040', ...
        '112_044', '112_047', '112_048', '112_049', '112_055', '112_059', '112_295'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, true);

elseif strcmp(name, 'NGS-4')

    Tree = load('NGS-4_graph_signal_t40_t128.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 40;
    Tree.final_frame = 128;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % add missed node
    additional_div_node_names = {};
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:16) = 32;
    Tree.div_node_stage(17:end) = 64;
    Tree.div_node_stage(46) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'128_001', '128_007', '128_014', '128_018', '128_028', '128_029', ...
        '128_030', '128_031', '128_038', '128_040', '128_042', '128_044', '128_045', ...
        '128_046', '128_054', '128_123', '128_125', '128_220', '128_221', '128_222', ...
        '128_223', '128_225', '128_227', '128_228'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, true);

elseif strcmp(name, 'NGS-5')

    Tree = load('NGS-5_graph_signal_t32_t124.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 32;
    Tree.final_frame = 124;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % add missed node
    additional_div_node_names = {};
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:16) = 32;
    Tree.div_node_stage(17:49) = 64;
    Tree.div_node_stage(47) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'124_001', '124_010', '124_016', '124_018', '124_019', '124_020', ...
        '124_021', '124_024', '124_025', '124_029', '124_030', '124_031', '124_033', ...
        '124_034', '124_036', '124_043', '124_044', '124_046', '124_048', '124_051', ...
        '124_052', '124_054', '124_056', '124_057', '124_219', '124_221', '124_222', ...
        '124_223', '124_224', '124_226', '124_227'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, true);

elseif strcmp(name, 'MEKi-1')

    Tree = load('MEKi-1_graph_signal_t1_t124.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 1;
    Tree.final_frame = 124;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % add missed node
    additional_div_node_names = {};
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:14) = 32;
    Tree.div_node_stage(15:37) = 64;
    Tree.div_node_stage(38:45) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'124_002', '124_005', '124_007', '124_011', '124_022', '124_027', ...
        '124_031', '124_033', '124_034', '124_039', '124_040', '124_041', '124_046', ...
        '124_050', '124_051', '124_113', '124_114', '124_116', '124_117', '124_186'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, false);

elseif strcmp(name, 'MEKi-2')

    Tree = load('MEKi-2_graph_signal_t1_t104.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 1;
    Tree.final_frame = 104;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % add missed node
    additional_div_node_names = {};
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:16) = 32;
    Tree.div_node_stage(17:48) = 64;
    Tree.div_node_stage(49:50) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'104_004', '104_008', '104_009', '104_011', '104_015', '104_019', ...
        '104_020', '104_021', '104_022', '104_025', '104_028', '104_029', '104_030', ...
        '104_032', '104_035', '104_037', '104_038', '104_039', '104_040', '104_042', ...
        '104_053', '104_256', '104_257', '104_258', '104_298', '104_299'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, false);

elseif strcmp(name, 'MEKi-3')

    Tree = load('MEKi-3_graph_signal_t1_t120.mat');
    Tree.frame_to_hour = 1 / 4;
    Tree.first_frame = 1;
    Tree.final_frame = 120;
    Tree.frame_range = Tree.first_frame:Tree.final_frame;
    % Find division nodes
    Tree.div_node_ind = find(degree(Tree.G_based_on_nn) == 3);
    Tree.div_node_names = Tree.G_based_on_nn.Nodes.Name(Tree.div_node_ind);
    % add missed node
    additional_div_node_names = {};
    Tree.div_node_names = [additional_div_node_names(:); Tree.div_node_names];
    Tree.div_node_ind = [findnode(Tree.G_based_on_nn, additional_div_node_names); Tree.div_node_ind];
    % manually assign division stage
    Tree.div_node_stage = zeros(length(Tree.div_node_ind), 1);
    Tree.div_node_stage(1:16) = 32;
    Tree.div_node_stage(17:53) = 64;
    Tree.div_node_stage([48,49,51,52,53]) = 128;
    % get frame for each division
    Tree.div_node_frame = split(Tree.div_node_names, '_');
    Tree.div_node_frame = str2double(Tree.div_node_frame(:,1));

    Tree.final_ICM_names = {'120_002', '120_005', '120_006', '120_009', '120_010', '120_013', ...
        '120_014', '120_017', '120_019', '120_021', '120_022', '120_025', '120_026', ...
        '120_027', '120_028', '120_030', '120_032', '120_033', '120_037', '120_039', ...
        '120_040', '120_042', '120_055', '120_061', '120_066', '120_239', '120_247', ...
        '120_251'};

    Traces = compute_Traces(Tree, [], Tree.final_ICM_names, false);

else
    error("Embryo name '%s' not recognized. " + ...
          "Must be one of: \n" + ...
          "'NG-1 short'    'NG-1 long'    'NGS-1'    'MEKi-1'\n" + ...
          "'NG-2 short'    'NG-2 long'    'NGS-2'    'MEKi-2'\n" + ...
          "'NG-3'                         'NGS-3'    'MEKi-3'\n" + ...
          "'NG-4'                         'NGS-4'\n" + ...
          "'NG-5'                         'NGS-5'\n" + ...
          "'NG-6'\n" + ...
          "'NG-7'", name);
end

% Get the unique stages
[Tree.stages, ~, Tree.div_node_stage_ind] = unique(Tree.div_node_stage);
Tree.stage_frame_avg = accumarray(Tree.div_node_stage_ind, Tree.div_node_frame, ...
    size(Tree.stages), @mean);

% Convert stage frame average to time average
Tree.stage_time_avg = (Tree.stage_frame_avg - min(Tree.frame_range)) * Tree.frame_to_hour;
Tree.div_node_time = (Tree.div_node_frame - min(Tree.frame_range)) * Tree.frame_to_hour;

% add angle to G_based_on_nn
Tree.G_based_on_nn.Nodes.Angle = atan(Tree.G_based_on_nn.Nodes.Nanog_norm ./ ...
    (Tree.G_based_on_nn.Nodes.Gata6_norm + 1e-2));

% Convert frame range to time range
Tree.time_range = (Tree.frame_range - min(Tree.frame_range)) * Tree.frame_to_hour;

% Compute normalized time range based on avg time of 32 cell stage and avg
% time of 64 cell stage
Tree.normalized_time_range = (Tree.time_range - Tree.stage_time_avg(Tree.stages == 32)) ./ ...
    (Tree.stage_time_avg(Tree.stages == 64) - Tree.stage_time_avg(Tree.stages == 32));

end

