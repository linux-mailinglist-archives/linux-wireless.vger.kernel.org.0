Return-Path: <linux-wireless+bounces-35976-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDJaBHa5+mnASAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35976-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 839C04D5FBA
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142E330209D9
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 03:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFBB2DCF52;
	Wed,  6 May 2026 03:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgWgWFXN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E17F28B4FA
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039101; cv=none; b=fKAEW5Fj+pt6XG1eBNHGbLTIsSWS2ijvdn8R/Ojvmjopsyg40q4s18mGu9Rtezq6EWJYlUnTakBfW3Zh1LNqByg2+UP1wlh2bk5Rc6zmTrl6Wu6ag2e7SpbPFWiXWRryO3EtASv4NyLQ9H+vm/2J8WA0mEM1id5T5WeHfVKnwsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039101; c=relaxed/simple;
	bh=byo5Tcjx6fXPoUEgT1jooWotWzVuzCwjnvmJV5bzZRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qY5vNchSetESCyFOg5uW1w23P3rbmiyfNhM2xpSJud5xUYIHDm+6L+PFERT/3yky9XdH2ytvzcwHuZ4nE86ozMbV4cC7wFX0JSt+DyQBx7/+A8Jb/yl0cP5fvwqX5gNcd9Wa1vUWp8zhQrrVNvFjKkeYHfMQSi7tgnnt7chZk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgWgWFXN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778039100; x=1809575100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=byo5Tcjx6fXPoUEgT1jooWotWzVuzCwjnvmJV5bzZRE=;
  b=bgWgWFXNSCLJg+8tkcRQwgoLpqS/epJ6bhrA6NXaXRmnE9yOn/j8czeK
   RUTwn6RqGmgTJ0sJTIGz5/P/lSl/uxqZ43/9BsZfpbw7E0K1fxEJQgOPB
   NDTTTXr7KPJ2kBdcP7aMJofWNhd/+zi23C4gvYxcjUme4rpR47lbYNJJy
   FT3ZuFUu3Xzz+qJm90xv2ss+0Vn2V+5X5akX69XQWI/oYhxmgqzJKbcAq
   4+HDGkD/leb10z/7/PX9rJQZ25U7t4tJcHA5hFVwETldAqNTzzvRlfond
   p7BAiJ01Ejmibo9+4VvkJ7cp3uwz9GkcMQtm16NSyopbajv0hFlXfgn9K
   Q==;
X-CSE-ConnectionGUID: 4y2w2hPlS8S/3cfxFA4mxA==
X-CSE-MsgGUID: d+Ic+fpIQEyoeKspbsQogQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82791298"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="82791298"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:59 -0700
X-CSE-ConnectionGUID: p+fiKmNGTE6sHpZNUf02iQ==
X-CSE-MsgGUID: an0r/jC8SNaGjyr2h4EaXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="237777814"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH v2 wireless-next 10/14] wifi: mac80211_hwsim: add NAN data path TX/RX support
Date: Wed,  6 May 2026 06:44:29 +0300
Message-Id: <20260506064301.155252ebc72b.Ic210f6c095c6ff372941bc8c77ee9c8c37d0356c@changeid>
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
X-Rspamd-Queue-Id: 839C04D5FBA
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
	TAGGED_FROM(0.00)[bounces-35976-lists,linux-wireless=lfdr.de];
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

Implement TX and RX path handling for NAN Data Path (NDP) frames,
enabling data communication between NAN peers during scheduled
availability windows.

TX path:
- Select TX channel based on current time slot: use DW channel
  during Discovery Windows, or FAW channel from local
  schedule during Further Availability Windows.
- Verify peer availability before transmission by checking committed
  DW schedule or FAW of the peer schedule.

