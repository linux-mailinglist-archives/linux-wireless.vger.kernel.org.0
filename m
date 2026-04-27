Return-Path: <linux-wireless+bounces-35407-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIiHMjfI72knGAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35407-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 22:33:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A32D747A135
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 22:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 407E830844F5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 20:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D3236E48C;
	Mon, 27 Apr 2026 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nP3MBK2r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8D36D517;
	Mon, 27 Apr 2026 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321730; cv=none; b=YeVZ0JRjwvh27TFe5M0GeP1laDDk66ewRGmJNzhxJSif+k4gX/4Kw0k7eqBsb75Az1fQD0rG3h4bRzJ6X5WI2vnpFpcjBrI0ZFJ/oGNAIBwrMkit/sQeJ7VydH9PSt3/fxWzt+37TUNyWWUJ0vtUYsSVkyP3P7QrsFAuT5YvuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321730; c=relaxed/simple;
	bh=WwCEgKmsOv/luKExMIN07wuqqxA5j7fzrpkrBbHAXCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBHXQPsVd8VRKYeGXL25qbUMtHvDlXA54TdYYFSoUkpGXAzka3gKkuytn6iNrbe5LTuvzKAAb3UVYU2yLeitFbUn47MIe0YLbolbGP5bAbS4+tP+x9dcNXcLKS7dWiQs8Uvc45XxOpuxESQRMPYgTBgONyxY7Bt+ZkbIkgcMt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nP3MBK2r; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777321730; x=1808857730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WwCEgKmsOv/luKExMIN07wuqqxA5j7fzrpkrBbHAXCU=;
  b=nP3MBK2rYgjH2Lmu/R37h8cJhXQajk8iLWsLvlFRtdf7hD/rqr10Dz1m
   Hyf/yaiWN4MpxMsTsFjTwu6r/JjtkFtvBRx2S+aHCitRuVqXT6THEy/Tf
   kvycxw38vlATbFcxz1xLqbQeZB6cGm8/ril/iaEXSub4wXpyFB+XCwyvz
   9kd0xcOkkoKpyH/sPx9etAA3HV7A4cjqBniZNeXqCx0Yo39TdDUepl2sQ
   hkB2jmgqunaytWLF9LIyO/WkQt4802K5c1IfRz78NadU+aThuVIJfHbvz
   mmkV3BG4NOBuiIR8EJLfW72hFc6sHjGWPc8cSgqRsEmmcUgRvSU4QFMmz
   g==;
X-CSE-ConnectionGUID: qrrur1y7TZa6VRMmxlFbaQ==
X-CSE-MsgGUID: jr3E0PRcQ4CHt21SNiTWlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78114791"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78114791"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:28:49 -0700
X-CSE-ConnectionGUID: 7PuD40s3Rgq6p6e0y8l8fA==
X-CSE-MsgGUID: +fMDpSQvRQORY1ivZQjeyA==
X-ExtLoop1: 1
Received: from arjan-box.jf.intel.com ([10.88.27.153])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:28:48 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-wireless@vger.kernel.org
Cc: syzbot+ca7a2759caaa6cd4e3db@syzkaller.appspotmail.com,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] divide error in mac80211_hwsim_link_info_changed (3)
Date: Mon, 27 Apr 2026 13:29:54 -0700
Message-ID: <20260427203005.506192-1-arjan@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <69efb8dd.050a0220.18b4f.0006.GAE@google.com>
References: <69efb8dd.050a0220.18b4f.0006.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A32D747A135
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35407-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[arjan@linux.intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,linux.intel.com:mid];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,ca7a2759caaa6cd4e3db];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]

This email is created by automation to help kernel developers
deal with a large volume of AI generated bug reports by decoding
oopses into more actionable information.


Decoded Backtrace

1. mac80211_hwsim_link_info_changed -- crash site
   (drivers/net/wireless/virtual/mac80211_hwsim.c:2734)

