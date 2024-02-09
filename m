Return-Path: <linux-wireless+bounces-3368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A52384EF73
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 04:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5097E2885C6
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 03:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70EA5394;
	Fri,  9 Feb 2024 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ck5jWAwm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA45227
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 03:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707450017; cv=none; b=mn2tQD51GjFfgVXNNuXVwnhmuEOg/ED8rUSiS0FanFXBXJ6M/xtVhs52PbmknkkSRGIzpXxP+dU63vH0v9ilF6/TyCqFuZ90tdWQE9v0y6omQwdYUjSyz0iVTpD23sMUr10Ht6ggi+ToFb2Wl0o0XGJ8m7UjmcBxiGOKTEcOqO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707450017; c=relaxed/simple;
	bh=ASozSrvCvF55GwSIvfdk4c2eqvLWnOra+bD2x0j7h+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muIuCOzOVUEpRwosLWg3iWWKixvUok7tyvQraMxMqtw+uosfEmQkxE714mhC7aDE/3BdaOQPaOyvK612S0/ntBCMcbdxzvyC0Td3zTjERxgDaOxNTK+JPRWGWCTSLxg6nh/7oyKjjPoqOWHHXvXqHLL+I/k3IGUHVNbvr1QjB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ck5jWAwm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707450016; x=1738986016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ASozSrvCvF55GwSIvfdk4c2eqvLWnOra+bD2x0j7h+s=;
  b=ck5jWAwmeB/pvKKI1Mw4aX6lwIYtBRaZyTanPWg1DpfWXRw8k6Ie2dAS
   tZTKH1s2ZCtJSrD7v9gb0DhczD6VImE6WQDLEMMuggABnbIiaYURAE+en
   cZlGjZo0uyUwUpsIvYGzaG1uXC524vvwNgELiWuOo8Wdn4iaLdv2WX8hr
   u7YVqBxC+HVmwxagLU5Ta/r66Ai7r6EKY4xv0GLvkZQADz3Nm2vVgl+nO
   RRxpgHIE/+SNbHwpS1L1IrEUKyTMU6W4F0oLDZYPXwhMjKLRRyEhehDq4
   H0LXChLzb1YxdtvuDbBkye9AFGHgku8BdPwllQPiPB143un+5FjYZp/TX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="18780535"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="18780535"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:40:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1826910"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Feb 2024 19:40:13 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYHkH-0004Mc-3C;
	Fri, 09 Feb 2024 03:40:09 +0000
Date: Fri, 9 Feb 2024 11:40:04 +0800
From: kernel test robot <lkp@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	johannes@sipsolutions.net
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: Re: [PATCH 01/13] wifi: iwlwifi: nvm: parse the VLP/AFC bit from
 regulatory
Message-ID: <202402091145.eSxJkrSO-lkp@intel.com>
References: <20240208185302.9c6a4acabdb3.I501de5c0d86b9702bf61158a2e91c954a1da9a2a@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208185302.9c6a4acabdb3.I501de5c0d86b9702bf61158a2e91c954a1da9a2a@changeid>

Hi Miri,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.8-rc3 next-20240208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miri-Korenblit/wifi-iwlwifi-nvm-parse-the-VLP-AFC-bit-from-regulatory/20240209-010143
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240208185302.9c6a4acabdb3.I501de5c0d86b9702bf61158a2e91c954a1da9a2a%40changeid
patch subject: [PATCH 01/13] wifi: iwlwifi: nvm: parse the VLP/AFC bit from regulatory
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240209/202402091145.eSxJkrSO-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240209/202402091145.eSxJkrSO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402091145.eSxJkrSO-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c: In function 'iwl_get_channel_flags':
>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:377:26: error: 'IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT' undeclared (first use in this function); did you mean 'IEEE80211_CHAN_NO_UHB_VLP_CLIENT'?
     377 |                 flags |= IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT;
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                          IEEE80211_CHAN_NO_UHB_VLP_CLIENT
   drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:377:26: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:379:26: error: 'IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT' undeclared (first use in this function); did you mean 'IEEE80211_CHAN_NO_UHB_AFC_CLIENT'?
     379 |                 flags |= IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT;
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                          IEEE80211_CHAN_NO_UHB_AFC_CLIENT
   drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c: In function 'iwl_nvm_get_regdom_bw_flags':