RX path:
- Extend NAN receive filtering to handle NAN_DATA interface frames.
- Accept incoming frames during FAW slots when channel matches local
  schedule.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    |  18 +-
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 250 ++++++++++++++++--
 .../net/wireless/virtual/mac80211_hwsim_nan.h |   4 +-
 3 files changed, 243 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 107d47d31073..66cc8c528c6b 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1744,7 +1744,8 @@ static void mac80211_hwsim_tx_iter(void *_data, u8 *addr,
 	struct tx_iter_data *data = _data;
 	int i;
 
-	if (vif->type == NL80211_IFTYPE_NAN) {
+	if (vif->type == NL80211_IFTYPE_NAN ||
+	    vif->type == NL80211_IFTYPE_NAN_DATA) {
 		data->receive = mac80211_hwsim_nan_receive(data->hw,
 							   data->channel,
 							   data->rx_status);
@@ -2093,13 +2094,19 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	/* re-assign hdr since skb data may have shifted after encryption */
 	hdr = (void *)skb->data;
 
-	if (vif && vif->type == NL80211_IFTYPE_NAN && !data->tmp_chan) {
-		channel = mac80211_hwsim_nan_get_tx_channel(hw);
+	if (vif && !data->tmp_chan &&
+	    (vif->type == NL80211_IFTYPE_NAN ||
+	     vif->type == NL80211_IFTYPE_NAN_DATA)) {
+		struct cfg80211_chan_def chandef;
 
-		if (WARN_ON(!channel)) {
+		mac80211_hwsim_nan_get_tx_chandef(hw, &chandef);
+		if (WARN_ON(!chandef.chan)) {
+			/* No valid channel in current slot, drop frame */
 			ieee80211_free_txskb(hw, skb);
 			return;
 		}
+		channel = chandef.chan;
+		confbw = chandef.width;
 	} else if (!data->use_chanctx) {
 		channel = data->channel;
 		confbw = data->bw;
@@ -2249,7 +2256,8 @@ void ieee80211_hwsim_wake_tx_queue(struct ieee80211_hw *hw,
 	};
 	struct sk_buff *skb;
 
-	if (txq->vif->type == NL80211_IFTYPE_NAN &&
+	if ((txq->vif->type == NL80211_IFTYPE_NAN ||
+	     txq->vif->type == NL80211_IFTYPE_NAN_DATA) &&
 	    !mac80211_hwsim_nan_txq_transmitting(hw, txq))
 		return;
 
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index 16883edd2215..0397c43724fe 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
@@ -36,6 +36,11 @@ static_assert(DW0_TSF_MASK + 1 == 8192 * 1024);
 /* Quiet time at the end of each slot where TX is suppressed */
 #define NAN_CHAN_SWITCH_TIME_US		256
 
+struct hwsim_nan_sta_iter_ctx {
+	struct ieee80211_hw *hw;
+	bool can_tx;
+};
+
 static void mac80211_hwsim_nan_resume_txqs(struct mac80211_hwsim_data *data);
 
 static u64 hwsim_nan_get_timer_tsf(struct mac80211_hwsim_data *data)
@@ -77,6 +82,109 @@ static u64 hwsim_nan_get_master_rank(struct mac80211_hwsim_data *data)
 					    data->nan.device_vif->addr);
 }
 
+static bool mac80211_hwsim_nan_is_dw_slot(struct mac80211_hwsim_data *data,
+					  u8 slot)
+{
+	return slot == SLOT_24GHZ_DW ||
+		(slot == SLOT_5GHZ_DW &&
+		 (data->nan.bands & BIT(NL80211_BAND_5GHZ)));
+}
+
+static bool
+hwsim_nan_rx_chandef_compatible(struct mac80211_hwsim_data *data, u8 slot,
+				struct ieee80211_channel *rx_chan, u8 rx_bw)
+{
+	static const int bw_to_mhz[] = {
+		[RATE_INFO_BW_20] = 20, [RATE_INFO_BW_40] = 40,
+		[RATE_INFO_BW_80] = 80, [RATE_INFO_BW_160] = 160,
+	};
+	struct cfg80211_chan_def sched_chandef;
+	int rx_mhz, sched_mhz;
+
+	scoped_guard(spinlock_bh, &data->nan.state_lock)
+		sched_chandef = data->nan.local_sched[slot];
+
+	if (!sched_chandef.chan ||
+	    sched_chandef.chan->center_freq != rx_chan->center_freq)
+		return false;
+
+	if (rx_bw >= ARRAY_SIZE(bw_to_mhz) || !bw_to_mhz[rx_bw])
+		return false;
+
+	rx_mhz = bw_to_mhz[rx_bw];
+	sched_mhz = cfg80211_chandef_get_width(&sched_chandef);
+
+	/* Accept RX at narrower or equal bandwidth */
+	return rx_mhz <= sched_mhz;
+}
+
+static bool hwsim_nan_peer_present_in_dw(struct hwsim_sta_priv *sp, u64 tsf)
+{
+	u8 slot = hwsim_nan_slot_from_tsf(tsf);
+	u8 cdw = 0;
+	u8 dw_index, wake_interval;
+	u16 committed_dw;
+
+	scoped_guard(spinlock_bh, &sp->nan_sched.lock)
+		committed_dw = sp->nan_sched.committed_dw;
+
+	/* If peer doesn't advertise committed DW, assume presence in
+	 * all 2.4 GHz DW slots
+	 */
+	if (!committed_dw)
+		return slot == SLOT_24GHZ_DW;
+
+	/* Get DW index (0-15) within the 16-DWST DW0 cycle */
+	dw_index = (tsf / ieee80211_tu_to_usec(DWST_TU)) & 0xf;
+
+	/* Extract CDW for the appropriate band (spec Table 80) */
+	if (slot == SLOT_24GHZ_DW)
+		cdw = committed_dw & 0x7;
+	else if (slot == SLOT_5GHZ_DW)
+		cdw = (committed_dw >> 3) & 0x7;
+
+	if (cdw == 0)
+		return false;
+
+	/* Peer wakes every 2^(cdw-1) DWs: 1, 2, 4, 8, or 16 */
+	wake_interval = 1 << (cdw - 1);
+
+	return (dw_index % wake_interval) == 0;
+}
+
+static bool
+hwsim_nan_peer_present_in_faw(struct hwsim_sta_priv *sp,
+			      struct mac80211_hwsim_data *data, u8 slot)
+{
+	struct cfg80211_chan_def local_chandef;
+
+	scoped_guard(spinlock_bh, &data->nan.state_lock)
+		local_chandef = data->nan.local_sched[slot];
+
+	if (!local_chandef.chan)
+		return false;
+
+	scoped_guard(spinlock_bh, &sp->nan_sched.lock) {
+		for (int i = 0; i < CFG80211_NAN_MAX_PEER_MAPS; i++) {
+			struct cfg80211_chan_def *peer_chandef;
+
+			if (sp->nan_sched.maps[i].map_id ==
+			    CFG80211_NAN_INVALID_MAP_ID)
+				continue;
+
+			peer_chandef = &sp->nan_sched.maps[i].chans[slot];
+			if (!peer_chandef->chan)
+				continue;
+
+			if (cfg80211_chandef_compatible(&local_chandef,
+							peer_chandef))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static void
 mac80211_hwsim_nan_schedule_slot(struct mac80211_hwsim_data *data, u8 slot,
 				 bool discontinuity)
@@ -880,15 +988,65 @@ int mac80211_hwsim_nan_change_config(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static void hwsim_nan_can_sta_transmit(void *_ctx, struct ieee80211_sta *sta)
+{
+	struct hwsim_nan_sta_iter_ctx *ctx = _ctx;
+
+	if (ctx->can_tx)
+		return;
+
+	for (int i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		struct ieee80211_txq *txq = sta->txq[i];
+
+		if (!txq)
+			continue;
+
+		if (txq->vif->type != NL80211_IFTYPE_NAN &&
+		    txq->vif->type != NL80211_IFTYPE_NAN_DATA)
+			return;
+
+		if (mac80211_hwsim_nan_txq_transmitting(ctx->hw, txq)) {
+			ctx->can_tx = true;
+			return;
+		}
+	}
+}
+
 static void mac80211_hwsim_nan_resume_txqs(struct mac80211_hwsim_data *data)
 {
+	u64 tsf = mac80211_hwsim_get_tsf(data->hw, data->nan.device_vif);
+	u8 slot = hwsim_nan_slot_from_tsf(tsf);
+	bool is_dw_slot = mac80211_hwsim_nan_is_dw_slot(data, slot);
+	struct hwsim_nan_sta_iter_ctx ctx = {
+		.hw = data->hw,
+		.can_tx = false,
+	};
 	u32 timeout_ns;
 
-	/* Nothing to do if we are not in a DW */
-	if (!mac80211_hwsim_nan_txq_transmitting(data->hw,
-						 data->nan.device_vif->txq_mgmt))
+	/* Outside DW, require local FAW schedule to proceed */
+	if (!is_dw_slot) {
+		scoped_guard(spinlock_bh, &data->nan.state_lock) {
+			if (!data->nan.local_sched[slot].chan)
+				return;
+		}
+	}
+
+	guard(rcu)();
+
+	/* Check if management queue can transmit */
+	if (mac80211_hwsim_nan_txq_transmitting(data->hw,
+						data->nan.device_vif->txq_mgmt))
+		goto resume_txqs_timer;
+
+	/* Check if any STA queue can transmit */
+	ieee80211_iterate_stations_atomic(data->hw,
+					  hwsim_nan_can_sta_transmit,
+					  &ctx);
+
+	if (!ctx.can_tx)
 		return;
 
+resume_txqs_timer:
 	/*
 	 * Wait a bit and also randomize things so that not everyone is TXing
 	 * at the same time. Each slot is 16 TU long, this waits between 100 us
@@ -902,6 +1060,26 @@ static void mac80211_hwsim_nan_resume_txqs(struct mac80211_hwsim_data *data)
 		      HRTIMER_MODE_REL_SOFT);
 }
 
+static void hwsim_nan_wake_sta_iter(void *_data, struct ieee80211_sta *sta)
+{
+	struct ieee80211_hw *hw = _data;
+
+	for (int i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		struct ieee80211_txq *txq = sta->txq[i];
+
+		if (!txq)
+			continue;
+
+		/* exit early if non-NAN */
+		if (txq->vif->type != NL80211_IFTYPE_NAN &&
+		    txq->vif->type != NL80211_IFTYPE_NAN_DATA)
+			return;
+
+		if (mac80211_hwsim_nan_txq_transmitting(hw, txq))
+			ieee80211_hwsim_wake_tx_queue(hw, txq);
+	}
+}
+
 enum hrtimer_restart
 mac80211_hwsim_nan_resume_txqs_timer(struct hrtimer *timer)
 {
@@ -917,6 +1095,11 @@ mac80211_hwsim_nan_resume_txqs_timer(struct hrtimer *timer)
 		ieee80211_hwsim_wake_tx_queue(data->hw,
 					      data->nan.device_vif->txq_mgmt);
 
+	/* Wake TX queues for all stations */
+	ieee80211_iterate_stations_atomic(data->hw,
+					  hwsim_nan_wake_sta_iter,
+					  data->hw);
+
 	return HRTIMER_NORESTART;
 }
 
@@ -924,6 +1107,9 @@ bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
 					 struct ieee80211_txq *txq)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
+	struct ieee80211_sta *nmi_sta;
+	struct hwsim_sta_priv *sp;
+	bool is_dw_slot;
 	u64 tsf;
 	u8 slot;
 
@@ -937,36 +1123,54 @@ bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
 	if (slot != hwsim_nan_slot_from_tsf(tsf + NAN_CHAN_SWITCH_TIME_US))
 		return false;
 
-	/* Check NAN device interface management frame transmission */
-	if (!txq->sta) {
-		/* Only transmit these during one of the DWs */
-		if (slot == SLOT_24GHZ_DW ||
-		    (slot == SLOT_5GHZ_DW &&
-		     (data->nan.bands & BIT(NL80211_BAND_5GHZ))))
-			return true;
+	is_dw_slot = mac80211_hwsim_nan_is_dw_slot(data, slot);
 
-		return false;
+	/* Non-STA TXQ: allow management frames during DW */
+	if (!txq->sta)
+		return is_dw_slot;
+
+	/* STA TXQ: need peer schedule for availability check */
+	nmi_sta = rcu_dereference(txq->sta->nmi) ?: txq->sta;
+	sp = (void *)nmi_sta->drv_priv;
+
+	/* DW slot: NDI can TX only mgmt but not worth checking,
+	 * NMI checks peer's committed DW
+	 */
+	if (is_dw_slot) {
+		if (txq->vif->type == NL80211_IFTYPE_NAN_DATA)
+			return false;
+		return hwsim_nan_peer_present_in_dw(sp, tsf);
 	}
 
-	return true;
+	/* FAW slot: verify local schedule and peer availability */
+	return hwsim_nan_peer_present_in_faw(sp, data, slot);
 }
 
-struct ieee80211_channel *
-mac80211_hwsim_nan_get_tx_channel(struct ieee80211_hw *hw)
+void mac80211_hwsim_nan_get_tx_chandef(struct ieee80211_hw *hw,
+				       struct cfg80211_chan_def *chandef)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
 	u64 tsf = mac80211_hwsim_get_tsf(data->hw, data->nan.device_vif);
 	u8 slot = hwsim_nan_slot_from_tsf(tsf);
 
-	if (slot == SLOT_24GHZ_DW)
-		return ieee80211_get_channel(hw->wiphy, 2437);
+	/* DW slots are always 20 MHz */
+	if (slot == SLOT_24GHZ_DW) {
+		cfg80211_chandef_create(chandef,
+					ieee80211_get_channel(hw->wiphy, 2437),
+					NL80211_CHAN_NO_HT);
+		return;
+	}
 
-	if (slot == SLOT_5GHZ_DW &&
-	    data->nan.bands & BIT(NL80211_BAND_5GHZ))
-		return ieee80211_get_channel(hw->wiphy, 5745);
+	if (slot == SLOT_5GHZ_DW && data->nan.bands & BIT(NL80211_BAND_5GHZ)) {
+		cfg80211_chandef_create(chandef,
+					ieee80211_get_channel(hw->wiphy, 5745),
+					NL80211_CHAN_NO_HT);
+		return;
+	}
 
-	/* drop frame and warn, NAN_CHAN_SWITCH_TIME_US should avoid races */
-	return NULL;
+	/* FAW slot: copy local schedule for this slot */
+	scoped_guard(spinlock_bh, &data->nan.state_lock)
+		*chandef = data->nan.local_sched[slot];
 }
 
 bool mac80211_hwsim_nan_receive(struct ieee80211_hw *hw,
@@ -1006,7 +1210,9 @@ bool mac80211_hwsim_nan_receive(struct ieee80211_hw *hw,
 	    channel->center_freq == 5745)
 		return true;
 
-	return false;
+	/* Accept frames during FAW slots if chandef is compatible */
+	return hwsim_nan_rx_chandef_compatible(data, slot, channel,
+					       rx_status->bw);
 }
 
 void mac80211_hwsim_nan_local_sched_changed(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
index eb53bacee206..81e105ac7b8e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
@@ -86,8 +86,8 @@ int mac80211_hwsim_nan_peer_sched_changed(struct ieee80211_hw *hw,
 bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
 					 struct ieee80211_txq *txq);
 
-struct ieee80211_channel *
-mac80211_hwsim_nan_get_tx_channel(struct ieee80211_hw *hw);
+void mac80211_hwsim_nan_get_tx_chandef(struct ieee80211_hw *hw,
+				       struct cfg80211_chan_def *chandef);
 
 bool mac80211_hwsim_nan_receive(struct ieee80211_hw *hw,
 				struct ieee80211_channel *channel,
-- 
2.34.1


