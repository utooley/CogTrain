%-----------------------------------------------------------------------
% Job saved on 18-Oct-2016 15:02:58 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6685)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.util.imcalc.input = {'/Users/utooley/Documents/Kable Lab/CogTrain/FunImgData/gray_matter_mask_8_2014/rgray_matter_mask1.nii,1'};
matlabbatch{1}.spm.util.imcalc.output = '4rgray_matter_mask_binary';
matlabbatch{1}.spm.util.imcalc.outdir = {'/Users/utooley/Documents/Kable Lab/CogTrain/FunImgData/gray_matter_mask_8_2014'};
matlabbatch{1}.spm.util.imcalc.expression = 'i1>.4';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 16;
