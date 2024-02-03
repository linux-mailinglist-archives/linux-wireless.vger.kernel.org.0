Return-Path: <linux-wireless+bounces-3085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E0884887E
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 20:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108A7284B31
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 19:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD805D752;
	Sat,  3 Feb 2024 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPnKdibd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A65EE83
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706988205; cv=none; b=ByShCdQibc1KSvWJXtGPiRgbVAiXv84kp9u49tfDCVjbdNupVLco152ulJsGhlYi8NFQLoZqTM4/KaY81xCdJNiJLbW+hg11EadGq0OyG948IuCmQB8lscl8pP3E39CT2wcjXnZ+mLj4mZRYidHNnLr5hV125ZtRkTiHfDSUCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706988205; c=relaxed/simple;
	bh=5EgyfyRfK+QZ19JXQQL2e7cwpGmmODjN5eYattX0DsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPcNZlmuqaNszf0E9ToMcoIcUFRqW0ONi41DcdcGL3ZZOYeM/tuAqNcCUBjrjzthrl5+Q6qFOWazqpw4/1Agr6c0Lm22eLyxbMo9e6xWrsbqOmIT0W/ufmiq9h5SojUu7K7FGuaRM8RkrwsDljdLncC7JJ4daaU6Jk4Wl5tfYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPnKdibd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706988203; x=1738524203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5EgyfyRfK+QZ19JXQQL2e7cwpGmmODjN5eYattX0DsA=;
  b=OPnKdibdOzwwzVGU5fnE6h2HcY8fPA+mcclB4QALDTPP5MWbF5CZxvBo
   c6saM5j5naWK4UNOJ3ZBe7JATBdEA6UbbXCiZVAewD44a4n71SyeOFWM5
   +ptUiHXIPekbosF8N/eYA0k2eBPACl7kVHfCw4v4rBZIm961BYz4luyeI
   OrXbZI6wr4B1Y9m9asJyqkTuIOmLygapfB8w30qJbgFDHrmblZPvHsL3z
   wFCs5hEfMInjQZ/UhiHZ7dIFomlsP+QFPM0G5cbgFbJiSOmwJ4Bii1Gzb
   LK7SZ90GjTnc/Y/undzgmeB4VkpcfNFKuqFFYYCgjdusSiszpA3C3445p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="17749262"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="17749262"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 11:23:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="31150817"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 03 Feb 2024 11:23:22 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWLbj-0005Vi-0I;
	Sat, 03 Feb 2024 19:23:19 +0000
Date: Sun, 4 Feb 2024 03:22:49 +0800
From: kernel test robot <lkp@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/4] wifi: rtw89: fw: parse secure section from firmware
 file
Message-ID: <202402040350.rRpOepoU-lkp@intel.com>
References: <20240203003251.10641-4-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203003251.10641-4-pkshih@realtek.com>

Hi Ping-Ke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-fw-consider-checksum-length-of-security-data/20240203-085038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240203003251.10641-4-pkshih%40realtek.com
patch subject: [PATCH 3/4] wifi: rtw89: fw: parse secure section from firmware file
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20240204/202402040350.rRpOepoU-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402040350.rRpOepoU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402040350.rRpOepoU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/realtek/rtw89/fw.c: In function 'rtw89_fw_hdr_parser_v1':
>> drivers/net/wireless/realtek/rtw89/fw.c:384:88: warning: format '%lx' expects argument of type 'long unsigned int', but argument 9 has type 'int' [-Wformat=]
     384 |                             "section[%d] type=%d len=0x%-6x mssc=%d mssc_len=%d addr=%lx\n",
         |                                                                                      ~~^
         |                                                                                        |
         |                                                                                        long unsigned int
         |                                                                                      %x
     385 |                             i, section_info->type, section_info->len,
     386 |                             section_info->mssc, mssc_len, bin - fw);
         |                                                           ~~~~~~~~                      
         |                                                               |
         |                                                               int
   drivers/net/wireless/realtek/rtw89/fw.c:388:68: warning: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'int' [-Wformat=]
     388 |                             "           ignore=%d key_addr=%p (0x%lx) key_len=%d key_idx=%d\n",
         |                                                                  ~~^
         |                                                                    |
         |                                                                    long unsigned int
         |                                                                  %x
     389 |                             section_info->ignore, section_info->key_addr,
     390 |                             section_info->key_addr ?
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~                
     391 |                             section_info->key_addr - section_info->addr : 0,
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                                         |
         |                                                                         int


