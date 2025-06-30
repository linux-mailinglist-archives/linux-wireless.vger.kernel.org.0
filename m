Return-Path: <linux-wireless+bounces-24672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B844EAEE7A4
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 21:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5F71BC2744
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 19:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871428C2CB;
	Mon, 30 Jun 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8d3Qael"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65823FC66
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312313; cv=none; b=k3rcYopizlYlEMTuC7vqyStOr7nEHjTAaBwzseeqNeOAtGRPFj7DumLqvoSbLa/arDu5T6cAVZ1QJpZ2JWV8vxefkqZTSF2d8Yg5231XbeFSyvh45iTjeOOwCRO5FG/dEAyFzayVxnSRq0gx6WdE3xuOqIm3FS0Jq/xx6/lH0GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312313; c=relaxed/simple;
	bh=9/k0SBtPdnQG31h9+/PNq1RnfTFcG8cpCMsYhIlkroY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1EU947CzClfNNADEEAyW8kM65tOB9t9DgN3pOTK6alHmnv95LBb1OX+f8sYtCUcduYj2wQlZx7S2lgUHOSUAzTksXDxIxMNkgInBIzRrqjA/7VXi985siVLkbaTYkJmNJTjyCGGRBE70wJZVhgTOb9OE2BQbiwkNelVt3VgMQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8d3Qael; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751312310; x=1782848310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9/k0SBtPdnQG31h9+/PNq1RnfTFcG8cpCMsYhIlkroY=;
  b=f8d3Qael55s7z3SSFjvS4yk+8viTXv4AgIdxyZ6f63/icJQSGKgoWGBs
   Ut7f5GL0gJV9w1+9zwoTUf4M1lJXO3war/kG44+ILzcGWF75a8q7/NAQX
   UkvMZ1rJyegomAqqzUQLwKxbPG32CH6tubsIzJXW3slogrGPfHEiEyrOU
   cYL3q0y/4Ns0uPWHETtVqmmcH4IBKawOgAPMDB+1uKBr4dk9PGDFWI3OI
   t1UuSDUOupthE31qcia7qWsEJpJ1NDIfcTKJn8MPh8nxvqfpXfa5oVhWo
   oSt4kIV2sM8gvAEjSFzbaov4xIUpnfyMJnFy0ifRtL4BxocflPBeKSIUn
   g==;
X-CSE-ConnectionGUID: ipdFsRW5TLeCruuIt80Rpg==
X-CSE-MsgGUID: PPpIoyqdSL2kSkNaiV3SOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="63807194"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="63807194"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 12:38:30 -0700
X-CSE-ConnectionGUID: 3Ogax5VIR2OaE/fv0rROpg==
X-CSE-MsgGUID: lIP5lnsDT4ixithe8gS+zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="153175867"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 30 Jun 2025 12:38:28 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWKKf-000ZK4-2x;
	Mon, 30 Jun 2025 19:38:25 +0000
Date: Tue, 1 Jul 2025 03:37:35 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>
Subject: Re: [PATCH wireless] wifi: mac80211: clear frame buffer to never
 leak stack
