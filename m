Return-Path: <linux-wireless+bounces-32327-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HLOcDm1dpGmKewUAu9opvQ
	(envelope-from <linux-wireless+bounces-32327-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Mar 2026 16:38:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 816AD1D073C
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Mar 2026 16:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E34E9300C021
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Mar 2026 15:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA92221723;
	Sun,  1 Mar 2026 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6DndQNW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EBA1C1F02
	for <linux-wireless@vger.kernel.org>; Sun,  1 Mar 2026 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772379497; cv=none; b=ZiYjFlb/zAJ4F3okQ3vEVn4yPu522XSvQxhTZ4/zwy4IUI/G0HYzoqshLacZm2UVmkkdXZUG2VP0Ju9c4+wKkFSC5xzIPyOAlIHKJ6ci+xTNvdry4gsJ08bDiDooYL6nMTK/rYEuCPTgmCQmjsAsyMANHPGie8KDpOFUpwuwvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772379497; c=relaxed/simple;
	bh=5kWOhH6WyXRzSs/ENEI8z+UhO27xhWoDVPpnPwULGNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+y1GlmNZaSyAb4aPb7QbvlkGzZueiUsK068nOpArlLJ0AZhrgs7p2GWCgCO1iZUPQxhrCEOIn29rcX0n2PuOwFdgTSwSexABYufTYSz/Qq6An0rWmwbjRTdyhxv6wZn7xCqoxJqztRWmew6B2W6zcIpA7vnLgnMRp3MtkgJWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6DndQNW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772379496; x=1803915496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5kWOhH6WyXRzSs/ENEI8z+UhO27xhWoDVPpnPwULGNE=;
  b=E6DndQNWxOIPhkz5G2uGKd/iAfqWaBAp1SDxFD16/trmqgjeralaggej
   ck1tHo9YkHFnQ/q3cobnahIHIEwIoRYQVLvFfWfHNPt6I7KgNTWXTr5KF
   iLoOSpvqNBOZwT8Co8Hoi7q4xf7rvABWUPNZDTMrpMHI6oaHllF7ERwsM
   8scD7muwkZrpQIMM+WYa3uZL5PzC8TeZtElY0fyHaUMcwswdtEIIl3LLj
   XbicutRDA6F6TSnwrDdaSorn/45ZZHQPSpNcr86t9zgXfEy0/Knc6/y2C
   P2ZOPhH9OES27ta1Uj0C7i/xlCf5n8Q8PnB3qt+qxodnXjMK+pROWbrYN
   A==;
X-CSE-ConnectionGUID: PBcChefYSxCNHjA0actGow==
X-CSE-MsgGUID: 3NJUrAn1T1yZwE1SyNBblw==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="83734351"
X-IronPort-AV: E=Sophos;i="6.21,318,1763452800"; 
   d="scan'208";a="83734351"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 07:38:16 -0800
X-CSE-ConnectionGUID: oYQ3XlsKQLueTXDk6MGRqQ==
X-CSE-MsgGUID: hX2/96pXQc2fe+R4BrAIRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,318,1763452800"; 
   d="scan'208";a="240403250"
Received: from lkp-server01.sh.intel.com (HELO 59784f1c7b2a) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 01 Mar 2026 07:38:14 -0800
Received: from kbuild by 59784f1c7b2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwis0-000000001XP-1fwA;
	Sun, 01 Mar 2026 15:38:12 +0000
Date: Sun, 1 Mar 2026 23:38:03 +0800
From: kernel test robot <lkp@intel.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH wireless-next] wifi: cfg80211: make cluster id an array
Message-ID: <202603012302.fG1YckJP-lkp@intel.com>
References: <20260301131848.b0085a6b4eb3.Ib16bf5cca55463d4c89e18099cf1dfe4de95d405@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301131848.b0085a6b4eb3.Ib16bf5cca55463d4c89e18099cf1dfe4de95d405@changeid>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-32327-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,01.org:url]
X-Rspamd-Queue-Id: 816AD1D073C
X-Rspamd-Action: no action

