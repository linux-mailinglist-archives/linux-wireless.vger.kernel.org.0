Return-Path: <linux-wireless+bounces-29409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE0C924C8
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 305E934FD04
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709DA331203;
	Fri, 28 Nov 2025 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AvRhZuBh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FB0330D32
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339674; cv=none; b=UwqKuGrKdx+3Faj3svJRsyfBVtWRZ9XtvUEYbG9orwy9P0PtrKg4hIHI7sFEkIYcZudEB/28zGutPNmvI3voet3suHqYniD8Og0LvpWoYuYI3DS4i6XbptYjmAx4A2hC4dnVV3kR+aCMaM+SGt8rGN9NNXTxCLzjIePmKfujJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339674; c=relaxed/simple;
	bh=g+9drbo1M6+3Gz+t7zNOrYPu7AO1F5Yv28M8S5SNILE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phqQ4ut/DzpgLs3PPlNuj/mhKEQmcNfRcEdpdiKzV6ntVzfZ9jVEwhNGsL25gq6L+lDub6L9+8SvS2pETeqaEzLRBYtZngllD3IRHa5XUCOJTIzRDOEUgU84FSCw41nBnTXLghPFQXAeY4fjITnCKrc6AUtmxiSjzgA1SdkLOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AvRhZuBh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V3RVAM+0QtBNMpnxDn2UjLo1dy+uhtH4/ok4t63q9T0=;
	t=1764339672; x=1765549272; b=AvRhZuBhmvaHqHpgbw8VPxVVVq6kDVjFZG5oTqvyxhKAwrn
	sgHhTYH8twQ3OLre+FH0J1IA0mAh3WOUpv5fG67Ns90D4acOacCMZqDmwKMpjSHnx3CslqkZkrELb
	8iWm9EZ12k0DyJEPnVRdcyl3HTYPwgfbKV1wtm59nJotb8F5cxf9UiGFBKDOw5TdhrlXcQCYrEtSj
	lSiN188L3BOCyaITvmxTbtJOke+bHMGdF4Iom2xwb/oDloZIDajQkZD7cOs3IJ3l79IUVTiWKBtfI
	pJqahjAM4sh1WeTmz5G3do3ccXgyBelUlBdWh4z4vGzd7jhV78zBFGiXevagpdww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLQ-00000003926-3nJb;
	Fri, 28 Nov 2025 15:21:09 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 09/18] wifi: mac80211_hwsim: refactor NAN timer handling
Date: Fri, 28 Nov 2025 15:15:47 +0100
Message-ID: <20251128151537.8a571bc2002c.I46da3cabea8624ba2e6c91bd2afecd2dc6553c5a@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251128141537.287627-20-benjamin@sipsolutions.net>
References: <20251128141537.287627-20-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Refactor the NAN timer to more closely track the where in the NAN
schedule the device currently is. Do this by having an hrtimer that
fires at the start of every slot.

For now continue to update the current channel at the start of the DW.
In the future, the correct channel according to the schedule should be
used everywhere.

This is in preparation to more accurately simulate more of the NAN
logic.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   |   5 +
 .../wireless/virtual/mac80211_hwsim_main.c    |  22 +--
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 160 ++++++++++++------
 .../net/wireless/virtual/mac80211_hwsim_nan.h |   8 +-
 4 files changed, 133 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index 87d5e7c2b643..890bf8ac064a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -127,6 +127,11 @@ struct mac80211_hwsim_data {
 extern spinlock_t hwsim_radio_lock;
 extern struct list_head hwsim_radios;
 
+ktime_t mac80211_hwsim_tsf_to_boottime(struct mac80211_hwsim_data *data,
+				       u64 tsf);
+u64 mac80211_hwsim_boottime_to_tsf(struct mac80211_hwsim_data *data,
+				   ktime_t ts);
+
 u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif);
 
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 43b969592d44..d6b4a80452b5 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1116,12 +1116,18 @@ static inline u64 mac80211_hwsim_get_sim_tsf(void)
 	return ktime_to_us(ktime_get_boottime());
 }
 
