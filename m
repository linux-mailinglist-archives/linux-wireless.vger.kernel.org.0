Return-Path: <linux-wireless+bounces-1120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E57C81A777
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 21:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAAAF1F23BE3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 20:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA76E48CC9;
	Wed, 20 Dec 2023 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikFmhRbs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D048CCA
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703102616; x=1734638616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dSrI6PiNH8+PjAoKRADh74C4SR8bFbXDzLlhwsDQTd4=;
  b=ikFmhRbsL1OVJ2yCFF8p9zhDI4eyjuX7Cy38b+1UHVBJWhCoJdYURXwG
   AoFNmOapyMppHa9MSQQOCKoxLDE7mzpRPU+jChYjk+hlDtazvVzrzHBG6
   By1bZcDp0m9IiPXcfRygvE65w0w2SFOEiUk7+4eHTBgffkGAl5+IZN7Kf
   ttpNsnkH8ZvoX+cyA1ZwR0JNt7+HgTW8NvvhtRqaZAueUWsEghz3eFOFH
   JCgfA+0KPl0x2ztWyCQtyJeh5QtBY1JgiW4M7+jsl+TB7FG7+G+Wo4/wT
   HDkd6Wgu/0sxtJSiVcMGM5GPoPDE9Vh/Iw/PYDrji3GybHT2DFHVHPSWd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="398648268"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="398648268"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 12:03:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="769700136"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="769700136"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Dec 2023 12:03:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rG2mv-0007Qv-1c;
	Wed, 20 Dec 2023 20:03:29 +0000
Date: Thu, 21 Dec 2023 04:02:31 +0800
From: kernel test robot <lkp@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	johannes@sipsolutions.net
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: Re: [PATCH 02/14] wifi: iwlwifi: mvm: Allow DFS concurrent operation
Message-ID: <202312210343.J7eedmDf-lkp@intel.com>
References: <20231219215605.dc39b33bf507.I04dfda24d73091fb75701279d10ac400314de488@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219215605.dc39b33bf507.I04dfda24d73091fb75701279d10ac400314de488@changeid>

Hi Miri,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.7-rc6 next-20231220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miri-Korenblit/iwlwifi-mvm-set-siso-mimo-chains-to-1-in-FW-SMPS-request/20231220-040247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20231219215605.dc39b33bf507.I04dfda24d73091fb75701279d10ac400314de488%40changeid
patch subject: [PATCH 02/14] wifi: iwlwifi: mvm: Allow DFS concurrent operation
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20231221/202312210343.J7eedmDf-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231221/202312210343.J7eedmDf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312210343.J7eedmDf-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c: In function 'iwl_nvm_get_regdom_bw_flags':
>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:1616:34: error: 'NL80211_RRF_DFS_CONCURRENT' undeclared (first use in this function); did you mean 'NL80211_RRF_IR_CONCURRENT'?
    1616 |                         flags |= NL80211_RRF_DFS_CONCURRENT;
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                  NL80211_RRF_IR_CONCURRENT
   drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:1616:34: note: each undeclared identifier is reported only once for each function it appears in
--
   drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c: In function 'iwl_mvm_mac_setup_register':
>> drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:522:39: error: 'NL80211_EXT_FEATURE_DFS_CONCURRENT' undeclared (first use in this function); did you mean 'NL80211_EXT_FEATURE_BSS_COLOR'?
     522 |                                       NL80211_EXT_FEATURE_DFS_CONCURRENT);
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                       NL80211_EXT_FEATURE_BSS_COLOR
   drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:522:39: note: each undeclared identifier is reported only once for each function it appears in


vim +1616 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c

  1574	
  1575	static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
  1576					       int ch_idx, u16 nvm_flags,
  1577					       struct iwl_reg_capa reg_capa,
  1578					       const struct iwl_cfg *cfg)
  1579	{
  1580		u32 flags = NL80211_RRF_NO_HT40;
  1581	
  1582		if (ch_idx < NUM_2GHZ_CHANNELS &&
  1583		    (nvm_flags & NVM_CHANNEL_40MHZ)) {
  1584			if (nvm_chan[ch_idx] <= LAST_2GHZ_HT_PLUS)
  1585				flags &= ~NL80211_RRF_NO_HT40PLUS;
  1586			if (nvm_chan[ch_idx] >= FIRST_2GHZ_HT_MINUS)
  1587				flags &= ~NL80211_RRF_NO_HT40MINUS;
  1588		} else if (nvm_flags & NVM_CHANNEL_40MHZ) {
  1589			if ((ch_idx - NUM_2GHZ_CHANNELS) % 2 == 0)
  1590				flags &= ~NL80211_RRF_NO_HT40PLUS;
  1591			else
  1592				flags &= ~NL80211_RRF_NO_HT40MINUS;
  1593		}
  1594	
  1595		if (!(nvm_flags & NVM_CHANNEL_80MHZ))
  1596			flags |= NL80211_RRF_NO_80MHZ;
  1597		if (!(nvm_flags & NVM_CHANNEL_160MHZ))
  1598			flags |= NL80211_RRF_NO_160MHZ;
  1599	
  1600		if (!(nvm_flags & NVM_CHANNEL_ACTIVE))
  1601			flags |= NL80211_RRF_NO_IR;
  1602	
  1603		if (nvm_flags & NVM_CHANNEL_RADAR)
  1604			flags |= NL80211_RRF_DFS;
  1605	
  1606		if (nvm_flags & NVM_CHANNEL_INDOOR_ONLY)
  1607			flags |= NL80211_RRF_NO_OUTDOOR;
  1608	
  1609		/* Set the GO concurrent flag only in case that NO_IR is set.
  1610		 * Otherwise it is meaningless
  1611		 */
  1612		if ((nvm_flags & NVM_CHANNEL_GO_CONCURRENT)) {
  1613			if (flags & NL80211_RRF_NO_IR)
  1614				flags |= NL80211_RRF_GO_CONCURRENT;
  1615			if (flags & NL80211_RRF_DFS)
> 1616				flags |= NL80211_RRF_DFS_CONCURRENT;
  1617		}
  1618		/*
  1619		 * reg_capa is per regulatory domain so apply it for every channel
  1620		 */
  1621		if (ch_idx >= NUM_2GHZ_CHANNELS) {
  1622			if (!reg_capa.allow_40mhz)
  1623				flags |= NL80211_RRF_NO_HT40;
  1624	
  1625			if (!reg_capa.allow_80mhz)
  1626				flags |= NL80211_RRF_NO_80MHZ;
  1627	
  1628			if (!reg_capa.allow_160mhz)
  1629				flags |= NL80211_RRF_NO_160MHZ;
  1630	
  1631			if (!reg_capa.allow_320mhz)
  1632				flags |= NL80211_RRF_NO_320MHZ;
  1633		}
  1634	
  1635		if (reg_capa.disable_11ax)
  1636			flags |= NL80211_RRF_NO_HE;
  1637	
  1638		if (reg_capa.disable_11be)
  1639			flags |= NL80211_RRF_NO_EHT;
  1640	
  1641		return flags;
  1642	}
  1643	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

