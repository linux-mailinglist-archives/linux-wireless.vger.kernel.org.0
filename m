Return-Path: <linux-wireless+bounces-35975-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIUbC2y5+mnASAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35975-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 878C34D5FA2
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D54D30595B2
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 03:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D472E1EE7;
	Wed,  6 May 2026 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvAh2njS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D46285C8B
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 03:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039099; cv=none; b=Y9CzxhYb9YCa4JoFHmg2lO5GlqYC7FAgIRmEU/FmYz3SQ3oo/dKEWaZbH+x8+BqV+sSJR/qQKcj77ecZuebocZIx0Ean9j6+dt3VYP3Nx2ZNUjbI05vknxEx1RgXgni37tASq5WdGgQbcyTp2MANqQRwZd1/43FkCTDjew5O3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039099; c=relaxed/simple;
	bh=K1qFXLm0yqvq1YMDCTnqBT0AGwnkq8PWFGjNMbZP+D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SzzTF/5lU64rfk/iuxFXL2S8UPJQXX5wwwWSPcFHxNr02d2wpgnbikVyg1XKV64MR8lf1xctn1NrByXqOw2dobxMRKiiUwOnPsM60rZ1vBwnyMH+lOQw9gyaLi4gnh+MTeSwERAhbOv8Twkfew2FhUVj/uK4OUhqvR7iJBMu0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvAh2njS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778039098; x=1809575098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1qFXLm0yqvq1YMDCTnqBT0AGwnkq8PWFGjNMbZP+D8=;
  b=XvAh2njSE+O0aXv6mI+nUV6dI4O+zf6Tcy2CQwOImN0Kw37HShCoJKvU
   ZwIiQ4ykTXtwXGZ5/vzpYkzAoMlzl6QtznM4OIE9cDLxxUam9FpfFwcdV
   h+zn2U2+7fhuz0hp3hYQCqf3qIVtr/OtNxgylj+LK6iMjCaOLLYMNJqYh
   SLkfa9LInvdMNbSwXrMIzntnraxMV51DGd7JVVNxnHKJ3n3O8w3BHt1DT
   y21IW/iew6nbpWs0b38S1jxgu9DnfmI+nfsb+ArRjwuQWRPU9mh7EXG3z
   U5QDUOUGMD27ui+ELCxieVv8ZTO8J086wecxXRp5g0t74dKTcTwmjnE+t
   w==;
X-CSE-ConnectionGUID: yReEGAiYQNOzQXMYg9MxvA==
X-CSE-MsgGUID: JWro76VxQZKxgbrdmt+VYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82791294"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="82791294"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:58 -0700
X-CSE-ConnectionGUID: N9IKuutiTROIckN1onlKxw==
X-CSE-MsgGUID: JTKD0pb/QJ2hHI9XzBJOgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="237777807"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH v2 wireless-next 09/14] wifi: mac80211_hwsim: set HAS_RATE_CONTROL when using NAN
Date: Wed,  6 May 2026 06:44:28 +0300
Message-Id: <20260506064301.216e68be61ac.If9ef94a12cec8dfc55416afaf745d6e5025a5ec9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506034433.3328362-1-miriam.rachel.korenblit@intel.com>
References: <20260506034433.3328362-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 878C34D5FA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35975-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