Message-ID: <202507010330.Il99RKPP-lkp@intel.com>
References: <20250630153227.4c5640a33305.I7ab6b75e486b98435151d06ffe0d0c2acb2f41c3@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630153227.4c5640a33305.I7ab6b75e486b98435151d06ffe0d0c2acb2f41c3@changeid>

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.16-rc4 next-20250630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/wifi-mac80211-clear-frame-buffer-to-never-leak-stack/20250630-213453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20250630153227.4c5640a33305.I7ab6b75e486b98435151d06ffe0d0c2acb2f41c3%40changeid
patch subject: [PATCH wireless] wifi: mac80211: clear frame buffer to never leak stack
config: x86_64-buildonly-randconfig-002-20250630 (https://download.01.org/0day-ci/archive/20250701/202507010330.Il99RKPP-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250701/202507010330.Il99RKPP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507010330.Il99RKPP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/mac80211/mlme.c:3938:24: error: incompatible pointer to integer conversion passing 'void (struct ieee80211_sub_if_data *, u16, u16, bool, u8 *)' (aka 'void (struct ieee80211_sub_if_data *, unsigned short, unsigned short, _Bool, unsigned char *)') to parameter of type 'unsigned long' [-Wint-conversion]
    3938 |                 memset(frame_buf, 0, ieee80211_set_disassoc);
         |                                      ^~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/string_64.h:22:37: note: passing argument to parameter 'n' here
      22 | void *memset(void *s, int c, size_t n);
         |                                     ^
   1 error generated.


vim +3938 net/mac80211/mlme.c

  3919	
  3920	static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
  3921					   u16 stype, u16 reason, bool tx,
  3922					   u8 *frame_buf)
  3923	{
  3924		struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
  3925		struct ieee80211_local *local = sdata->local;
  3926		struct sta_info *ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
  3927		unsigned int link_id;
  3928		u64 changed = 0;
  3929		struct ieee80211_prep_tx_info info = {
  3930			.subtype = stype,
  3931			.was_assoc = true,
  3932			.link_id = ffs(sdata->vif.active_links) - 1,
  3933		};
  3934	
  3935		lockdep_assert_wiphy(local->hw.wiphy);
  3936	
  3937		if (frame_buf)
> 3938			memset(frame_buf, 0, ieee80211_set_disassoc);
  3939	
  3940		if (WARN_ON(!ap_sta))
  3941			return;
  3942	
  3943		if (WARN_ON_ONCE(tx && !frame_buf))
  3944			return;
  3945	
  3946		if (WARN_ON(!ifmgd->associated))
  3947			return;
  3948	
  3949		ieee80211_stop_poll(sdata);
  3950	
  3951		ifmgd->associated = false;
  3952	
  3953		if (tx) {
  3954			bool tx_link_found = false;
  3955	
  3956			for (link_id = 0;
  3957			     link_id < ARRAY_SIZE(sdata->link);
  3958			     link_id++) {
  3959				struct ieee80211_link_data *link;
  3960	
  3961				if (!ieee80211_vif_link_active(&sdata->vif, link_id))
  3962					continue;
  3963	
  3964				link = sdata_dereference(sdata->link[link_id], sdata);
  3965				if (WARN_ON_ONCE(!link))
  3966					continue;
  3967	
  3968				if (link->u.mgd.csa.blocked_tx)
  3969					continue;
  3970	
  3971				tx_link_found = true;
  3972				break;
  3973			}
  3974	
  3975			tx = tx_link_found;
  3976		}
  3977	
  3978		/* other links will be destroyed */
  3979		sdata->deflink.conf->bss = NULL;
  3980		sdata->deflink.conf->epcs_support = false;
  3981		sdata->deflink.smps_mode = IEEE80211_SMPS_OFF;
  3982	
  3983		netif_carrier_off(sdata->dev);
  3984	
  3985		/*
  3986		 * if we want to get out of ps before disassoc (why?) we have
  3987		 * to do it before sending disassoc, as otherwise the null-packet
  3988		 * won't be valid.
  3989		 */
  3990		if (local->hw.conf.flags & IEEE80211_CONF_PS) {
  3991			local->hw.conf.flags &= ~IEEE80211_CONF_PS;
  3992			ieee80211_hw_config(local, -1, IEEE80211_CONF_CHANGE_PS);
  3993		}
  3994		local->ps_sdata = NULL;
  3995	
  3996		/* disable per-vif ps */
  3997		ieee80211_recalc_ps_vif(sdata);
  3998	
  3999		/* make sure ongoing transmission finishes */
  4000		synchronize_net();
  4001	
  4002		/*
  4003		 * drop any frame before deauth/disassoc, this can be data or
  4004		 * management frame. Since we are disconnecting, we should not
  4005		 * insist sending these frames which can take time and delay
  4006		 * the disconnection and possible the roaming.
  4007		 */
  4008		ieee80211_flush_queues(local, sdata, true);
  4009	
  4010		if (tx) {
  4011			drv_mgd_prepare_tx(sdata->local, sdata, &info);
  4012	
  4013			ieee80211_send_deauth_disassoc(sdata, sdata->vif.cfg.ap_addr,
  4014						       sdata->vif.cfg.ap_addr, stype,
  4015						       reason, true, frame_buf);
  4016	
  4017			/* flush out frame - make sure the deauth was actually sent */
  4018			ieee80211_flush_queues(local, sdata, false);
  4019	
  4020			drv_mgd_complete_tx(sdata->local, sdata, &info);
  4021		} else if (frame_buf) {
  4022			ieee80211_send_deauth_disassoc(sdata, sdata->vif.cfg.ap_addr,
  4023						       sdata->vif.cfg.ap_addr, stype,
  4024						       reason, false, frame_buf);
  4025		}
  4026	
  4027		/* clear AP addr only after building the needed mgmt frames */
  4028		eth_zero_addr(sdata->deflink.u.mgd.bssid);
  4029		eth_zero_addr(sdata->vif.cfg.ap_addr);
  4030	
  4031		sdata->vif.cfg.ssid_len = 0;
  4032	
  4033		/* Remove TDLS peers */
  4034		__sta_info_flush(sdata, false, -1, ap_sta);
  4035	
  4036		if (sdata->vif.driver_flags & IEEE80211_VIF_REMOVE_AP_AFTER_DISASSOC) {
  4037			/* Only move the AP state */
  4038			sta_info_move_state(ap_sta, IEEE80211_STA_NONE);
  4039		} else {
  4040			/* Remove AP peer */
  4041			sta_info_flush(sdata, -1);
  4042		}
  4043	
  4044		/* finally reset all BSS / config parameters */
  4045		if (!ieee80211_vif_is_mld(&sdata->vif))
  4046			changed |= ieee80211_reset_erp_info(sdata);
  4047	
  4048		ieee80211_led_assoc(local, 0);
  4049		changed |= BSS_CHANGED_ASSOC;
  4050		sdata->vif.cfg.assoc = false;
  4051	
  4052		sdata->deflink.u.mgd.p2p_noa_index = -1;
  4053		memset(&sdata->vif.bss_conf.p2p_noa_attr, 0,
  4054		       sizeof(sdata->vif.bss_conf.p2p_noa_attr));
  4055	
  4056		/* on the next assoc, re-program HT/VHT parameters */
  4057		memset(&ifmgd->ht_capa, 0, sizeof(ifmgd->ht_capa));
  4058		memset(&ifmgd->ht_capa_mask, 0, sizeof(ifmgd->ht_capa_mask));
  4059		memset(&ifmgd->vht_capa, 0, sizeof(ifmgd->vht_capa));
  4060		memset(&ifmgd->vht_capa_mask, 0, sizeof(ifmgd->vht_capa_mask));
  4061	
  4062		/*
  4063		 * reset MU-MIMO ownership and group data in default link,
  4064		 * if used, other links are destroyed
  4065		 */
  4066		memset(sdata->vif.bss_conf.mu_group.membership, 0,
  4067		       sizeof(sdata->vif.bss_conf.mu_group.membership));
  4068		memset(sdata->vif.bss_conf.mu_group.position, 0,
  4069		       sizeof(sdata->vif.bss_conf.mu_group.position));
  4070		if (!ieee80211_vif_is_mld(&sdata->vif))
  4071			changed |= BSS_CHANGED_MU_GROUPS;
  4072		sdata->vif.bss_conf.mu_mimo_owner = false;
  4073	
  4074		sdata->deflink.ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
  4075	
  4076		timer_delete_sync(&local->dynamic_ps_timer);
  4077		wiphy_work_cancel(local->hw.wiphy, &local->dynamic_ps_enable_work);
  4078	
  4079		/* Disable ARP filtering */
  4080		if (sdata->vif.cfg.arp_addr_cnt)
  4081			changed |= BSS_CHANGED_ARP_FILTER;
  4082	
  4083		sdata->vif.bss_conf.qos = false;
  4084		if (!ieee80211_vif_is_mld(&sdata->vif)) {
  4085			changed |= BSS_CHANGED_QOS;
  4086			/* The BSSID (not really interesting) and HT changed */
  4087			changed |= BSS_CHANGED_BSSID | BSS_CHANGED_HT;
  4088			ieee80211_bss_info_change_notify(sdata, changed);
  4089		} else {
  4090			ieee80211_vif_cfg_change_notify(sdata, changed);
  4091		}
  4092	
  4093		if (sdata->vif.driver_flags & IEEE80211_VIF_REMOVE_AP_AFTER_DISASSOC) {
  4094			/*
  4095			 * After notifying the driver about the disassoc,
  4096			 * remove the ap sta.
  4097			 */
  4098			sta_info_flush(sdata, -1);
  4099		}
  4100	
  4101		/* disassociated - set to defaults now */
  4102		ieee80211_set_wmm_default(&sdata->deflink, false, false);
  4103	
  4104		timer_delete_sync(&sdata->u.mgd.conn_mon_timer);
  4105		timer_delete_sync(&sdata->u.mgd.bcn_mon_timer);
  4106		timer_delete_sync(&sdata->u.mgd.timer);
  4107	
  4108		sdata->vif.bss_conf.dtim_period = 0;
  4109		sdata->vif.bss_conf.beacon_rate = NULL;
  4110	
  4111		sdata->deflink.u.mgd.have_beacon = false;
  4112		sdata->deflink.u.mgd.tracking_signal_avg = false;
  4113		sdata->deflink.u.mgd.disable_wmm_tracking = false;
  4114	
  4115		ifmgd->flags = 0;
  4116	
  4117		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
  4118			struct ieee80211_link_data *link;
  4119	
  4120			link = sdata_dereference(sdata->link[link_id], sdata);
  4121			if (!link)
  4122				continue;
  4123			ieee80211_link_release_channel(link);
  4124		}
  4125	
  4126		sdata->vif.bss_conf.csa_active = false;
  4127		sdata->deflink.u.mgd.csa.blocked_tx = false;
  4128		sdata->deflink.u.mgd.csa.waiting_bcn = false;
  4129		sdata->deflink.u.mgd.csa.ignored_same_chan = false;
  4130		ieee80211_vif_unblock_queues_csa(sdata);
  4131	
  4132		/* existing TX TSPEC sessions no longer exist */
  4133		memset(ifmgd->tx_tspec, 0, sizeof(ifmgd->tx_tspec));
  4134		wiphy_delayed_work_cancel(local->hw.wiphy, &ifmgd->tx_tspec_wk);
  4135	
  4136		sdata->vif.bss_conf.power_type = IEEE80211_REG_UNSET_AP;
  4137		sdata->vif.bss_conf.pwr_reduction = 0;
  4138		ieee80211_clear_tpe(&sdata->vif.bss_conf.tpe);
  4139	
  4140		sdata->vif.cfg.eml_cap = 0;
  4141		sdata->vif.cfg.eml_med_sync_delay = 0;
  4142		sdata->vif.cfg.mld_capa_op = 0;
  4143	
  4144		memset(&sdata->u.mgd.ttlm_info, 0,
  4145		       sizeof(sdata->u.mgd.ttlm_info));
  4146		wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
  4147	
  4148		memset(&sdata->vif.neg_ttlm, 0, sizeof(sdata->vif.neg_ttlm));
  4149		wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
  4150					  &ifmgd->neg_ttlm_timeout_work);
  4151	
  4152		sdata->u.mgd.removed_links = 0;
  4153		wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
  4154					  &sdata->u.mgd.ml_reconf_work);
  4155	
  4156		wiphy_work_cancel(sdata->local->hw.wiphy,
  4157				  &ifmgd->teardown_ttlm_work);
  4158	
  4159		/* if disconnection happens in the middle of the ML reconfiguration
  4160		 * flow, cfg80211 must called to release the BSS references obtained
  4161		 * when the flow started.
  4162		 */
  4163		ieee80211_ml_reconf_reset(sdata);
  4164	
  4165		ieee80211_vif_set_links(sdata, 0, 0);
  4166	
  4167		ifmgd->mcast_seq_last = IEEE80211_SN_MODULO;
  4168	
  4169		ifmgd->epcs.enabled = false;
  4170		ifmgd->epcs.dialog_token = 0;
  4171	
  4172		memset(ifmgd->userspace_selectors, 0,
  4173		       sizeof(ifmgd->userspace_selectors));
  4174	}
  4175	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

