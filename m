Return-Path: <linux-wireless+bounces-35934-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJa7GKQe+mmzJwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35934-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:45:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D70EF4D1935
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 226DB3094391
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D1C494A0D;
	Tue,  5 May 2026 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEgyYUy6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43750492534
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999367; cv=none; b=lYtKvV6h0Hcp5AmtR6Rptdq7gT+7eA+IJJwpoZsYS+hqvhSbNd7C+rIC4Kkcj9Yt0dSiqjVfFJJp/4qID2B31bV3T4Bj+JChzz21MK4lN8SLEYAifJdyhsDZVGr2b8mqOxPUZAfBvPOgcRSUCJc5G6ddtloVGZg0XKwPr6pNNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999367; c=relaxed/simple;
	bh=TISeUMZhza48JetZ9DQ6vU0uKIjFmSwsXz8YTxm2qT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8utzlt+mXVVmUUJBdlMt1r0uZSX9hFvpGn2ls03PH2zmxMr2/CAXlMTZ2bg3gGoZ6Z1iXIhjogvpUNZWRuAciH7az5vESyjce6uSFnPBnF8tEAqDawba1CGnLvVgeT3T+qHmNrDNyR/5ArsWAsuBfEjBmUz54eKeSXQXs5vCg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEgyYUy6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999365; x=1809535365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TISeUMZhza48JetZ9DQ6vU0uKIjFmSwsXz8YTxm2qT0=;
  b=hEgyYUy63JT3J5ERmdVEsMYkn4fetg9JWhxAN7CiOsBA06DXKMzNa7vL
   7Pxor/nEobkGMacduVvjG2xU1hbzj9Nk60ZlLNl//RggGK7scCWMnHN8+
   T/rQKDyrBxDWPsDNjTK+jDrk6rgH8b13hVFpmih4mljmY+gXgmSRuK5rV
   lcB6w7PIBgTINHcz9gnh+ZWqIDWIzDT4B6adpCR3Ju0c2hrUSKefolPIv
   lgNAdvGGIm8ed7v820flHoH5KwQuQ76cS+SDYeMByYRKq6M8v2tjXDtuz
   qFE/sHxeJBkLL90vDjFHl+Ornq/kS4jBiQdv47dLMstR3juFMfoS94iqa
   A==;
X-CSE-ConnectionGUID: 9GSo7scqSrKYkeB6HZOBOQ==
X-CSE-MsgGUID: +Vp97jwHTNyD8AsB4CBuyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898985"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898985"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:45 -0700
X-CSE-ConnectionGUID: fztZjRarTnCqZquZkgLKoQ==
X-CSE-MsgGUID: hv1PGJK/QA6BMcC//mDOXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206412"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH wireless-next 10/14] wifi: mac80211_hwsim: add NAN data path TX/RX support
Date: Tue,  5 May 2026 19:42:15 +0300
Message-Id: <20260505194007.17645ceea970.Ic210f6c095c6ff372941bc8c77ee9c8c37d0356c@changeid>
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
X-Rspamd-Queue-Id: D70EF4D1935
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35934-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
index 16883edd2215..f786694b2932 100644
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
+	if (rx_bw >= ARRAY_SIZE(bw_to_mhz) ||!bw_to_mhz[rx_bw])
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


