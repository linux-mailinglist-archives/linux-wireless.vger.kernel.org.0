Return-Path: <linux-wireless+bounces-30507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1402CFE55C
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4D6D3039850
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEEC3446C2;
	Wed,  7 Jan 2026 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jeS8WoAc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987C3345CAE
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795860; cv=none; b=Xu5/S+olibiAzYvtORUxVsUwRFebsbsij+jsQiwYsDMUb0j3v5zcOY/RyK/MjSdi69kDkgGynKt3VVtGF49JZDQ5TGWg7jKOObJFbRX2rYhKyMDU3SwquPmz68dKAidWpBAT3aF+r7ZD2X/eLU9D11F1cQtU/rmy+UBkDAv80AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795860; c=relaxed/simple;
	bh=8aP5Pp1+413gM3AvDtAKakF5HpY1RbGBSGmbhotOGzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpqPgX90euwGuI5oY9Kwkr8g8qgxvwriwXBU5W3GXe6rUwl/tECM0c1gauPHu+3BzJvV5rp00SM2C4g0O3CW+Jmmb7Q3B89Lom0mXUF2G90ICLkLlQxHV8fjzh2VNtAYodT9k1W3QvO/scrrAjMPwFLCMuPZW5mu3ssrUHUjI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jeS8WoAc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MU+W/kowWH1EvSP+82PZ6A/nntvl4NRfDMOOT0w1Bx8=;
	t=1767795858; x=1769005458; b=jeS8WoAcwZ2cMtME0IIflwxLJzmkE3ojqZ/QvDZ8O9KfXho
	88HPrMtJlIf0aewVyOfZckhFcmpDEXtAMylWH10rb//r6P5aP0t5b//w5INijITxrrhFNJQzYk+sQ
	4wJqy65MMLWks9gY+H9png0dglNfPLvm4RLmZgRT7F+0F+Xde7OOVdQCmJCHXZkPn+k6bd2rkS6UN
	bwqSNjQP3iNnyKKEerYLYbNDP9EipmgvpOol64iYX83ZsKeuYJBraNRXrOHNnsHzDbn55rb3pzoL9
	4a3AnZZHSwLqvI25WryYQRT8gSOPZpoXLBK0Z2olluu0c8RShIl1kFcrtrK8AHrg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSN-00000005agF-1IEO;
	Wed, 07 Jan 2026 15:24:15 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 45/46] wifi: mac80211_hwsim: add NAN data path TX/RX support
Date: Wed,  7 Jan 2026 15:22:44 +0100
Message-ID: <20260107152325.57026ee76d95.Ic210f6c095c6ff372941bc8c77ee9c8c37d0356c@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    |  18 +-
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 254 ++++++++++++++++--
 .../net/wireless/virtual/mac80211_hwsim_nan.h |   4 +-
 3 files changed, 245 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 9db4eac5959d..ced1b4fd0dd7 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1607,7 +1607,8 @@ static void mac80211_hwsim_tx_iter(void *_data, u8 *addr,
 	struct tx_iter_data *data = _data;
 	int i;
 
-	if (vif->type == NL80211_IFTYPE_NAN) {
+	if (vif->type == NL80211_IFTYPE_NAN ||
+	    vif->type == NL80211_IFTYPE_NAN_DATA) {
 		data->receive = mac80211_hwsim_nan_receive(data->hw,
 							   data->channel,
 							   data->rx_status);
@@ -1927,13 +1928,19 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		return;
 	}
 
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
@@ -2076,7 +2083,8 @@ void ieee80211_hwsim_wake_tx_queue(struct ieee80211_hw *hw,
 	};
 	struct sk_buff *skb;
 
-	if (txq->vif->type == NL80211_IFTYPE_NAN &&
+	if ((txq->vif->type == NL80211_IFTYPE_NAN ||
+	     txq->vif->type == NL80211_IFTYPE_NAN_DATA) &&
 	    !mac80211_hwsim_nan_txq_transmitting(hw, txq))
 		return;
 
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index 46a7bcfc923a..5bd33ddb43e5 100644
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
@@ -885,15 +993,65 @@ int mac80211_hwsim_nan_change_config(struct ieee80211_hw *hw,
 	return 0;
 }
 
-static void mac80211_hwsim_nan_resume_txqs(struct mac80211_hwsim_data *data)
+static void hwsim_nan_can_sta_transmit(void *_ctx, struct ieee80211_sta *sta)
 {
-	u32 timeout_ns;
+	struct hwsim_nan_sta_iter_ctx *ctx = _ctx;
 
-	/* Nothing to do if we are not in a DW */
-	if (!mac80211_hwsim_nan_txq_transmitting(data->hw,
-						 data->nan.device_vif->txq_mgmt))
+	if (ctx->can_tx)
 		return;
 
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
+static void mac80211_hwsim_nan_resume_txqs(struct mac80211_hwsim_data *data)
+{
+	u64 tsf = mac80211_hwsim_get_tsf(data->hw, data->nan.device_vif);
+	u8 slot = hwsim_nan_slot_from_tsf(tsf);
+	bool is_dw_slot = mac80211_hwsim_nan_is_dw_slot(data, slot);
+	struct hwsim_nan_sta_iter_ctx ctx = {
+		.hw = data->hw,
+		.can_tx = false,
+	};
+	u32 timeout_ns;
+
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
+		return;
+
+resume_txqs_timer:
 	/*
 	 * Wait a bit and also randomize things so that not everyone is TXing
 	 * at the same time. Each slot is 16 TU long, this waits between 100 us
@@ -907,6 +1065,26 @@ static void mac80211_hwsim_nan_resume_txqs(struct mac80211_hwsim_data *data)
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
@@ -922,6 +1100,11 @@ mac80211_hwsim_nan_resume_txqs_timer(struct hrtimer *timer)
 		ieee80211_hwsim_wake_tx_queue(data->hw,
 					      data->nan.device_vif->txq_mgmt);
 
+	/* Wake TX queues for all stations */
+	ieee80211_iterate_stations_atomic(data->hw,
+					  hwsim_nan_wake_sta_iter,
+					  data->hw);
+
 	return HRTIMER_NORESTART;
 }
 
@@ -929,6 +1112,9 @@ bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
 					 struct ieee80211_txq *txq)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
+	struct ieee80211_sta *nmi_sta;
+	struct hwsim_sta_priv *sp;
+	bool is_dw_slot;
 	u64 tsf;
 	u8 slot;
 
@@ -942,36 +1128,54 @@ bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
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
@@ -1011,7 +1215,9 @@ bool mac80211_hwsim_nan_receive(struct ieee80211_hw *hw,
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
2.52.0


