Return-Path: <linux-wireless+bounces-35933-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEmAGige+mkJJgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35933-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AECA4D184E
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2805E30234F2
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9E54949FF;
	Tue,  5 May 2026 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcGdLKx6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BBA49252B
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999366; cv=none; b=XhmLIrzywrwGfJQvPk5o6VtC8/l1EpUanM2tNZKbVWyoKQcS2sDZxEbS08FKah9C1TjP4j8TKCf/vQ+TUgxIn6/Sf1jFy4C76r8Kk8pLWLfcyylfUJOwkBTBOwneL/XAj0MzhFwyPrTs0dY2YLBOyVjhqvjOEdRofJdch2nEp+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999366; c=relaxed/simple;
	bh=K1qFXLm0yqvq1YMDCTnqBT0AGwnkq8PWFGjNMbZP+D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mq9BynDyD9I7lXk/jVwoeZQYpv/fVblJlnAk1V8uXwZjNhJNa3lIHkURtzPMaXiO8k1IxKk6qe5hw2fxIpOQfC/8cFpLXXD4Dxy6N9w7X4VMqn1mdN9dp9VfdsDFGvnIaLWJyOeOQQbM7aAtA02xVseiXowhK2V8N9mgZIxa04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcGdLKx6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999364; x=1809535364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1qFXLm0yqvq1YMDCTnqBT0AGwnkq8PWFGjNMbZP+D8=;
  b=jcGdLKx6nyhsoWO15+qalT9rCXr+InkPGcMYqSbDGB660+CzBC/Srj+u
   jEwTv2lTrGNUSzhnV046u5z7vWO5g+JzUtujx4BU83gX+UQL4IVjGuMVW
   1ilAOleAhiNSRdgf++w3Sl7huaPoaWjCiGsodHA/UeXiB5NeM6D6YX5tw
   EmlhycAFVEygS4xO+gRI2csM8HWI5sF8W687HFehSz1/HiM6AloAGW13n
   J2DdGA99Knd6Sh4hWJtwKdU/CvNqLA3zVNmcRZ+FNEZAyfRj2BzaV9REc
   u93OxfuSQLU6zoVlCZEbpkLVpVbvJPHsVd22JbCSMZ1UjvmRnTO90LRUb
   Q==;
X-CSE-ConnectionGUID: iRaKp2MWQySfuR9WGE+ULA==
X-CSE-MsgGUID: 0SoA1f4aTjqzKOzSTiw0lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898984"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898984"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:44 -0700
X-CSE-ConnectionGUID: bqht1m+UTxu8YRMuPhZReA==
X-CSE-MsgGUID: rjZ/M8w9QI6Lgzsv6Qehjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206408"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH wireless-next 09/14] wifi: mac80211_hwsim: set HAS_RATE_CONTROL when using NAN
Date: Tue,  5 May 2026 19:42:14 +0300
Message-Id: <20260505194007.216e68be61ac.If9ef94a12cec8dfc55416afaf745d6e5025a5ec9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
References: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1AECA4D184E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35933-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

From: Daniel Gabay <daniel.gabay@intel.com>

- NAN switches between bands/channels per its schedule, so mac80211
  rate control can't work, set HAS_RATE_CONTROL instead.
- Skip rate control checks for NAN interfaces in
  mac80211_hwsim_sta_rc_update() as it's not relevant.
- Move set_rts_threshold stub to HWSIM_COMMON_OPS and return 0 instead
  of -EOPNOTSUPP to prevent failures in non-MLO tests that set RTS
  threshold (hwsim ignores the use_rts instruction from mac80211
  anyway).

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_main.c    | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 1ea33ec577dd..107d47d31073 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -2747,6 +2747,10 @@ mac80211_hwsim_sta_rc_update(struct ieee80211_hw *hw,
 	u32 bw = U32_MAX;
 	int link_id;
 
+	if (vif->type == NL80211_IFTYPE_NAN ||
+	    vif->type == NL80211_IFTYPE_NAN_DATA)
+		return;
+
 	rcu_read_lock();
 	for (link_id = 0;
 	     link_id < ARRAY_SIZE(vif->link_conf);
@@ -3475,7 +3479,8 @@ static int mac80211_hwsim_tx_last_beacon(struct ieee80211_hw *hw)
 static int mac80211_hwsim_set_rts_threshold(struct ieee80211_hw *hw,
 					    int radio_idx, u32 value)
 {
-	return -EOPNOTSUPP;
+	/* hwsim ignores the use_rts instruction from mac80211 anyway */
+	return 0;
 }
 
 static int mac80211_hwsim_change_vif_links(struct ieee80211_hw *hw,
@@ -4239,6 +4244,7 @@ static int mac80211_hwsim_set_radar_background(struct ieee80211_hw *hw,
 	.abort_pmsr = mac80211_hwsim_abort_pmsr,		\
 	.set_radar_background = mac80211_hwsim_set_radar_background, \
 	.set_key = mac80211_hwsim_set_key,			\
+	.set_rts_threshold = mac80211_hwsim_set_rts_threshold,	\
 	.start_nan = mac80211_hwsim_nan_start,			\
 	.stop_nan = mac80211_hwsim_nan_stop,			\
 	.nan_change_conf = mac80211_hwsim_nan_change_config,	\
@@ -4284,7 +4290,6 @@ static const struct ieee80211_ops mac80211_hwsim_mchan_ops = {
 static const struct ieee80211_ops mac80211_hwsim_mlo_ops = {
 	HWSIM_COMMON_OPS
 	HWSIM_CHANCTX_OPS
-	.set_rts_threshold = mac80211_hwsim_set_rts_threshold,
 	.change_vif_links = mac80211_hwsim_change_vif_links,
 	.change_sta_links = mac80211_hwsim_change_sta_links,
 	.sta_state = mac80211_hwsim_sta_state,
@@ -5726,6 +5731,12 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		hw->wiphy->nan_capa.phy.ht = hwsim_nan_ht_cap;
 		hw->wiphy->nan_capa.phy.vht = hwsim_nan_vht_cap;
 		hw->wiphy->nan_capa.phy.he = hwsim_nan_he_cap;
+
+		/*
+		 * NAN switches between bands/channels per its schedule,
+		 * so mac80211 rate control can't work here.
+		 */
+		ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	}
 
 	data->if_combination.radar_detect_widths =
-- 
2.34.1


