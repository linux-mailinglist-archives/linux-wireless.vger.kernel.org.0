Return-Path: <linux-wireless+bounces-3413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD61850489
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Feb 2024 14:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8A628257D
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Feb 2024 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CC953804;
	Sat, 10 Feb 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvpMwBVe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDE436117
	for <linux-wireless@vger.kernel.org>; Sat, 10 Feb 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707572665; cv=none; b=HHIbYd3GD4815n1cqp+lNb815eJiofIrMifvq1XJ0aI/3mLo+9YRRxV772CtWiplqMgnSwfFOsNITYzQD6CT/+GkE+LmefTZMFSBwmuyrOlVIeFhfCQSeFpQZeVTJhq+ZiHSBKvHpKLIThfr0WHkYbrdGF2olKYxX6Dt4jSzvUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707572665; c=relaxed/simple;
	bh=XcSECDNC/r1nXUOrjHhU0a6q6NoCWQRYvgQLh4gPj1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ro6iouXivfYP+G+s+qimxCqrfR1asNrKZO0+UkXsGVziwfHam9BAAng7cZYvj6tZDZ6qZ6Mk9PdW1oSyuWYgTHqAe3REl9DQlxH9J9cQO1SikOYDD9uZ0sUFON4ddmapEuEWj1MlA9iNl8o7lUKKFpu2y56I2wUOapDAsnN8Tvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvpMwBVe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707572663; x=1739108663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XcSECDNC/r1nXUOrjHhU0a6q6NoCWQRYvgQLh4gPj1g=;
  b=UvpMwBVed+1+W/aL6SAaKRlqEj3eJ9UoI+FiTD1B9ySbSEt2ltNJMmb2
   AvdxP44+Uj19bU4MzHnDjmdHcZ3JjS492WQu1Uqyi2XqBiONf6NdM6hl9
   B015KcEgzI2P9TwV+gjQg1GHS4ZvZxCeqgoRgpIC5PHsqe6e5t4kvexB1
   CKtiA+dJKc1Ee7zpW+/n3xjST1plzU7jchz6MU5hWN0DXZDS4lsAUyTXa
   Rd0DLTpfi+/lX6ti/npzreT352B2duSI1GMv/sNGgGcmbzzb2t987B1Nv
   NQXGXhFmyLBm0EA1PZbT/9a56ZhVNOEPtL6CJby180889MSVNHdjRUreY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1888238"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1888238"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 05:44:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="2150284"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Feb 2024 05:44:21 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYneU-0005gw-0i;
	Sat, 10 Feb 2024 13:44:18 +0000
Date: Sat, 10 Feb 2024 21:44:01 +0800
From: kernel test robot <lkp@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	johannes@sipsolutions.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: Re: [PATCH 01/13] wifi: iwlwifi: nvm: parse the VLP/AFC bit from
 regulatory
Message-ID: <202402102159.h0x3mL2v-lkp@intel.com>
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
[also build test ERROR on wireless/main linus/master v6.8-rc3 next-20240209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miri-Korenblit/wifi-iwlwifi-nvm-parse-the-VLP-AFC-bit-from-regulatory/20240209-010143
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240208185302.9c6a4acabdb3.I501de5c0d86b9702bf61158a2e91c954a1da9a2a%40changeid
patch subject: [PATCH 01/13] wifi: iwlwifi: nvm: parse the VLP/AFC bit from regulatory
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20240210/202402102159.h0x3mL2v-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7dd790db8b77c4a833c06632e903dc4f13877a64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240210/202402102159.h0x3mL2v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402102159.h0x3mL2v-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:377:12: error: use of undeclared identifier 'IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT'; did you mean 'IEEE80211_CHAN_NO_UHB_VLP_CLIENT'?
     377 |                 flags |= IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT;
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                          IEEE80211_CHAN_NO_UHB_VLP_CLIENT
   include/net/cfg80211.h:149:2: note: 'IEEE80211_CHAN_NO_UHB_VLP_CLIENT' declared here
     149 |         IEEE80211_CHAN_NO_UHB_VLP_CLIENT= 1<<22,
         |         ^
>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:379:12: error: use of undeclared identifier 'IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT'; did you mean 'IEEE80211_CHAN_NO_UHB_AFC_CLIENT'?
     379 |                 flags |= IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT;
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                          IEEE80211_CHAN_NO_UHB_AFC_CLIENT
   include/net/cfg80211.h:150:2: note: 'IEEE80211_CHAN_NO_UHB_AFC_CLIENT' declared here
     150 |         IEEE80211_CHAN_NO_UHB_AFC_CLIENT= 1<<23,
         |         ^
>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:1665:13: error: use of undeclared identifier 'NL80211_RRF_NO_6GHZ_VLP_CLIENT'; did you mean 'NL80211_RRF_NO_UHB_VLP_CLIENT'?
    1665 |                         flags |= NL80211_RRF_NO_6GHZ_VLP_CLIENT;
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                  NL80211_RRF_NO_UHB_VLP_CLIENT
   include/uapi/linux/nl80211.h:4543:2: note: 'NL80211_RRF_NO_UHB_VLP_CLIENT' declared here
    4543 |         NL80211_RRF_NO_UHB_VLP_CLIENT   = 1<<22,
         |         ^
>> drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c:1668:13: error: use of undeclared identifier 'NL80211_RRF_NO_6GHZ_AFC_CLIENT'; did you mean 'NL80211_RRF_NO_UHB_AFC_CLIENT'?
    1668 |                         flags |= NL80211_RRF_NO_6GHZ_AFC_CLIENT;
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                  NL80211_RRF_NO_UHB_AFC_CLIENT
   include/uapi/linux/nl80211.h:4544:2: note: 'NL80211_RRF_NO_UHB_AFC_CLIENT' declared here
    4544 |         NL80211_RRF_NO_UHB_AFC_CLIENT   = 1<<23,
         |         ^
   4 errors generated.


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

