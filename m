Return-Path: <linux-wireless+bounces-30312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5063CF02D0
	for <lists+linux-wireless@lfdr.de>; Sat, 03 Jan 2026 17:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AA25300C291
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Jan 2026 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67D52F6598;
	Sat,  3 Jan 2026 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8+e/kJb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C252D1F5E
	for <linux-wireless@vger.kernel.org>; Sat,  3 Jan 2026 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767457702; cv=none; b=jePeWaXItpB3XmlSbRcFkosCQYKRU64430RTprR0vm2K5acuMK22E8RFZsYj5Ndm5IBCdjQRfXvSj0bns8dPG0+7gzhQPNRu7SVBVzTh2aKKA/PVsA/oc3c8pEAXWLOZ5zI6btLxaK8Cyj9dmsdVJPxysYiwqPzp+YRwZDCvHoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767457702; c=relaxed/simple;
	bh=UGnURp+PHWkUGyQ6O3VUg3NstazSRDcOt3/JvIZ+8/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIexwWAyxCSt9PfVddzm0UCmCZhaKKdSVd2dtzo0lF3M0uvRjL3qt0UvM+sQZsOzhKTtupzrv9tDl6M6Jj9YIRuDr1aHaofdMs5ZxSwFipyvAw/D+3aDXEiGo8+oEf7+2zSCIZH7ZtfErnU/uRn0TZRntQ4/w1crtn/T1v4flrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8+e/kJb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767457701; x=1798993701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UGnURp+PHWkUGyQ6O3VUg3NstazSRDcOt3/JvIZ+8/w=;
  b=I8+e/kJb/sGMJ9dNA5aKCOlWFF1QwONPlMlTHYzDUGiPkqmjnvCZYXQY
   5sMC8DSNkTUYSfz051ips3RwBY/QA9UujdmkSS8icNoeHLvs6zL9HifBl
   x5cA6InM+0XC8iA5SRxnxym4R1Iu2BntB76+9efbQKUC3OPz5Q525QycP
   gB+BT/CTgK1JCTAoMZ1c9MRN6VJgqLw84xc3a+kC4QmcNxwGgFq3+NB19
   zxHZ5lMjPxowpUbNknu5VfiELmuqNKpMzi+qrSNeOPKeTV/dJRmAYlGe4
   1dtCfPJl1Va0wEIwAQuro9CE502VodpJhn+jqttZiORceZch+V1VN4K7r
   w==;
X-CSE-ConnectionGUID: dq9wMbGESNONv+TtWU2Zfw==
X-CSE-MsgGUID: inrIS4hQTYK9UT/jGc6HWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="68643487"
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="68643487"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 08:28:21 -0800
X-CSE-ConnectionGUID: T0UqbDnDTFCqs1tfrM98mg==
X-CSE-MsgGUID: 9xvwQAwkSu2P6x4qaG6ycQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="206905351"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jan 2026 08:28:19 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vc4UD-000000000jF-1gZ9;
	Sat, 03 Jan 2026 16:28:17 +0000
Date: Sat, 3 Jan 2026 17:28:11 +0100
From: kernel test robot <lkp@intel.com>
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH rtw-next 09/10] wifi: rtw89: fw: consider hardware AID
 for firmware elements
Message-ID: <202601031731.PNwSACm3-lkp@intel.com>
References: <20260102070840.62047-10-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102070840.62047-10-pkshih@realtek.com>

