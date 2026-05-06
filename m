Return-Path: <linux-wireless+bounces-35970-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPrHGEq5+mnASAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35970-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 011DB4D5F7F
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D33D303FFE4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 03:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5F12ED141;
	Wed,  6 May 2026 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTW3eA05"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9B22E7F2C
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039093; cv=none; b=KJDLlrCpmngMCmpfmAuhXVb81cF0rpMXslM+RElJeXEENvlr8Maeq/SKLDE1ts1bStaaJXzed3Mev3yhZqCKIsEUvlhOLBFhkBuFl8knttz7YcIiGnOH0Jv3lqQ8vn4Pa53vQJY2AXDs3bgv6JwuwOxetef6rAa8k48AvTyQB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039093; c=relaxed/simple;
	bh=9rFk6sK8Bphu12Kf1flNLsOHh0IumDFoE23qdCHF/XM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AGxdGZKQjmJDf60gldHMQnAFPxPe+dNMYH9vlDgbs7a5tV8nCq+JSugA81YkFKPDL3nJW/kh4/JB3yF3Ju9WrN54MtzJauOwWODvc7i0zS+iH8tD0T8GoltLNzq4fs9faM5U3WVUAUJ4cttoMdUZrpjNjwyG46IcwQYnT8ATSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTW3eA05; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778039092; x=1809575092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9rFk6sK8Bphu12Kf1flNLsOHh0IumDFoE23qdCHF/XM=;
  b=mTW3eA05CONxp2zSl+YvFv060Rks015/iINWUxtsr0PSi4iQCjHwTcXA
   KT02SjOgry2XFdq0p47n1ssUr2RtE5yhNRV6ml/8CfNX9bY6QjzIOEUHx
   1Cbn6EAGtwHUn+0DQAh7UUT3+pEmX7eiTzo2I6jPvVYsM5So+fsfeDch0
   PSsI+AaDROM+BZBfuxToJ58T6jOewI/WTe/cNI0/t5yvV8NWfuyscCkTY
   IjdlPOH6xi2YfJB5mt0a44DSaMIc1SebWIX2h8QaOBXxic4nGUbrUnDqH
   5bQNkxuez2XPiqpvheekzyNT/5jiTGbMtvsDFGWJKCPMGLRlL8kJd46ip
   Q==;
X-CSE-ConnectionGUID: U06r0N3VTkqfbzwcUZX+BQ==
X-CSE-MsgGUID: 2hcDk7a0SzqqitS7G/XTJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82791281"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="82791281"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:52 -0700
X-CSE-ConnectionGUID: cGmavxVmRy+RmBAC7tBraQ==
X-CSE-MsgGUID: NU15VSBIRuKj/mMEp6/bGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="237777761"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 wireless-next 04/14] wifi: mac80211_hwsim: protect tsf_offset using a spinlock
Date: Wed,  6 May 2026 06:44:23 +0300
Message-Id: <20260506064301.18f36f264eb9.I0da5477220b896e2177bd521f7d9a8f2595631e6@changeid>
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
X-Rspamd-Queue-Id: 011DB4D5F7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35970-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

From: Benjamin Berg <benjamin.berg@intel.com>

To implement NAN synchronization in hwsim, the TSF needs to be adjusted
regularly from the RX path. Add a spinlock so that this can be done in a
safe manner.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   |  1 +
 .../wireless/virtual/mac80211_hwsim_main.c    | 34 ++++++++++++++-----
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index 5432de92beab..7a6495ea79e7 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -102,6 +102,7 @@ struct mac80211_hwsim_data {
 	u32 wmediumd;
 
 	/* difference between this hw's clock and the real clock, in usecs */
+	spinlock_t tsf_offset_lock;
 	s64 tsf_offset;
 
 	/* Stats */
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 76f1028bc42e..2de44c5fb1ff 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1256,13 +1256,17 @@ static inline u64 mac80211_hwsim_get_sim_tsf(void)
 ktime_t mac80211_hwsim_tsf_to_boottime(struct mac80211_hwsim_data *data,
 				       u64 tsf)
 {
-	return us_to_ktime(tsf - data->tsf_offset);
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		return us_to_ktime(tsf - data->tsf_offset);
+	}
 }
 
 u64 mac80211_hwsim_boottime_to_tsf(struct mac80211_hwsim_data *data,
 				   ktime_t ts)
 {
-	return ktime_to_us(ts + data->tsf_offset);
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		return ktime_to_us(ts) + data->tsf_offset;
+	}
 }
 
 u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
@@ -1271,14 +1275,18 @@ u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
 	struct mac80211_hwsim_data *data = hw->priv;
 	u64 sim_time = mac80211_hwsim_get_sim_tsf();
 
-	return sim_time + data->tsf_offset;
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		return sim_time + data->tsf_offset;
+	}
 }
 
 static __le64 __mac80211_hwsim_get_tsf(struct mac80211_hwsim_data *data)
 {
 	u64 sim_time = mac80211_hwsim_get_sim_tsf();
 
-	return cpu_to_le64(sim_time + data->tsf_offset);
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		return cpu_to_le64(sim_time + data->tsf_offset);
+	}
 }
 
 static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
@@ -1293,11 +1301,13 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 	if (conf && !conf->enable_beacon)
 		return;
 
-	/* adjust after beaconing with new timestamp at old TBTT */
-	if (tsf > now)
-		data->tsf_offset += delta;
-	else
-		data->tsf_offset -= delta;
+	scoped_guard(spinlock_bh, &data->tsf_offset_lock) {
+		/* adjust after beaconing with new timestamp at old TBTT */
+		if (tsf > now)
+			data->tsf_offset += delta;
+		else
+			data->tsf_offset -= delta;
+	}
 }
 
 static void mac80211_hwsim_monitor_rx(struct ieee80211_hw *hw,
@@ -1577,6 +1587,8 @@ static void mac80211_hwsim_write_tsf(struct mac80211_hwsim_data *data,
 	/* TODO: get MCS */
 	int bitrate = 100;
 
+	spin_lock_bh(&data->tsf_offset_lock);
+
 	txrate = ieee80211_get_tx_rate(data->hw, info);
 	if (txrate)
 		bitrate = txrate->bitrate;
@@ -1602,6 +1614,8 @@ static void mac80211_hwsim_write_tsf(struct mac80211_hwsim_data *data,
 							  10 * 8 * 10 /
 							  bitrate);
 	}
+
+	spin_unlock_bh(&data->tsf_offset_lock);
 }
 
 static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
@@ -5664,6 +5678,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	hw->wiphy->mbssid_max_interfaces = 8;
 	hw->wiphy->ema_max_profile_periodicity = 3;
 
+	spin_lock_init(&data->tsf_offset_lock);
+
 	data->rx_rssi = DEFAULT_RX_RSSI;
 
 	INIT_DELAYED_WORK(&data->roc_start, hw_roc_start);
-- 
2.34.1


