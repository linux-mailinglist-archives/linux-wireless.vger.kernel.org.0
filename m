Return-Path: <linux-wireless+bounces-35818-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGXGCXtJ+Gn+sAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35818-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:23:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9024B94AA
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 202CB3031839
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 07:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BFD2D8773;
	Mon,  4 May 2026 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/fk7x3b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1012DCF45
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879289; cv=none; b=tufMKehnvhntZUukZ8Vz/HClWEREA5irF+RFqhnxYjQ/9p1RZk/TQiUtco0mdSQOCbYryXsnbtCm9JV/z/E5LvlItLdMcqFkr/Ea8JoeSZJPHlQcY0vdlWE83qpr2fICj/u2vKTApV8HD3FkVrBeNDTbNSM60YAAw1TYP0v6E/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879289; c=relaxed/simple;
	bh=VlTQ4qdJqLefL4U+M0KOkYyDGo4iXCEg1PlFvnTIX28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jB0QdaB5/P3RZVB6LdNbiFp/8BBoD/ySQg48KlSfFHERITJfvoKDtqsCv3bJSRo+FEuEaxfUMqSSWI3tfAjLSvMbWoK4biWY8ZM90SdgRsJc18lSwGTH84t+2vRqFcaKbnE3tzPnO92FwdUklKdugVg5F25Bu8TqUKasktrPXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/fk7x3b; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777879288; x=1809415288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VlTQ4qdJqLefL4U+M0KOkYyDGo4iXCEg1PlFvnTIX28=;
  b=J/fk7x3bs3tKbQHc2viGk4AyXkrhpmhNJr/ffeQGaTvTEF7KLidBgxQS
   63fun9X1dTKBbYlUq1zrF8eW7qoG33Ln9EJqwDHoHtFlozLB2AE26UK2J
   slkN86KDEO1thzVzoJVmGXGFbIuzprtt9KiLfQtB3WUlPg42csAt3MC9H
   0/7sGXZKdl/dbytR59ObItBVmW+SpNDHRNg3ESPsddX7sl0eITWUsQVMM
   3PLZILLhM0Ov7TZI9vDLHH74Zwo2Gzd4ETdgMAlq0LMi+wSyRNqMFMUpT
   O40AB08la8q4UkW6wEu4ZLzeP56zrSLP6EMkxFo/WImhR208Ne0NCwxGz
   g==;
X-CSE-ConnectionGUID: F9zADFtdTBa4p+m04TFujQ==
X-CSE-MsgGUID: 00TQPKfBQI6DNmX+9WO2Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101398336"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="101398336"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:27 -0700
X-CSE-ConnectionGUID: WfgGV1XjSLeV9N4pla+/hA==
X-CSE-MsgGUID: kR+wDPI5QUaOc3c/swEeWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273555278"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 wireless-next 14/15] wifi: mac80211_hwsim: refactor NAN timer handling
Date: Mon,  4 May 2026 10:20:54 +0300
Message-Id: <20260504101829.feb8e02b234e.I46da3cabea8624ba2e6c91bd2afecd2dc6553c5a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
References: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F9024B94AA
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
	TAGGED_FROM(0.00)[bounces-35818-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

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
index 393ea70ee087..aa4aef0920f4 100644
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
 
 	if (!is_zero_ether_addr(conf->cluster_id) &&
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