vim +384 drivers/net/wireless/realtek/rtw89/fw.c

   322	
   323	static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
   324					  struct rtw89_fw_bin_info *info)
   325	{
   326		const struct rtw89_fw_hdr_v1 *fw_hdr = (const struct rtw89_fw_hdr_v1 *)fw;
   327		struct rtw89_fw_hdr_section_info *section_info;
   328		const struct rtw89_fw_dynhdr_hdr *fwdynhdr;
   329		const struct rtw89_fw_hdr_section_v1 *section;
   330		const u8 *fw_end = fw + len;
   331		const u8 *bin;
   332		u32 base_hdr_len;
   333		u32 mssc_len;
   334		int ret;
   335		u32 i;
   336	
   337		info->section_num = le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_SEC_NUM);
   338		info->dsp_checksum = le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_DSP_CHKSUM);
   339		base_hdr_len = struct_size(fw_hdr, sections, info->section_num);
   340		info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_DYN_HDR);
   341	
   342		if (info->dynamic_hdr_en) {
   343			info->hdr_len = le32_get_bits(fw_hdr->w5, FW_HDR_V1_W5_HDR_SIZE);
   344			info->dynamic_hdr_len = info->hdr_len - base_hdr_len;
   345			fwdynhdr = (const struct rtw89_fw_dynhdr_hdr *)(fw + base_hdr_len);
   346			if (le32_to_cpu(fwdynhdr->hdr_len) != info->dynamic_hdr_len) {
   347				rtw89_err(rtwdev, "[ERR]invalid fw dynamic header len\n");
   348				return -EINVAL;
   349			}
   350		} else {
   351			info->hdr_len = base_hdr_len;
   352			info->dynamic_hdr_len = 0;
   353		}
   354	
   355		bin = fw + info->hdr_len;
   356	
   357		/* jump to section header */
   358		section_info = info->section_info;
   359		for (i = 0; i < info->section_num; i++) {
   360			section = &fw_hdr->sections[i];
   361	
   362			section_info->type =
   363				le32_get_bits(section->w1, FWSECTION_HDR_V1_W1_SECTIONTYPE);
   364			section_info->len =
   365				le32_get_bits(section->w1, FWSECTION_HDR_V1_W1_SEC_SIZE);
   366			if (le32_get_bits(section->w1, FWSECTION_HDR_V1_W1_CHECKSUM))
   367				section_info->len += FWDL_SECTION_CHKSUM_LEN;
   368			section_info->redl = le32_get_bits(section->w1, FWSECTION_HDR_V1_W1_REDL);
   369			section_info->dladdr =
   370				le32_get_bits(section->w0, FWSECTION_HDR_V1_W0_DL_ADDR);
   371			section_info->addr = bin;
   372	
   373			if (section_info->type == FWDL_SECURITY_SECTION_TYPE) {
   374				ret = __parse_security_section(rtwdev, info, section_info,
   375							       section, bin, &mssc_len);
   376				if (ret)
   377					return ret;
   378			} else {
   379				section_info->mssc = 0;
   380				mssc_len = 0;
   381			}
   382	
   383			rtw89_debug(rtwdev, RTW89_DBG_FW,
 > 384				    "section[%d] type=%d len=0x%-6x mssc=%d mssc_len=%d addr=%lx\n",
   385				    i, section_info->type, section_info->len,
   386				    section_info->mssc, mssc_len, bin - fw);
   387			rtw89_debug(rtwdev, RTW89_DBG_FW,
   388				    "           ignore=%d key_addr=%p (0x%lx) key_len=%d key_idx=%d\n",
   389				    section_info->ignore, section_info->key_addr,
   390				    section_info->key_addr ?
   391				    section_info->key_addr - section_info->addr : 0,
   392				    section_info->key_len, section_info->key_idx);
   393	
   394			bin += section_info->len + mssc_len;
   395			section_info++;
   396		}
   397	
   398		if (fw_end != bin) {
   399			rtw89_err(rtwdev, "[ERR]fw bin size\n");
   400			return -EINVAL;
   401		}
   402	
   403		if (!info->secure_section_exist)
   404			rtw89_warn(rtwdev, "no firmware secure section\n");
   405	
   406		return 0;
   407	}
   408	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

