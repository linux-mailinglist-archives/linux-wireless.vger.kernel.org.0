Return-Path: <linux-wireless+bounces-35794-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ClhK40O92mQbgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35794-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 10:59:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F7A4B5047
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 10:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F36E300407B
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2026 08:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A352D0C7E;
	Sun,  3 May 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Osp/lB4i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C853AD510
	for <linux-wireless@vger.kernel.org>; Sun,  3 May 2026 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798781; cv=none; b=ZLlemvCpxvwTuUQmNktRvxs8Raqlv/jqt9RCZptPg2yo/arIXDc04dzs27STDlELw9JGE43xhvuJFTYOL/afaezhNMWTkyE0wi6NXVEjXF5m3OKV/RWVqEjFpm9xK5CCgZLSPLFLsNHUdcWnvn3DZQWclaBbxNGAZ2M3Ii2svpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798781; c=relaxed/simple;
	bh=UQgHBOuj67xMw9XA0oyFG/sWuwvDRR2EfvhUy+pB7D0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+eWhUcEBwu8fyOrA36+LMuciXVIQPlN9NLxK0zqi+D5CyPSLqnyJhcqktcEj1teuyvf2zcpyX80S5u1augFW182EWsfTODRRDsL+7GoWAa95VVHqyl685g3V3rPixNcQc+2/6bpm1h2jUqFxjzIf9X/VbZ2PlmZJg2jdoAX59o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Osp/lB4i; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777798779; x=1809334779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UQgHBOuj67xMw9XA0oyFG/sWuwvDRR2EfvhUy+pB7D0=;
  b=Osp/lB4i0aWugDbSYIdB6ldHThLL5+1xWEbBEJeZCxbf3COiCBHBiIhC
   pqhu8EZ8PeIrFB7QKElLUP31tqJjpFJjjoCs97CYNLY2GjJQ9scGqpVND
   6e8taPIpObbwXEvW0QlKMcpVkOpkldvvlQm2PBJUCRDegWI3sgwqwkKfW
   9hvvxqRAZuSyMlz4uRftqffS/ddJVYHDx7/MpxDFhMPwL7uOP7ETAuzFo
   UUcD87PL0LnowVqrhyTnc5gwxrvYZulD1HD5CffJwbGBJCS7jmOPk1B/8
   QjZr40jZMcDxmSxA1vHbmHhKJGHwqhFGUck2roAh/AUMTOmfLaufizdWS
   g==;
X-CSE-ConnectionGUID: iX1/V0qlTpyB7InjF5XgBA==
X-CSE-MsgGUID: 0+1DcL7USEW0fSNjpFvu8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="89380422"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="89380422"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 01:59:39 -0700
X-CSE-ConnectionGUID: 9e6SSRlTS7iL/lnQwPfTag==
X-CSE-MsgGUID: sPAh/QBKSkWR3QMxerqcmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="235123834"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 01:59:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 wireless-next 14/15] wifi: mac80211_hwsim: refactor NAN timer handling
Date: Sun,  3 May 2026 11:59:06 +0300
Message-Id: <20260503115440.2bf286148c83.I46da3cabea8624ba2e6c91bd2afecd2dc6553c5a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260503085907.257378-1-miriam.rachel.korenblit@intel.com>
References: <20260503085907.257378-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E3F7A4B5047
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35794-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   |   5 +
 .../wireless/virtual/mac80211_hwsim_main.c    |  22 +--
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 160 ++++++++++++------
 .../net/wireless/virtual/mac80211_hwsim_nan.h |   8 +-
 4 files changed, 133 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index d345595ca588..6b2a5dccb106 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -128,6 +128,11 @@ struct mac80211_hwsim_data {
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
index ba2aa09b37cb..c6d1f841c04d 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1216,12 +1216,18 @@ static inline u64 mac80211_hwsim_get_sim_tsf(void)
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
@@ -2045,12 +2051,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
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
@@ -5451,8 +5452,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
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
2.34.1