-static ktime_t mac80211_hwsim_tsf_to_boottime(struct mac80211_hwsim_data *data,
-					      u64 tsf)
+ktime_t mac80211_hwsim_tsf_to_boottime(struct mac80211_hwsim_data *data,
+				       u64 tsf)
 {
 	return us_to_ktime(tsf - data->tsf_offset);
 }
 
+u64 mac80211_hwsim_boottime_to_tsf(struct mac80211_hwsim_data *data,
+				   ktime_t ts)
+{
+	return ktime_to_us(ts + data->tsf_offset);
+}
+
 u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif)
 {
@@ -1916,12 +1922,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		 * on channel 6 or channel 149, unless a ROC is in progress (for
 		 * USD use cases).
 		 */
-		if (data->nan.curr_dw_band == NL80211_BAND_2GHZ)
-			channel = ieee80211_get_channel(hw->wiphy, 2437);
-		else if (data->nan.curr_dw_band == NL80211_BAND_5GHZ)
-			channel = ieee80211_get_channel(hw->wiphy, 5745);
-		else
-			channel = NULL;
+		channel = data->nan.channel;
 
 		if (WARN_ON(!channel)) {
 			ieee80211_free_txskb(hw, skb);
@@ -5252,8 +5253,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
 			NAN_DEV_CAPA_NDPE_SUPPORTED;
 
-		hrtimer_setup(&data->nan.timer, mac80211_hwsim_nan_dw_start,
-			      CLOCK_MONOTONIC, HRTIMER_MODE_ABS_SOFT);
+		hrtimer_setup(&data->nan.slot_timer,
+			      mac80211_hwsim_nan_slot_timer,
+			      CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
 	}
 
 	data->if_combination.radar_detect_widths =
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index 5d7c736d7972..f4191954ca9d 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
@@ -6,63 +6,132 @@
 
 #include "mac80211_hwsim_i.h"
 
+/* Defined as the lower 23 bits being zero */
+#define DW0_TSF_MASK		GENMASK(22, 0)
+
+/* DWs are repeated every 512 TUs */
+#define DWST_TU			512
+#define DWST_TSF_MASK		(ieee80211_tu_to_usec(DWST_TU) - 1)
+
+#define SLOT_TU			16
+#define SLOT_TSF_MASK		(ieee80211_tu_to_usec(DWST_TU) - 1)
+
+/* The 2.4 GHz DW is at the start, the 5 GHz is in slot 8 (after 128 TUs) */
+#define DW_5G_OFFSET_TU		128
+
+#define SLOT_24GHZ_DW		0
+#define SLOT_5GHZ_DW		(DW_5G_OFFSET_TU / SLOT_TU)
+
+/* The special DW0 happens every 16 DWSTs (8192 TUs) */
+static_assert(16 * DWST_TU * 1024 == 8192 * 1024);
+static_assert(DW0_TSF_MASK + 1 == 8192 * 1024);
+
 static u8 hwsim_nan_cluster_id[ETH_ALEN];
 
+static u64 hwsim_nan_get_timer_tsf(struct mac80211_hwsim_data *data)
+{
+	ktime_t expires = hrtimer_get_expires(&data->nan.slot_timer);
+
+	return mac80211_hwsim_boottime_to_tsf(data, expires);
+}
+
+static u8 hwsim_nan_slot_from_tsf(u64 tsf)
+{
+	return (tsf & DWST_TSF_MASK) / ieee80211_tu_to_usec(SLOT_TU);
+}
+
+static void
+mac80211_hwsim_nan_schedule_slot(struct mac80211_hwsim_data *data, u8 slot)
+{
+	u64 tsf = hwsim_nan_get_timer_tsf(data);
+
+	/* Only called by mac80211_hwsim_nan_dw_timer from softirq context */
+	lockdep_assert_in_softirq();
+
+	tsf &= ~DWST_TSF_MASK;
+	tsf += ieee80211_tu_to_usec(slot * SLOT_TU);
+
+	hrtimer_set_expires(&data->nan.slot_timer,
+			    mac80211_hwsim_tsf_to_boottime(data, tsf));
+}
+
+static void
+mac80211_hwsim_nan_exec_state_transitions(struct mac80211_hwsim_data *data)
+{
+	/*
+	 * Handle NAN role and state transitions at the end of the DW period
+	 * in accordance to Wi-Fi Aware version 4.0 section 3.3.7 point 2, i.e.
+	 * end of 5 GHz DW if enabled else at the end of the 2.4 GHz DW.
+	 *
+	 * TODO: Implement
+	 */
+}
+
 enum hrtimer_restart
-mac80211_hwsim_nan_dw_start(struct hrtimer *timer)
+mac80211_hwsim_nan_slot_timer(struct hrtimer *timer)
 {
 	struct mac80211_hwsim_data *data =
 		container_of(timer, struct mac80211_hwsim_data,
-			     nan.timer);
+			     nan.slot_timer);
 	struct ieee80211_hw *hw = data->hw;
-	u64 orig_tsf = mac80211_hwsim_get_tsf(hw, NULL), tsf = orig_tsf;
-	u32 dw_int = 512 * 1024;
-	u64 until_dw;
+	struct ieee80211_channel *notify_dw_chan = NULL;
+	u64 tsf = hwsim_nan_get_timer_tsf(data);
+	u8 slot = hwsim_nan_slot_from_tsf(tsf);
+	bool dwst_of_dw0 = false;
+	bool dw_end = false;
 
 	if (!data->nan.device_vif)
 		return HRTIMER_NORESTART;
 
-	if (data->nan.bands & BIT(NL80211_BAND_5GHZ)) {
-		if (data->nan.curr_dw_band == NL80211_BAND_2GHZ) {
-			dw_int = 128 * 1024;
-			data->nan.curr_dw_band = NL80211_BAND_5GHZ;
-		} else if (data->nan.curr_dw_band == NL80211_BAND_5GHZ) {
-			data->nan.curr_dw_band = NL80211_BAND_2GHZ;
-		}
-	}
+	if ((tsf & DW0_TSF_MASK & ~DWST_TSF_MASK) == 0)
+		dwst_of_dw0 = true;
 
-	until_dw = dw_int - do_div(tsf, dw_int);
 
-	/* The timer might fire just before the actual DW, in which case
-	 * update the timeout to the actual next DW
-	 */
-	if (until_dw < dw_int / 2)
-		until_dw += dw_int;
+	switch (slot) {
+	case SLOT_24GHZ_DW:
+		wiphy_dbg(data->hw->wiphy, "Start of 2.4 GHz DW, is DW0=%d\n",
+			  dwst_of_dw0);
+		data->nan.channel = ieee80211_get_channel(hw->wiphy, 2437);
+		break;
 
-	/* The above do_div() call directly modifies the 'tsf' variable, thus,
-	 * use a copy so that the print below would show the original TSF.
-	 */
-	wiphy_debug(hw->wiphy,
-		    "%s: tsf=%llx, curr_dw_band=%u, next_dw=%llu\n",
-		    __func__, orig_tsf, data->nan.curr_dw_band,
-		    until_dw);
+	case SLOT_24GHZ_DW + 1:
+		if (!(data->nan.bands & BIT(NL80211_BAND_5GHZ))) {
+			notify_dw_chan = ieee80211_get_channel(hw->wiphy, 2437);
+			dw_end = true;
+		} else {
+			notify_dw_chan = ieee80211_get_channel(hw->wiphy, 5745);
+		}
+		break;
 
-	hrtimer_forward_now(&data->nan.timer,
-			    ns_to_ktime(until_dw * NSEC_PER_USEC));
+	case SLOT_5GHZ_DW:
+		if (data->nan.bands & BIT(NL80211_BAND_5GHZ)) {
+			wiphy_dbg(data->hw->wiphy, "Start of 5 GHz DW\n");
+			data->nan.channel =
+				ieee80211_get_channel(hw->wiphy, 5745);
+		}
+		break;
+
+	case SLOT_5GHZ_DW + 1:
+		if (data->nan.bands & BIT(NL80211_BAND_5GHZ)) {
+			notify_dw_chan =
+				ieee80211_get_channel(hw->wiphy, 2437);
+			dw_end = true;
+		}
+		break;
+	}
+
+	if (dw_end)
+		mac80211_hwsim_nan_exec_state_transitions(data);
 
-	if (data->nan.notify_dw) {
-		struct ieee80211_channel *ch;
+	if (data->nan.notify_dw && notify_dw_chan) {
 		struct wireless_dev *wdev =
 			ieee80211_vif_to_wdev(data->nan.device_vif);
 
-		if (data->nan.curr_dw_band == NL80211_BAND_5GHZ)
-			ch = ieee80211_get_channel(hw->wiphy, 5745);
-		else
-			ch = ieee80211_get_channel(hw->wiphy, 2437);
-
-		cfg80211_next_nan_dw_notif(wdev, ch, GFP_ATOMIC);
+		cfg80211_next_nan_dw_notif(wdev, notify_dw_chan, GFP_ATOMIC);
 	}
 
+	mac80211_hwsim_nan_schedule_slot(data, slot + 1);
+
 	return HRTIMER_RESTART;
 }
 
@@ -71,9 +140,6 @@ int mac80211_hwsim_nan_start(struct ieee80211_hw *hw,
 			     struct cfg80211_nan_conf *conf)
 {
 	struct mac80211_hwsim_data *data = hw->priv;
-	u64 tsf = mac80211_hwsim_get_tsf(hw, NULL);
-	u32 dw_int = 512 * 1000;
-	u64 until_dw = dw_int - do_div(tsf, dw_int);
 	struct wireless_dev *wdev = ieee80211_vif_to_wdev(vif);
 
 	if (vif->type != NL80211_IFTYPE_NAN)
@@ -85,13 +151,11 @@ int mac80211_hwsim_nan_start(struct ieee80211_hw *hw,
 	/* set this before starting the timer, as preemption might occur */
 	data->nan.device_vif = vif;
 	data->nan.bands = conf->bands;
-	data->nan.curr_dw_band = NL80211_BAND_2GHZ;
+	data->nan.channel = ieee80211_get_channel(hw->wiphy, 2437);
 
-	wiphy_debug(hw->wiphy, "nan_started, next_dw=%llu\n",
-		    until_dw);
-
-	hrtimer_start(&data->nan.timer,
-		      ns_to_ktime(until_dw * NSEC_PER_USEC),
+	/* Just run this "soon" and start in a random schedule position */
+	hrtimer_start(&data->nan.slot_timer,
+		      ns_to_ktime(10 * NSEC_PER_USEC),
 		      HRTIMER_MODE_REL_SOFT);
 
 	if (conf->cluster_id && !is_zero_ether_addr(conf->cluster_id) &&
@@ -125,7 +189,7 @@ int mac80211_hwsim_nan_stop(struct ieee80211_hw *hw,
 	    data->nan.device_vif != vif)
 		return -EINVAL;
 
-	hrtimer_cancel(&data->nan.timer);
+	hrtimer_cancel(&data->nan.slot_timer);
 	data->nan.device_vif = NULL;
 
 	spin_lock_bh(&hwsim_radio_lock);
@@ -159,10 +223,8 @@ int mac80211_hwsim_nan_change_config(struct ieee80211_hw *hw,
 	wiphy_debug(hw->wiphy, "nan_config_changed: changes=0x%x\n", changes);
 
 	/* Handle only the changes we care about for simulation purposes */
-	if (changes & CFG80211_NAN_CONF_CHANGED_BANDS) {
+	if (changes & CFG80211_NAN_CONF_CHANGED_BANDS)
 		data->nan.bands = conf->bands;
-		data->nan.curr_dw_band = NL80211_BAND_2GHZ;
-	}
 
 	if (changes & CFG80211_NAN_CONF_CHANGED_CONFIG)
 		data->nan.notify_dw = conf->enable_dw_notification;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
index eac64ac37589..e86e7f9e9a3c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
@@ -11,13 +11,15 @@ struct mac80211_hwsim_nan_data {
 	struct ieee80211_vif *device_vif;
 	u8 bands;
 
-	enum nl80211_band curr_dw_band;
-	struct hrtimer timer;
+	/* Current channel of the NAN device */
+	struct ieee80211_channel *channel;
+
+	struct hrtimer slot_timer;
 	bool notify_dw;
 };
 
 enum hrtimer_restart
-mac80211_hwsim_nan_dw_start(struct hrtimer *timer);
+mac80211_hwsim_nan_slot_timer(struct hrtimer *timer);
 
 int mac80211_hwsim_nan_start(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
-- 
2.51.1


