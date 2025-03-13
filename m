Return-Path: <linux-wireless+bounces-20298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42FA5EE66
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 09:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687AA189FF99
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30C226157B;
	Thu, 13 Mar 2025 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m38hReo9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0249026281F
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855789; cv=none; b=SmqJ2wNQa4P9Adzaki1o4LY9Ava7UjsMnEMdysf9cEhDCvFHmSLO2vZvXOLueFGTqL4LpkFN8PmyLSuvq+IQ23gxJXOkU1t8QlFtUVArzmoYybObkhuZN8o6li71a6iW+fTOnZLueu5994jqsd8Q7tROW9cJwVhHHSN6BgaI1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855789; c=relaxed/simple;
	bh=vAEaDGijNXNaotmF7hcs6FNxQJRH9+12fIrHcW0asQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHPiBasxjMp/myZNMVc1dtMdMqcq7MGNYWKGZ6bhN3lXbCx/kFpHdyK3Y6dezdEXPS2Mr+Y/0mR8QdQTYALLhYtLw73tDBAUN4I0LXcyxcZfGMg6vFgXcFARIDOSda91KyNX7lLnkUxf7pJ6Yu1yh7f/vkMqzbmj+OG+Vt4BFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m38hReo9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741855788; x=1773391788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vAEaDGijNXNaotmF7hcs6FNxQJRH9+12fIrHcW0asQo=;
  b=m38hReo9Hj/UpFU1dLFHiK245L8qDdjuvT3kWRoXgTz8Pckmb9+aQvtM
   A3AtgGtGppLhZJHPLHSNZQD8vib9Wwgz4WOSXymcjy0J8qy6RpAKgM9x2
   oFlndNJlRMIsnGkNp1eyGxNS+jgSo6ZjnP9jY3eXSzHL2D6vZbcDQlDBO
   ZI/5345/v5I4p2PoHLHr/QWZKMhte0z2j/BOYlJDOJ/Qh+UfJWSji213y
   O4xxUlCbG2P1cOkMnfNMlWPaVm51Uquv4fGShdX4lrzTQc6SNwFpIlNgq
   62Tf8eA7Oj7Gz5WOXh5wXRLLAkBvqY+oBtcsHDINuRzXE8ZTOBW05XpT+
   w==;
X-CSE-ConnectionGUID: aD2pdkLHSn++MzJfawjedQ==
X-CSE-MsgGUID: NGOsSYkmQH+ILLryp7fabQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42991363"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42991363"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:49:47 -0700
X-CSE-ConnectionGUID: bdW+ocaFSEGMFAJicoe32A==
X-CSE-MsgGUID: ++zdYlcfT46yHsfeedYqyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121380567"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 13 Mar 2025 01:49:45 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tseG5-0009Fp-2z;
	Thu, 13 Mar 2025 08:49:41 +0000
Date: Thu, 13 Mar 2025 16:49:24 +0800
From: kernel test robot <lkp@intel.com>
To: Sarika Sharma <quic_sarishar@quicinc.com>, johannes@sipsolutions.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Sarika Sharma <quic_sarishar@quicinc.com>
Subject: Re: [PATCH wireless-next v5 04/11] wifi: cfg80211: reorg sinfo
 structure elements for MLO
Message-ID: <202503131646.3EOj6ycs-lkp@intel.com>
References: <20250312065132.3397726-5-quic_sarishar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312065132.3397726-5-quic_sarishar@quicinc.com>

Hi Sarika,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9324731b9985478faf7f77713cc5e5fee811716e]

url:    https://github.com/intel-lab-lkp/linux/commits/Sarika-Sharma/wifi-mac80211-add-support-towards-MLO-handling-of-station-statistics/20250312-145356
base:   9324731b9985478faf7f77713cc5e5fee811716e
patch link:    https://lore.kernel.org/r/20250312065132.3397726-5-quic_sarishar%40quicinc.com
patch subject: [PATCH wireless-next v5 04/11] wifi: cfg80211: reorg sinfo structure elements for MLO
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250313/202503131646.3EOj6ycs-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503131646.3EOj6ycs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503131646.3EOj6ycs-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:12:
   drivers/net/wireless/intel/iwlwifi/mld/iface.h:172:5: warning: "CONFIG_PM_SLEEP" is not defined, evaluates to 0 [-Wundef]
     172 | #if CONFIG_PM_SLEEP
         |     ^~~~~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:2637:10: error: 'const struct ieee80211_ops' has no member named 'sta_statistics'; did you mean 'link_sta_statistics'?
    2637 |         .sta_statistics = iwl_mld_mac80211_sta_statistics,
         |          ^~~~~~~~~~~~~~
         |          link_sta_statistics
>> drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:2637:27: error: initialization of 'void (*)(struct ieee80211_hw *, struct ieee80211_vif *, struct ieee80211_sta *)' from incompatible pointer type 'void (*)(struct ieee80211_hw *, struct ieee80211_vif *, struct ieee80211_sta *, struct station_info *)' [-Wincompatible-pointer-types]
    2637 |         .sta_statistics = iwl_mld_mac80211_sta_statistics,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:2637:27: note: (near initialization for 'iwl_mld_hw_ops.sta_pre_rcu_remove')
   drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:2651:31: warning: initialized field overwritten [-Woverride-init]
    2651 |         .sta_pre_rcu_remove = iwl_mld_sta_pre_rcu_remove,
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:2651:31: note: (near initialization for 'iwl_mld_hw_ops.sta_pre_rcu_remove')
   drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:1985:12: warning: 'iwl_mld_resume' defined but not used [-Wunused-function]
    1985 | static int iwl_mld_resume(struct ieee80211_hw *hw)
         |            ^~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:1963:1: warning: 'iwl_mld_suspend' defined but not used [-Wunused-function]
    1963 | iwl_mld_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
         | ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mld/mac80211.c:1949:13: warning: 'iwl_mld_set_wakeup' defined but not used [-Wunused-function]
    1949 | static void iwl_mld_set_wakeup(struct ieee80211_hw *hw, bool enabled)
         |             ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/net/wireless/intel/iwlwifi/mld/mlo.h:13,
                    from drivers/net/wireless/intel/iwlwifi/mld/stats.c:9:
   drivers/net/wireless/intel/iwlwifi/mld/iface.h:172:5: warning: "CONFIG_PM_SLEEP" is not defined, evaluates to 0 [-Wundef]
     172 | #if CONFIG_PM_SLEEP
         |     ^~~~~~~~~~~~~~~
   drivers/net/wireless/intel/iwlwifi/mld/stats.c: In function 'iwl_mld_fill_stats_from_oper_notif':
>> drivers/net/wireless/intel/iwlwifi/mld/stats.c:67:14: error: 'struct station_info' has no member named 'signal_avg'
      67 |         sinfo->signal_avg = mld_link_sta->signal_avg;
         |              ^~
   drivers/net/wireless/intel/iwlwifi/mld/stats.c: In function 'iwl_mld_sta_stats_fill_txrate':
   drivers/net/wireless/intel/iwlwifi/mld/stats.c:169:41: error: 'struct station_info' has no member named 'txrate'
     169 |         struct rate_info *rinfo = &sinfo->txrate;
         |                                         ^~


vim +2637 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c

d1e879ec600f9b3 Miri Korenblit 2025-02-16  2608  
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2609  const struct ieee80211_ops iwl_mld_hw_ops = {
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2610  	.tx = iwl_mld_mac80211_tx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2611  	.start = iwl_mld_mac80211_start,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2612  	.stop = iwl_mld_mac80211_stop,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2613  	.config = iwl_mld_mac80211_config,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2614  	.add_interface = iwl_mld_mac80211_add_interface,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2615  	.remove_interface = iwl_mld_mac80211_remove_interface,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2616  	.conf_tx = iwl_mld_mac80211_conf_tx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2617  	.prepare_multicast = iwl_mld_mac80211_prepare_multicast,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2618  	.configure_filter = iwl_mld_mac80211_configure_filter,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2619  	.reconfig_complete = iwl_mld_mac80211_reconfig_complete,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2620  	.wake_tx_queue = iwl_mld_mac80211_wake_tx_queue,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2621  	.add_chanctx = iwl_mld_add_chanctx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2622  	.remove_chanctx = iwl_mld_remove_chanctx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2623  	.change_chanctx = iwl_mld_change_chanctx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2624  	.assign_vif_chanctx = iwl_mld_assign_vif_chanctx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2625  	.unassign_vif_chanctx = iwl_mld_unassign_vif_chanctx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2626  	.set_rts_threshold = iwl_mld_mac80211_set_rts_threshold,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2627  	.link_info_changed = iwl_mld_mac80211_link_info_changed,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2628  	.vif_cfg_changed = iwl_mld_mac80211_vif_cfg_changed,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2629  	.set_key = iwl_mld_mac80211_set_key,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2630  	.hw_scan = iwl_mld_mac80211_hw_scan,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2631  	.cancel_hw_scan = iwl_mld_mac80211_cancel_hw_scan,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2632  	.sched_scan_start = iwl_mld_mac80211_sched_scan_start,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2633  	.sched_scan_stop = iwl_mld_mac80211_sched_scan_stop,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2634  	.mgd_prepare_tx = iwl_mld_mac80211_mgd_prepare_tx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2635  	.mgd_complete_tx = iwl_mld_mac_mgd_complete_tx,
d1e879ec600f9b3 Miri Korenblit 2025-02-16  2636  	.sta_state = iwl_mld_mac80211_sta_state,
d1e879ec600f9b3 Miri Korenblit 2025-02-16 @2637  	.sta_statistics = iwl_mld_mac80211_sta_statistics,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

