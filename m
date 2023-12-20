Return-Path: <linux-wireless+bounces-1119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B0581A75F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 20:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749091C2295F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 19:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E913A4879E;
	Wed, 20 Dec 2023 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgNhzsQu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23AA482FC
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703101396; x=1734637396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q6/yZvKqtgOzMut48pOdIeoY9DKXbzZl6O/TMrpySoU=;
  b=FgNhzsQuF48PLs640eoWYP6tnN98ftSwIruJ6QHFM4U9rPtGkM1sC+Fk
   G9/aOVMu5mVOB4rTN+sReE+IOTcnb5nsMZ2iuk6k77GePiHdcXnpZcoLe
   prlwUvq5rLytnjnKnq1vXMzgbhTg2T8A4tmVC3HNNKZ+4wr9Q8XlopBYc
   BXZSwSZejvrNM+5O1XOt7Tjrm/iYcv+LeWFNZBrElHdkOQCPhcvu0M12g
   r1uDJlU+Thm8QE/Huj19RFg+BZNZ11agXMCroJQfhzC+wgj+niJV32Hwo
   x+7PpdAVQkCZVZ/Ih8whkf6G4Uc6je3+oFtuFp6J5os5HoHLO+0iKIEC/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="399698854"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="399698854"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 11:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="867078322"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="867078322"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2023 11:43:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rG2TG-0007Oz-1c;
	Wed, 20 Dec 2023 19:43:10 +0000
Date: Thu, 21 Dec 2023 03:42:12 +0800
From: kernel test robot <lkp@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	johannes@sipsolutions.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: Re: [PATCH 02/14] wifi: iwlwifi: mvm: Allow DFS concurrent operation
Message-ID: <202312210330.BRAWF2Tp-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231221/202312210330.BRAWF2Tp-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231221/202312210330.BRAWF2Tp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312210330.BRAWF2Tp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:1616:13: error: use of undeclared identifier 'NL80211_RRF_DFS_CONCURRENT'; did you mean 'NL80211_RRF_IR_CONCURRENT'?
                           flags |= NL80211_RRF_DFS_CONCURRENT;
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
                                    NL80211_RRF_IR_CONCURRENT
   include/uapi/linux/nl80211.h:4515:2: note: 'NL80211_RRF_IR_CONCURRENT' declared here
           NL80211_RRF_IR_CONCURRENT       = 1<<12,
           ^
   1 error generated.
--
>> drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:522:11: error: use of undeclared identifier 'NL80211_EXT_FEATURE_DFS_CONCURRENT'
                                         NL80211_EXT_FEATURE_DFS_CONCURRENT);
                                         ^
   1 error generated.


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

