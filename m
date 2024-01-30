Return-Path: <linux-wireless+bounces-2778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CD3841C18
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 07:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2421F250A6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 06:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D1F38FBA;
	Tue, 30 Jan 2024 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jt51+UbT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8651C42
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597151; cv=none; b=Pq1kxupFlPaVXQSIXnIfCobJyJRO6a0YE6sMDHAokpHWhey5qXXrOBJLyVed9QXVeqpDtIkABZ+Ms4RTDk0jUfaundvjuo2z2vMJCumFychp8K6Fx+ZyncxyjgdEiu+N0GstGnDEiT8Y26TZ0JXEgRToZW5kADk6HHBFpjVqavA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597151; c=relaxed/simple;
	bh=CI4c03J1GEzUK/JN2LKSVhMU5RB3b2jqUDmOVPH9P9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IL/GbNck9mS4JW17WfjQdOkK91X5pNBJTe/YwAOcBe0pgtkHwRVyxCNvzV8sHgulD7pXnMT65i8+9B1/ELjnFBSb9KPAfcTLKN6GcTQ4DkHvboX0nyrPe2WPlLhdCaqv0+uYE++Ya2j/S1TzmwAojl2qzmk9kJi60o03QMQP8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jt51+UbT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706597144; x=1738133144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CI4c03J1GEzUK/JN2LKSVhMU5RB3b2jqUDmOVPH9P9s=;
  b=Jt51+UbTdvGVnMgLGrW9hc2Np+uB/3c0H+2OqyeadTnlj7hxiq1sKutV
   7vpBkeU6iZ1//UjapPGPB9/PqnhiR4FQSn32fS3kcpHFm9mDAr3gqJHv2
   fmO5lYEaDg4xvU5brfutPPRhB3wec81bp+zTyqYzstRERGzWr8YuC/bbT
   vOiA3s06pZe3C7yZb7wG1WnwZYjUH9E0EiMvje8fDYSZiS+q5eYN4+KB+
   Xtp7sfR7xYY/zVz2SH5/F5G6Ga0pSgVSaTy8swJietnl9mPRt06mkyqDV
   aL7s0tMHR413/jRexcb21ETk98VLNP0jCuigpiaXGibxFo/MueS15gOWY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3061567"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3061567"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:45:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="30050956"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 29 Jan 2024 22:45:40 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUhsE-00004Y-39;
	Tue, 30 Jan 2024 06:45:36 +0000
Date: Tue, 30 Jan 2024 14:45:04 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into
 chandef