Hi Ping-Ke,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.19-rc3 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Ke-Shih/wifi-rtw89-update-TXWD-v3-for-RTL8922D/20260102-152315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260102070840.62047-10-pkshih%40realtek.com
patch subject: [PATCH rtw-next 09/10] wifi: rtw89: fw: consider hardware AID for firmware elements
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260103/202601031731.PNwSACm3-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260103/202601031731.PNwSACm3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601031731.PNwSACm3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/realtek/rtw89/fw.c:11:
   drivers/net/wireless/realtek/rtw89/mac.h: In function 'rtw89_mac_chk_preload_allow':
   drivers/net/wireless/realtek/rtw89/mac.h:1728:61: error: 'struct rtw89_hal' has no member named 'cid'
    1728 |         if (rtwdev->chip->chip_id == RTL8922D && rtwdev->hal.cid == RTL8922D_CID7090)
         |                                                             ^
   drivers/net/wireless/realtek/rtw89/mac.h:1728:69: error: 'RTL8922D_CID7090' undeclared (first use in this function)
    1728 |         if (rtwdev->chip->chip_id == RTL8922D && rtwdev->hal.cid == RTL8922D_CID7090)
         |                                                                     ^~~~~~~~~~~~~~~~
   drivers/net/wireless/realtek/rtw89/mac.h:1728:69: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/wireless/realtek/rtw89/fw.c: In function 'rtw89_build_phy_tbl_from_elm':
>> drivers/net/wireless/realtek/rtw89/fw.c:1048:30: error: 'struct rtw89_hal' has no member named 'aid'
    1048 |         if (aid && aid != hal->aid)
         |                              ^~


vim +1048 drivers/net/wireless/realtek/rtw89/fw.c

  1009	
  1010	static
  1011	int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
  1012					 const struct rtw89_fw_element_hdr *elm,
  1013					 const union rtw89_fw_element_arg arg)
  1014	{
  1015		struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
  1016		struct rtw89_hal *hal = &rtwdev->hal;
  1017		struct rtw89_phy_table *tbl, **pp;
  1018		struct rtw89_reg2_def *regs;
  1019		bool radio = false;
  1020		u32 n_regs, i;
  1021		u16 aid;
  1022		u8 idx;
  1023	
  1024		switch (le32_to_cpu(elm->id)) {
  1025		case RTW89_FW_ELEMENT_ID_BB_REG:
  1026			pp = &elm_info->bb_tbl;
  1027			break;
  1028		case RTW89_FW_ELEMENT_ID_BB_GAIN:
  1029			pp = &elm_info->bb_gain;
  1030			break;
  1031		case RTW89_FW_ELEMENT_ID_RADIO_A:
  1032		case RTW89_FW_ELEMENT_ID_RADIO_B:
  1033		case RTW89_FW_ELEMENT_ID_RADIO_C:
  1034		case RTW89_FW_ELEMENT_ID_RADIO_D:
  1035			idx = elm->u.reg2.idx;
  1036			pp = &elm_info->rf_radio[idx];
  1037	
  1038			radio = true;
  1039			break;
  1040		case RTW89_FW_ELEMENT_ID_RF_NCTL:
  1041			pp = &elm_info->rf_nctl;
  1042			break;
  1043		default:
  1044			return -ENOENT;
  1045		}
  1046	
  1047		aid = le16_to_cpu(elm->aid);
> 1048		if (aid && aid != hal->aid)
  1049			return 1; /* ignore if aid not matched */
  1050		else if (*pp)
  1051			return 1; /* ignore if an element is existing */
  1052	
  1053		tbl = kzalloc(sizeof(*tbl), GFP_KERNEL);
  1054		if (!tbl)
  1055			return -ENOMEM;
  1056	
  1057		n_regs = le32_to_cpu(elm->size) / sizeof(tbl->regs[0]);
  1058		regs = kcalloc(n_regs, sizeof(*regs), GFP_KERNEL);
  1059		if (!regs)
  1060			goto out;
  1061	
  1062		for (i = 0; i < n_regs; i++) {
  1063			regs[i].addr = le32_to_cpu(elm->u.reg2.regs[i].addr);
  1064			regs[i].data = le32_to_cpu(elm->u.reg2.regs[i].data);
  1065		}
  1066	
  1067		tbl->n_regs = n_regs;
  1068		tbl->regs = regs;
  1069	
  1070		if (radio) {
  1071			tbl->rf_path = arg.rf_path;
  1072			tbl->config = rtw89_phy_config_rf_reg_v1;
  1073		}
  1074	
  1075		*pp = tbl;
  1076	
  1077		return 0;
  1078	
  1079	out:
  1080		kfree(tbl);
  1081		return -ENOMEM;
  1082	}
  1083	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