2701  static void mac80211_hwsim_link_info_changed(struct ieee80211_hw *hw,
2702  					     struct ieee80211_vif *vif,
2703  					     struct ieee80211_bss_conf *info,
2704  					     u64 changed)
2705  {
2706  	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
2707  	struct mac80211_hwsim_data *data = hw->priv;
2708  	unsigned int link_id = info->link_id;
2709  	struct mac80211_hwsim_link_data *link_data = &data->link_data[link_id];
        ...
2722  	if (changed & BSS_CHANGED_BEACON_ENABLED) {
2723  		wiphy_dbg(hw->wiphy, "  BCN EN: %d (BI=%u)\n",
2724  			  info->enable_beacon, info->beacon_int);
2725  		vp->bcn_en = info->enable_beacon;
2726  		if (data->started &&
2727  		    !hrtimer_active(&link_data->beacon_timer) &&
2728  		    info->enable_beacon) {
2729  			u64 tsf, until_tbtt;
2730  			u32 bcn_int;
2731  			link_data->beacon_int = info->beacon_int * 1024;
2732  			tsf = mac80211_hwsim_get_tsf(hw, vif);
2733  			bcn_int = link_data->beacon_int;
-> 2734  			until_tbtt = bcn_int - do_div(tsf, bcn_int);  // <- bcn_int=0; RSI=0 -> #DE
2735
2736  			hrtimer_start(&link_data->beacon_timer,
2737  				      ns_to_ktime(until_tbtt * NSEC_PER_USEC),
2738  				      HRTIMER_MODE_REL_SOFT);
2739  		} else if (!info->enable_beacon) {
        ...
2748  				link_data->beacon_int = 0;
        ...
2750  		}
2751  	}

2. drv_link_info_changed -- (net/mac80211/driver-ops.c:497)

460  void drv_link_info_changed(struct ieee80211_local *local,
461  			   struct ieee80211_sub_if_data *sdata,
462  			   struct ieee80211_bss_conf *info,
463  			   int link_id, u64 changed)
464  {
        ...
493  	trace_drv_link_info_changed(local, sdata, info, changed);
494  	if (local->ops->link_info_changed)
495  		local->ops->link_info_changed(&local->hw, &sdata->vif,
496  					      info, changed);
-> 497  	else if (local->ops->bss_info_changed)
498  		local->ops->bss_info_changed(&local->hw, &sdata->vif,
499  					     info, changed);
500  	trace_drv_return_void(local);
501  }

3. ieee80211_offchannel_return -- (net/mac80211/offchannel.c:160)

133  void ieee80211_offchannel_return(struct ieee80211_local *local)
134  {
135  	struct ieee80211_sub_if_data *sdata;
136
137  	lockdep_assert_wiphy(local->hw.wiphy);
        ...
142  	list_for_each_entry(sdata, &local->interfaces, list) {
        ...
157  		if (test_and_clear_bit(SDATA_STATE_OFFCHANNEL_BEACON_STOPPED,
158  				       &sdata->state)) {
159  			sdata->vif.bss_conf.enable_beacon = true;
-> 160  			ieee80211_link_info_change_notify(
161  				sdata, &sdata->deflink,
162  				BSS_CHANGED_BEACON_ENABLED);
163  		}
164  	}

4. __ieee80211_scan_completed -- (net/mac80211/scan.c:519)

516  	if (!hw_scan && was_scanning) {
517  		ieee80211_configure_filter(local);
518  		drv_sw_scan_complete(local, scan_sdata);
-> 519  		ieee80211_offchannel_return(local);
520  	}

5. cfg80211_wiphy_work -- (net/wireless/core.c:513)
   (workqueue dispatch point for scan completion)


Tentative Analysis

When a software scan completes, __ieee80211_scan_completed calls
ieee80211_offchannel_return, which iterates active interfaces and
re-enables beaconing for any interface that had its beacon stopped
during the scan. It sets bss_conf.enable_beacon = true and issues
a BSS_CHANGED_BEACON_ENABLED notification, but does NOT update
bss_conf.beacon_int.

This notification reaches mac80211_hwsim_link_info_changed. The
condition at lines 2726-2728 (data->started, timer not active,
enable_beacon) is satisfied, so the function enters the beacon
timer setup block at line 2731. It sets link_data->beacon_int =
info->beacon_int * 1024. When info->beacon_int is zero -- which
syzbot achieved by creating an AP interface with beacon_int=0 --
this produces link_data->beacon_int = 0 and bcn_int = 0 (line
2733). The subsequent do_div(tsf, bcn_int) with a zero divisor
triggers the x86 #DE (divide error) exception (RSI = 0, as
confirmed by the register dump).

An identical do_div(tsf, bcn_int) expression in
mac80211_hwsim_config (mac80211_hwsim.c:2635) is protected by a
guard: "if (!data->started || !link_data->beacon_int)" -- this
guard is absent from the BSS_CHANGED_BEACON_ENABLED path.


Potential Solution

Add a zero check for bcn_int immediately after it is loaded from
link_data->beacon_int (line 2733), before the do_div call. A
beacon interval of zero is invalid; when encountered, return
without starting the timer:

    bcn_int = link_data->beacon_int;
    if (!bcn_int)
        return;
    until_tbtt = bcn_int - do_div(tsf, bcn_int);

This mirrors the guard already present in mac80211_hwsim_config
for the same expression. The Fixes tag for the commit would be:

    Fixes: c51f878379b1 ("mac80211_hwsim: fix beacon timing")


More information

Oops-Analysis: http://oops.fenrus.org/reports/lkml/69efb8dd.050a0220.18b4f.0006.GAE_google.com/
Assisted-by: Copilot:claude-sonnet-4.6 linux-kernel-oops-x86.