Message-ID: <202401301417.rknKsCyo-lkp@intel.com>
References: <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6@changeid>

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[cannot apply to wireless/main staging/staging-testing staging/staging-next staging/staging-linus linus/master v6.8-rc2 next-20240130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/wifi-mac80211-clean-up-band-switch-in-duration/20240130-025313
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20240129194108.307183a5d2e5.I4d7fe2f126b2366c1312010e2900dfb2abffa0f6%40changeid
patch subject: [PATCH 15/15] wifi: cfg80211/mac80211: move puncturing into chandef
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240130/202401301417.rknKsCyo-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 4a39d08908942b2d415db405844cbe4af73e75d4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240130/202401301417.rknKsCyo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401301417.rknKsCyo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath12k/mac.c:2771:16: error: use of undeclared identifier 'BSS_CHANGED_EHT_PUNCTURING'
    2771 |         if (changed & BSS_CHANGED_EHT_PUNCTURING)
         |                       ^
>> drivers/net/wireless/ath/ath12k/mac.c:2772:31: error: no member named 'eht_puncturing' in 'struct ieee80211_bss_conf'
    2772 |                 arvif->punct_bitmap = info->eht_puncturing;
         |                                       ~~~~  ^
   drivers/net/wireless/ath/ath12k/mac.c:6374:35: error: no member named 'eht_puncturing' in 'struct ieee80211_bss_conf'
    6374 |         arvif->punct_bitmap = link_conf->eht_puncturing;
         |                               ~~~~~~~~~  ^
   3 errors generated.


vim +/BSS_CHANGED_EHT_PUNCTURING +2771 drivers/net/wireless/ath/ath12k/mac.c

d889913205cf7e Kalle Valo    2022-11-28  2493  
d889913205cf7e Kalle Valo    2022-11-28  2494  static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
d889913205cf7e Kalle Valo    2022-11-28  2495  					   struct ieee80211_vif *vif,
d889913205cf7e Kalle Valo    2022-11-28  2496  					   struct ieee80211_bss_conf *info,
d889913205cf7e Kalle Valo    2022-11-28  2497  					   u64 changed)
d889913205cf7e Kalle Valo    2022-11-28  2498  {
d889913205cf7e Kalle Valo    2022-11-28  2499  	struct ath12k *ar = hw->priv;
d889913205cf7e Kalle Valo    2022-11-28  2500  	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
d889913205cf7e Kalle Valo    2022-11-28  2501  	struct cfg80211_chan_def def;
d889913205cf7e Kalle Valo    2022-11-28  2502  	u32 param_id, param_value;
d889913205cf7e Kalle Valo    2022-11-28  2503  	enum nl80211_band band;
d889913205cf7e Kalle Valo    2022-11-28  2504  	u32 vdev_param;
d889913205cf7e Kalle Valo    2022-11-28  2505  	int mcast_rate;
d889913205cf7e Kalle Valo    2022-11-28  2506  	u32 preamble;
d889913205cf7e Kalle Valo    2022-11-28  2507  	u16 hw_value;
d889913205cf7e Kalle Valo    2022-11-28  2508  	u16 bitrate;
d889913205cf7e Kalle Valo    2022-11-28  2509  	int ret;
d889913205cf7e Kalle Valo    2022-11-28  2510  	u8 rateidx;
d889913205cf7e Kalle Valo    2022-11-28  2511  	u32 rate;
d889913205cf7e Kalle Valo    2022-11-28  2512  
d889913205cf7e Kalle Valo    2022-11-28  2513  	mutex_lock(&ar->conf_mutex);
d889913205cf7e Kalle Valo    2022-11-28  2514  
d889913205cf7e Kalle Valo    2022-11-28  2515  	if (changed & BSS_CHANGED_BEACON_INT) {
d889913205cf7e Kalle Valo    2022-11-28  2516  		arvif->beacon_interval = info->beacon_int;
d889913205cf7e Kalle Valo    2022-11-28  2517  
d889913205cf7e Kalle Valo    2022-11-28  2518  		param_id = WMI_VDEV_PARAM_BEACON_INTERVAL;
d889913205cf7e Kalle Valo    2022-11-28  2519  		ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2520  						    param_id,
d889913205cf7e Kalle Valo    2022-11-28  2521  						    arvif->beacon_interval);
d889913205cf7e Kalle Valo    2022-11-28  2522  		if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2523  			ath12k_warn(ar->ab, "Failed to set beacon interval for VDEV: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2524  				    arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2525  		else
d889913205cf7e Kalle Valo    2022-11-28  2526  			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
d889913205cf7e Kalle Valo    2022-11-28  2527  				   "Beacon interval: %d set for VDEV: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2528  				   arvif->beacon_interval, arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2529  	}
d889913205cf7e Kalle Valo    2022-11-28  2530  
d889913205cf7e Kalle Valo    2022-11-28  2531  	if (changed & BSS_CHANGED_BEACON) {
d889913205cf7e Kalle Valo    2022-11-28  2532  		param_id = WMI_PDEV_PARAM_BEACON_TX_MODE;
c4cb46dfb291e1 Sidhanta Sahu 2023-09-05  2533  		param_value = WMI_BEACON_BURST_MODE;
d889913205cf7e Kalle Valo    2022-11-28  2534  		ret = ath12k_wmi_pdev_set_param(ar, param_id,
d889913205cf7e Kalle Valo    2022-11-28  2535  						param_value, ar->pdev->pdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2536  		if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2537  			ath12k_warn(ar->ab, "Failed to set beacon mode for VDEV: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2538  				    arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2539  		else
d889913205cf7e Kalle Valo    2022-11-28  2540  			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
c4cb46dfb291e1 Sidhanta Sahu 2023-09-05  2541  				   "Set burst beacon mode for VDEV: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2542  				   arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2543  
d889913205cf7e Kalle Valo    2022-11-28  2544  		ret = ath12k_mac_setup_bcn_tmpl(arvif);
d889913205cf7e Kalle Valo    2022-11-28  2545  		if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2546  			ath12k_warn(ar->ab, "failed to update bcn template: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2547  				    ret);
d889913205cf7e Kalle Valo    2022-11-28  2548  	}
d889913205cf7e Kalle Valo    2022-11-28  2549  
d889913205cf7e Kalle Valo    2022-11-28  2550  	if (changed & (BSS_CHANGED_BEACON_INFO | BSS_CHANGED_BEACON)) {
d889913205cf7e Kalle Valo    2022-11-28  2551  		arvif->dtim_period = info->dtim_period;
d889913205cf7e Kalle Valo    2022-11-28  2552  
d889913205cf7e Kalle Valo    2022-11-28  2553  		param_id = WMI_VDEV_PARAM_DTIM_PERIOD;
d889913205cf7e Kalle Valo    2022-11-28  2554  		ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2555  						    param_id,
d889913205cf7e Kalle Valo    2022-11-28  2556  						    arvif->dtim_period);
d889913205cf7e Kalle Valo    2022-11-28  2557  
d889913205cf7e Kalle Valo    2022-11-28  2558  		if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2559  			ath12k_warn(ar->ab, "Failed to set dtim period for VDEV %d: %i\n",
d889913205cf7e Kalle Valo    2022-11-28  2560  				    arvif->vdev_id, ret);
d889913205cf7e Kalle Valo    2022-11-28  2561  		else
d889913205cf7e Kalle Valo    2022-11-28  2562  			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
d889913205cf7e Kalle Valo    2022-11-28  2563  				   "DTIM period: %d set for VDEV: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2564  				   arvif->dtim_period, arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2565  	}
d889913205cf7e Kalle Valo    2022-11-28  2566  
d889913205cf7e Kalle Valo    2022-11-28  2567  	if (changed & BSS_CHANGED_SSID &&
d889913205cf7e Kalle Valo    2022-11-28  2568  	    vif->type == NL80211_IFTYPE_AP) {
d889913205cf7e Kalle Valo    2022-11-28  2569  		arvif->u.ap.ssid_len = vif->cfg.ssid_len;
d889913205cf7e Kalle Valo    2022-11-28  2570  		if (vif->cfg.ssid_len)
d889913205cf7e Kalle Valo    2022-11-28  2571  			memcpy(arvif->u.ap.ssid, vif->cfg.ssid, vif->cfg.ssid_len);
d889913205cf7e Kalle Valo    2022-11-28  2572  		arvif->u.ap.hidden_ssid = info->hidden_ssid;
d889913205cf7e Kalle Valo    2022-11-28  2573  	}
d889913205cf7e Kalle Valo    2022-11-28  2574  
d889913205cf7e Kalle Valo    2022-11-28  2575  	if (changed & BSS_CHANGED_BSSID && !is_zero_ether_addr(info->bssid))
d889913205cf7e Kalle Valo    2022-11-28  2576  		ether_addr_copy(arvif->bssid, info->bssid);
d889913205cf7e Kalle Valo    2022-11-28  2577  
d889913205cf7e Kalle Valo    2022-11-28  2578  	if (changed & BSS_CHANGED_BEACON_ENABLED) {
d889913205cf7e Kalle Valo    2022-11-28  2579  		ath12k_control_beaconing(arvif, info);
d889913205cf7e Kalle Valo    2022-11-28  2580  
d889913205cf7e Kalle Valo    2022-11-28  2581  		if (arvif->is_up && vif->bss_conf.he_support &&
d889913205cf7e Kalle Valo    2022-11-28  2582  		    vif->bss_conf.he_oper.params) {
d889913205cf7e Kalle Valo    2022-11-28  2583  			/* TODO: Extend to support 1024 BA Bitmap size */
d889913205cf7e Kalle Valo    2022-11-28  2584  			ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2585  							    WMI_VDEV_PARAM_BA_MODE,
d889913205cf7e Kalle Valo    2022-11-28  2586  							    WMI_BA_MODE_BUFFER_SIZE_256);
d889913205cf7e Kalle Valo    2022-11-28  2587  			if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2588  				ath12k_warn(ar->ab,
d889913205cf7e Kalle Valo    2022-11-28  2589  					    "failed to set BA BUFFER SIZE 256 for vdev: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2590  					    arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2591  
d889913205cf7e Kalle Valo    2022-11-28  2592  			param_id = WMI_VDEV_PARAM_HEOPS_0_31;
d889913205cf7e Kalle Valo    2022-11-28  2593  			param_value = vif->bss_conf.he_oper.params;
d889913205cf7e Kalle Valo    2022-11-28  2594  			ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2595  							    param_id, param_value);
d889913205cf7e Kalle Valo    2022-11-28  2596  			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
d889913205cf7e Kalle Valo    2022-11-28  2597  				   "he oper param: %x set for VDEV: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2598  				   param_value, arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2599  
d889913205cf7e Kalle Valo    2022-11-28  2600  			if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2601  				ath12k_warn(ar->ab, "Failed to set he oper params %x for VDEV %d: %i\n",
d889913205cf7e Kalle Valo    2022-11-28  2602  					    param_value, arvif->vdev_id, ret);
d889913205cf7e Kalle Valo    2022-11-28  2603  		}
d889913205cf7e Kalle Valo    2022-11-28  2604  	}
d889913205cf7e Kalle Valo    2022-11-28  2605  
d889913205cf7e Kalle Valo    2022-11-28  2606  	if (changed & BSS_CHANGED_ERP_CTS_PROT) {
d889913205cf7e Kalle Valo    2022-11-28  2607  		u32 cts_prot;
d889913205cf7e Kalle Valo    2022-11-28  2608  
d889913205cf7e Kalle Valo    2022-11-28  2609  		cts_prot = !!(info->use_cts_prot);
d889913205cf7e Kalle Valo    2022-11-28  2610  		param_id = WMI_VDEV_PARAM_PROTECTION_MODE;
d889913205cf7e Kalle Valo    2022-11-28  2611  
d889913205cf7e Kalle Valo    2022-11-28  2612  		if (arvif->is_started) {
d889913205cf7e Kalle Valo    2022-11-28  2613  			ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2614  							    param_id, cts_prot);
d889913205cf7e Kalle Valo    2022-11-28  2615  			if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2616  				ath12k_warn(ar->ab, "Failed to set CTS prot for VDEV: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2617  					    arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2618  			else
d889913205cf7e Kalle Valo    2022-11-28  2619  				ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "Set CTS prot: %d for VDEV: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2620  					   cts_prot, arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2621  		} else {
d889913205cf7e Kalle Valo    2022-11-28  2622  			ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "defer protection mode setup, vdev is not ready yet\n");
d889913205cf7e Kalle Valo    2022-11-28  2623  		}
d889913205cf7e Kalle Valo    2022-11-28  2624  	}
d889913205cf7e Kalle Valo    2022-11-28  2625  
d889913205cf7e Kalle Valo    2022-11-28  2626  	if (changed & BSS_CHANGED_ERP_SLOT) {
d889913205cf7e Kalle Valo    2022-11-28  2627  		u32 slottime;
d889913205cf7e Kalle Valo    2022-11-28  2628  
d889913205cf7e Kalle Valo    2022-11-28  2629  		if (info->use_short_slot)
d889913205cf7e Kalle Valo    2022-11-28  2630  			slottime = WMI_VDEV_SLOT_TIME_SHORT; /* 9us */
d889913205cf7e Kalle Valo    2022-11-28  2631  
d889913205cf7e Kalle Valo    2022-11-28  2632  		else
d889913205cf7e Kalle Valo    2022-11-28  2633  			slottime = WMI_VDEV_SLOT_TIME_LONG; /* 20us */
d889913205cf7e Kalle Valo    2022-11-28  2634  
d889913205cf7e Kalle Valo    2022-11-28  2635  		param_id = WMI_VDEV_PARAM_SLOT_TIME;
d889913205cf7e Kalle Valo    2022-11-28  2636  		ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2637  						    param_id, slottime);
d889913205cf7e Kalle Valo    2022-11-28  2638  		if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2639  			ath12k_warn(ar->ab, "Failed to set erp slot for VDEV: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2640  				    arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2641  		else
d889913205cf7e Kalle Valo    2022-11-28  2642  			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
d889913205cf7e Kalle Valo    2022-11-28  2643  				   "Set slottime: %d for VDEV: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2644  				   slottime, arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2645  	}
d889913205cf7e Kalle Valo    2022-11-28  2646  
d889913205cf7e Kalle Valo    2022-11-28  2647  	if (changed & BSS_CHANGED_ERP_PREAMBLE) {
d889913205cf7e Kalle Valo    2022-11-28  2648  		u32 preamble;
d889913205cf7e Kalle Valo    2022-11-28  2649  
d889913205cf7e Kalle Valo    2022-11-28  2650  		if (info->use_short_preamble)
d889913205cf7e Kalle Valo    2022-11-28  2651  			preamble = WMI_VDEV_PREAMBLE_SHORT;
d889913205cf7e Kalle Valo    2022-11-28  2652  		else
d889913205cf7e Kalle Valo    2022-11-28  2653  			preamble = WMI_VDEV_PREAMBLE_LONG;
d889913205cf7e Kalle Valo    2022-11-28  2654  
d889913205cf7e Kalle Valo    2022-11-28  2655  		param_id = WMI_VDEV_PARAM_PREAMBLE;
d889913205cf7e Kalle Valo    2022-11-28  2656  		ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2657  						    param_id, preamble);
d889913205cf7e Kalle Valo    2022-11-28  2658  		if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2659  			ath12k_warn(ar->ab, "Failed to set preamble for VDEV: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2660  				    arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2661  		else
d889913205cf7e Kalle Valo    2022-11-28  2662  			ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
d889913205cf7e Kalle Valo    2022-11-28  2663  				   "Set preamble: %d for VDEV: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2664  				   preamble, arvif->vdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2665  	}
d889913205cf7e Kalle Valo    2022-11-28  2666  
d889913205cf7e Kalle Valo    2022-11-28  2667  	if (changed & BSS_CHANGED_ASSOC) {
d889913205cf7e Kalle Valo    2022-11-28  2668  		if (vif->cfg.assoc)
d889913205cf7e Kalle Valo    2022-11-28  2669  			ath12k_bss_assoc(hw, vif, info);
d889913205cf7e Kalle Valo    2022-11-28  2670  		else
d889913205cf7e Kalle Valo    2022-11-28  2671  			ath12k_bss_disassoc(hw, vif);
d889913205cf7e Kalle Valo    2022-11-28  2672  	}
d889913205cf7e Kalle Valo    2022-11-28  2673  
d889913205cf7e Kalle Valo    2022-11-28  2674  	if (changed & BSS_CHANGED_TXPOWER) {
d889913205cf7e Kalle Valo    2022-11-28  2675  		ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev_id %i txpower %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2676  			   arvif->vdev_id, info->txpower);
d889913205cf7e Kalle Valo    2022-11-28  2677  
d889913205cf7e Kalle Valo    2022-11-28  2678  		arvif->txpower = info->txpower;
d889913205cf7e Kalle Valo    2022-11-28  2679  		ath12k_mac_txpower_recalc(ar);
d889913205cf7e Kalle Valo    2022-11-28  2680  	}
d889913205cf7e Kalle Valo    2022-11-28  2681  
d889913205cf7e Kalle Valo    2022-11-28  2682  	if (changed & BSS_CHANGED_MCAST_RATE &&
d889913205cf7e Kalle Valo    2022-11-28  2683  	    !ath12k_mac_vif_chan(arvif->vif, &def)) {
d889913205cf7e Kalle Valo    2022-11-28  2684  		band = def.chan->band;
d889913205cf7e Kalle Valo    2022-11-28  2685  		mcast_rate = vif->bss_conf.mcast_rate[band];
d889913205cf7e Kalle Valo    2022-11-28  2686  
d889913205cf7e Kalle Valo    2022-11-28  2687  		if (mcast_rate > 0)
d889913205cf7e Kalle Valo    2022-11-28  2688  			rateidx = mcast_rate - 1;
d889913205cf7e Kalle Valo    2022-11-28  2689  		else
d889913205cf7e Kalle Valo    2022-11-28  2690  			rateidx = ffs(vif->bss_conf.basic_rates) - 1;
d889913205cf7e Kalle Valo    2022-11-28  2691  
d889913205cf7e Kalle Valo    2022-11-28  2692  		if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP)
d889913205cf7e Kalle Valo    2022-11-28  2693  			rateidx += ATH12K_MAC_FIRST_OFDM_RATE_IDX;
d889913205cf7e Kalle Valo    2022-11-28  2694  
d889913205cf7e Kalle Valo    2022-11-28  2695  		bitrate = ath12k_legacy_rates[rateidx].bitrate;
d889913205cf7e Kalle Valo    2022-11-28  2696  		hw_value = ath12k_legacy_rates[rateidx].hw_value;
d889913205cf7e Kalle Valo    2022-11-28  2697  
d889913205cf7e Kalle Valo    2022-11-28  2698  		if (ath12k_mac_bitrate_is_cck(bitrate))
d889913205cf7e Kalle Valo    2022-11-28  2699  			preamble = WMI_RATE_PREAMBLE_CCK;
d889913205cf7e Kalle Valo    2022-11-28  2700  		else
d889913205cf7e Kalle Valo    2022-11-28  2701  			preamble = WMI_RATE_PREAMBLE_OFDM;
d889913205cf7e Kalle Valo    2022-11-28  2702  
d889913205cf7e Kalle Valo    2022-11-28  2703  		rate = ATH12K_HW_RATE_CODE(hw_value, 0, preamble);
d889913205cf7e Kalle Valo    2022-11-28  2704  
d889913205cf7e Kalle Valo    2022-11-28  2705  		ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
d889913205cf7e Kalle Valo    2022-11-28  2706  			   "mac vdev %d mcast_rate %x\n",
d889913205cf7e Kalle Valo    2022-11-28  2707  			   arvif->vdev_id, rate);
d889913205cf7e Kalle Valo    2022-11-28  2708  
d889913205cf7e Kalle Valo    2022-11-28  2709  		vdev_param = WMI_VDEV_PARAM_MCAST_DATA_RATE;
d889913205cf7e Kalle Valo    2022-11-28  2710  		ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2711  						    vdev_param, rate);
d889913205cf7e Kalle Valo    2022-11-28  2712  		if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2713  			ath12k_warn(ar->ab,
d889913205cf7e Kalle Valo    2022-11-28  2714  				    "failed to set mcast rate on vdev %i: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2715  				    arvif->vdev_id,  ret);
d889913205cf7e Kalle Valo    2022-11-28  2716  
d889913205cf7e Kalle Valo    2022-11-28  2717  		vdev_param = WMI_VDEV_PARAM_BCAST_DATA_RATE;
d889913205cf7e Kalle Valo    2022-11-28  2718  		ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2719  						    vdev_param, rate);
d889913205cf7e Kalle Valo    2022-11-28  2720  		if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2721  			ath12k_warn(ar->ab,
d889913205cf7e Kalle Valo    2022-11-28  2722  				    "failed to set bcast rate on vdev %i: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2723  				    arvif->vdev_id,  ret);
d889913205cf7e Kalle Valo    2022-11-28  2724  	}
d889913205cf7e Kalle Valo    2022-11-28  2725  
d889913205cf7e Kalle Valo    2022-11-28  2726  	if (changed & BSS_CHANGED_BASIC_RATES &&
d889913205cf7e Kalle Valo    2022-11-28  2727  	    !ath12k_mac_vif_chan(arvif->vif, &def))
d889913205cf7e Kalle Valo    2022-11-28  2728  		ath12k_recalculate_mgmt_rate(ar, vif, &def);
d889913205cf7e Kalle Valo    2022-11-28  2729  
d889913205cf7e Kalle Valo    2022-11-28  2730  	if (changed & BSS_CHANGED_TWT) {
d889913205cf7e Kalle Valo    2022-11-28  2731  		if (info->twt_requester || info->twt_responder)
d889913205cf7e Kalle Valo    2022-11-28  2732  			ath12k_wmi_send_twt_enable_cmd(ar, ar->pdev->pdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2733  		else
d889913205cf7e Kalle Valo    2022-11-28  2734  			ath12k_wmi_send_twt_disable_cmd(ar, ar->pdev->pdev_id);
d889913205cf7e Kalle Valo    2022-11-28  2735  	}
d889913205cf7e Kalle Valo    2022-11-28  2736  
d889913205cf7e Kalle Valo    2022-11-28  2737  	if (changed & BSS_CHANGED_HE_OBSS_PD)
d889913205cf7e Kalle Valo    2022-11-28  2738  		ath12k_wmi_send_obss_spr_cmd(ar, arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2739  					     &info->he_obss_pd);
d889913205cf7e Kalle Valo    2022-11-28  2740  
d889913205cf7e Kalle Valo    2022-11-28  2741  	if (changed & BSS_CHANGED_HE_BSS_COLOR) {
d889913205cf7e Kalle Valo    2022-11-28  2742  		if (vif->type == NL80211_IFTYPE_AP) {
d889913205cf7e Kalle Valo    2022-11-28  2743  			ret = ath12k_wmi_obss_color_cfg_cmd(ar,
d889913205cf7e Kalle Valo    2022-11-28  2744  							    arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2745  							    info->he_bss_color.color,
d889913205cf7e Kalle Valo    2022-11-28  2746  							    ATH12K_BSS_COLOR_AP_PERIODS,
d889913205cf7e Kalle Valo    2022-11-28  2747  							    info->he_bss_color.enabled);
d889913205cf7e Kalle Valo    2022-11-28  2748  			if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2749  				ath12k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2750  					    arvif->vdev_id,  ret);
d889913205cf7e Kalle Valo    2022-11-28  2751  		} else if (vif->type == NL80211_IFTYPE_STATION) {
d889913205cf7e Kalle Valo    2022-11-28  2752  			ret = ath12k_wmi_send_bss_color_change_enable_cmd(ar,
d889913205cf7e Kalle Valo    2022-11-28  2753  									  arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2754  									  1);
d889913205cf7e Kalle Valo    2022-11-28  2755  			if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2756  				ath12k_warn(ar->ab, "failed to enable bss color change on vdev %i: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2757  					    arvif->vdev_id,  ret);
d889913205cf7e Kalle Valo    2022-11-28  2758  			ret = ath12k_wmi_obss_color_cfg_cmd(ar,
d889913205cf7e Kalle Valo    2022-11-28  2759  							    arvif->vdev_id,
d889913205cf7e Kalle Valo    2022-11-28  2760  							    0,
d889913205cf7e Kalle Valo    2022-11-28  2761  							    ATH12K_BSS_COLOR_STA_PERIODS,
d889913205cf7e Kalle Valo    2022-11-28  2762  							    1);
d889913205cf7e Kalle Valo    2022-11-28  2763  			if (ret)
d889913205cf7e Kalle Valo    2022-11-28  2764  				ath12k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
d889913205cf7e Kalle Valo    2022-11-28  2765  					    arvif->vdev_id,  ret);
d889913205cf7e Kalle Valo    2022-11-28  2766  		}
d889913205cf7e Kalle Valo    2022-11-28  2767  	}
d889913205cf7e Kalle Valo    2022-11-28  2768  
d889913205cf7e Kalle Valo    2022-11-28  2769  	ath12k_mac_fils_discovery(arvif, info);
d889913205cf7e Kalle Valo    2022-11-28  2770  
07c01b86f21dd4 Aloka Dixit   2023-08-02 @2771  	if (changed & BSS_CHANGED_EHT_PUNCTURING)
07c01b86f21dd4 Aloka Dixit   2023-08-02 @2772  		arvif->punct_bitmap = info->eht_puncturing;
07c01b86f21dd4 Aloka Dixit   2023-08-02  2773  
d889913205cf7e Kalle Valo    2022-11-28  2774  	mutex_unlock(&ar->conf_mutex);
d889913205cf7e Kalle Valo    2022-11-28  2775  }
d889913205cf7e Kalle Valo    2022-11-28  2776  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