Hi Miri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on wireless/main linus/master v7.0-rc1 next-20260227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miri-Korenblit/wifi-cfg80211-make-cluster-id-an-array/20260301-192010
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260301131848.b0085a6b4eb3.Ib16bf5cca55463d4c89e18099cf1dfe4de95d405%40changeid
patch subject: [PATCH wireless-next] wifi: cfg80211: make cluster id an array
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260301/202603012302.fG1YckJP-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9a109fbb6e184ec9bcce10615949f598f4c974a9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260301/202603012302.fG1YckJP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603012302.fG1YckJP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/virtual/mac80211_hwsim.c:4081:12: warning: address of array 'conf->cluster_id' will always evaluate to 'true' [-Wpointer-bool-conversion]
    4081 |         if (conf->cluster_id && !is_zero_ether_addr(conf->cluster_id) &&
         |             ~~~~~~^~~~~~~~~~ ~~
   1 warning generated.


vim +4081 drivers/net/wireless/virtual/mac80211_hwsim.c

a37a6f54439bf8 Ilan Peer 2025-09-08  4052  
a37a6f54439bf8 Ilan Peer 2025-09-08  4053  static int mac80211_hwsim_start_nan(struct ieee80211_hw *hw,
a37a6f54439bf8 Ilan Peer 2025-09-08  4054  				    struct ieee80211_vif *vif,
a37a6f54439bf8 Ilan Peer 2025-09-08  4055  				    struct cfg80211_nan_conf *conf)
a37a6f54439bf8 Ilan Peer 2025-09-08  4056  {
a37a6f54439bf8 Ilan Peer 2025-09-08  4057  	struct mac80211_hwsim_data *data = hw->priv;
a37a6f54439bf8 Ilan Peer 2025-09-08  4058  	u64 tsf = mac80211_hwsim_get_tsf(hw, NULL);
a37a6f54439bf8 Ilan Peer 2025-09-08  4059  	u32 dw_int = 512 * 1000;
a37a6f54439bf8 Ilan Peer 2025-09-08  4060  	u64 until_dw = dw_int - do_div(tsf, dw_int);
a37a6f54439bf8 Ilan Peer 2025-09-08  4061  	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
a37a6f54439bf8 Ilan Peer 2025-09-08  4062  
a37a6f54439bf8 Ilan Peer 2025-09-08  4063  	if (vif->type != NL80211_IFTYPE_NAN)
a37a6f54439bf8 Ilan Peer 2025-09-08  4064  		return -EINVAL;
a37a6f54439bf8 Ilan Peer 2025-09-08  4065  
a37a6f54439bf8 Ilan Peer 2025-09-08  4066  	if (data->nan_device_vif)
a37a6f54439bf8 Ilan Peer 2025-09-08  4067  		return -EALREADY;
a37a6f54439bf8 Ilan Peer 2025-09-08  4068  
a37a6f54439bf8 Ilan Peer 2025-09-08  4069  	/* set this before starting the timer, as preemption might occur */
a37a6f54439bf8 Ilan Peer 2025-09-08  4070  	data->nan_device_vif = vif;
a37a6f54439bf8 Ilan Peer 2025-09-08  4071  	data->nan_bands = conf->bands;
a37a6f54439bf8 Ilan Peer 2025-09-08  4072  	data->nan_curr_dw_band = NL80211_BAND_2GHZ;
a37a6f54439bf8 Ilan Peer 2025-09-08  4073  
a37a6f54439bf8 Ilan Peer 2025-09-08  4074  	wiphy_debug(hw->wiphy, "nan_started, next_dw=%llu\n",
a37a6f54439bf8 Ilan Peer 2025-09-08  4075  		    until_dw);
a37a6f54439bf8 Ilan Peer 2025-09-08  4076  
a37a6f54439bf8 Ilan Peer 2025-09-08  4077  	hrtimer_start(&data->nan_timer,
a37a6f54439bf8 Ilan Peer 2025-09-08  4078  		      ns_to_ktime(until_dw * NSEC_PER_USEC),
a37a6f54439bf8 Ilan Peer 2025-09-08  4079  		      HRTIMER_MODE_REL_SOFT);
a37a6f54439bf8 Ilan Peer 2025-09-08  4080  
a37a6f54439bf8 Ilan Peer 2025-09-08 @4081  	if (conf->cluster_id && !is_zero_ether_addr(conf->cluster_id) &&
a37a6f54439bf8 Ilan Peer 2025-09-08  4082  	    is_zero_ether_addr(hwsim_nan_cluster_id)) {
a37a6f54439bf8 Ilan Peer 2025-09-08  4083  		memcpy(hwsim_nan_cluster_id, conf->cluster_id, ETH_ALEN);
a37a6f54439bf8 Ilan Peer 2025-09-08  4084  	} else if (is_zero_ether_addr(hwsim_nan_cluster_id)) {
a37a6f54439bf8 Ilan Peer 2025-09-08  4085  		hwsim_nan_cluster_id[0] = 0x50;
a37a6f54439bf8 Ilan Peer 2025-09-08  4086  		hwsim_nan_cluster_id[1] = 0x6f;
a37a6f54439bf8 Ilan Peer 2025-09-08  4087  		hwsim_nan_cluster_id[2] = 0x9a;
a37a6f54439bf8 Ilan Peer 2025-09-08  4088  		hwsim_nan_cluster_id[3] = 0x01;
a37a6f54439bf8 Ilan Peer 2025-09-08  4089  		hwsim_nan_cluster_id[4] = get_random_u8();
a37a6f54439bf8 Ilan Peer 2025-09-08  4090  		hwsim_nan_cluster_id[5] = get_random_u8();
a37a6f54439bf8 Ilan Peer 2025-09-08  4091  	}
a37a6f54439bf8 Ilan Peer 2025-09-08  4092  
a37a6f54439bf8 Ilan Peer 2025-09-08  4093  	data->notify_dw = conf->enable_dw_notification;
a37a6f54439bf8 Ilan Peer 2025-09-08  4094  
a37a6f54439bf8 Ilan Peer 2025-09-08  4095  	cfg80211_nan_cluster_joined(wdev, hwsim_nan_cluster_id, true,
a37a6f54439bf8 Ilan Peer 2025-09-08  4096  				    GFP_KERNEL);
a37a6f54439bf8 Ilan Peer 2025-09-08  4097  
a37a6f54439bf8 Ilan Peer 2025-09-08  4098  	return 0;
a37a6f54439bf8 Ilan Peer 2025-09-08  4099  }
a37a6f54439bf8 Ilan Peer 2025-09-08  4100  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