>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:1665:34: error: 'NL80211_RRF_NO_6GHZ_VLP_CLIENT' undeclared (first use in this function); did you mean 'NL80211_RRF_NO_UHB_VLP_CLIENT'?
    1665 |                         flags |= NL80211_RRF_NO_6GHZ_VLP_CLIENT;
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                  NL80211_RRF_NO_UHB_VLP_CLIENT
>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:1668:34: error: 'NL80211_RRF_NO_6GHZ_AFC_CLIENT' undeclared (first use in this function); did you mean 'NL80211_RRF_NO_UHB_AFC_CLIENT'?
    1668 |                         flags |= NL80211_RRF_NO_6GHZ_AFC_CLIENT;
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                  NL80211_RRF_NO_UHB_AFC_CLIENT


vim +377 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c

   334	
   335	static u32 iwl_get_channel_flags(u8 ch_num, int ch_idx, enum nl80211_band band,
   336					 u32 nvm_flags, const struct iwl_cfg *cfg)
   337	{
   338		u32 flags = IEEE80211_CHAN_NO_HT40;
   339	
   340		if (band == NL80211_BAND_2GHZ && (nvm_flags & NVM_CHANNEL_40MHZ)) {
   341			if (ch_num <= LAST_2GHZ_HT_PLUS)
   342				flags &= ~IEEE80211_CHAN_NO_HT40PLUS;
   343			if (ch_num >= FIRST_2GHZ_HT_MINUS)
   344				flags &= ~IEEE80211_CHAN_NO_HT40MINUS;
   345		} else if (nvm_flags & NVM_CHANNEL_40MHZ) {
   346			if ((ch_idx - NUM_2GHZ_CHANNELS) % 2 == 0)
   347				flags &= ~IEEE80211_CHAN_NO_HT40PLUS;
   348			else
   349				flags &= ~IEEE80211_CHAN_NO_HT40MINUS;
   350		}
   351		if (!(nvm_flags & NVM_CHANNEL_80MHZ))
   352			flags |= IEEE80211_CHAN_NO_80MHZ;
   353		if (!(nvm_flags & NVM_CHANNEL_160MHZ))
   354			flags |= IEEE80211_CHAN_NO_160MHZ;
   355	
   356		if (!(nvm_flags & NVM_CHANNEL_IBSS))
   357			flags |= IEEE80211_CHAN_NO_IR;
   358	
   359		if (!(nvm_flags & NVM_CHANNEL_ACTIVE))
   360			flags |= IEEE80211_CHAN_NO_IR;
   361	
   362		if (nvm_flags & NVM_CHANNEL_RADAR)
   363			flags |= IEEE80211_CHAN_RADAR;
   364	
   365		if (nvm_flags & NVM_CHANNEL_INDOOR_ONLY)
   366			flags |= IEEE80211_CHAN_INDOOR_ONLY;
   367	
   368		/* Set the GO concurrent flag only in case that NO_IR is set.
   369		 * Otherwise it is meaningless
   370		 */
   371		if ((nvm_flags & NVM_CHANNEL_GO_CONCURRENT) &&
   372		    (flags & IEEE80211_CHAN_NO_IR))
   373			flags |= IEEE80211_CHAN_IR_CONCURRENT;
   374	
   375		/* Set the AP type for the UHB case. */
   376		if (!(nvm_flags & NVM_CHANNEL_VLP))
 > 377			flags |= IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT;
   378		if (!(nvm_flags & NVM_CHANNEL_AFC))
 > 379			flags |= IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT;
   380	
   381		return flags;
   382	}
   383	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

