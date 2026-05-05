Return-Path: <linux-wireless+bounces-35925-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEegHDAe+mmaJwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35925-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 101BC4D185C
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF8663013033
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAE9492194;
	Tue,  5 May 2026 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iM+B1sms"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC085429838
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999356; cv=none; b=JNBN9r3pYB1wAq8Lwk7c4qVEGjCM7rEo3UUChZsGs37NtQzyjnZCeWjmJYivsovqSlNhkMc+4nEsTvkHLs4XzsYTGdSkznjDCZ7K0g6D5KCdicu88axJCyEkkGlqHhY/D9gmPMC/ZYSZJzJYwjivFMesj/KqiMsUVHUFrRsd2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999356; c=relaxed/simple;
	bh=/LShSQj+7MSO+uOntk+jcwlpA1xSMeAGfEKb4uHOj0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGn4wEV2FHrgny2lMH5ARY5eFsqpN1drff+Di6S2gLFqIRgJwPrl+AgRahezh0Qb8+HBTI/3IkgWiks7C/8ZNlBi/ax+uAV3n07or39A97E5G3MhyvG/LvRFWG24NjU14wJNWfeG9uhEhVM1MyWsmXg6lXBqZXBHuu2CtrsvPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iM+B1sms; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999354; x=1809535354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/LShSQj+7MSO+uOntk+jcwlpA1xSMeAGfEKb4uHOj0w=;
  b=iM+B1smsA6jXFpITg3bDGWcAuTckchWr970CMrmxLWSWc5BlCv2WbA3K
   59XDm+uLqncKkliwsVCSwRPYA0pIpPusNiMCVeL5e/z5yt0OYOOxDIcaM
   ZP3r1RB4OcYInf559v2kCp6jlJxOgXvnHSvRDcH7xanvelEsnevtOvrle
   sXaGAqoBAo1wd/fMDXNpGMN8L9nwbMjfoTti5v42JeKTkGQ2grIXci5XI
   wbT0I2e9TQojhAvXfgEmJB+bwGhwq2bsFWZYTIqQUlqu8t2K6MHSnvhAa
   lXiXII0FRgcjpVdQotnLu2UUJ/uYxnmP8icSxBu8D4SwRfYAR1xXm8AfD
   Q==;
X-CSE-ConnectionGUID: igb3q+0OSraB45BhGtAiDA==
X-CSE-MsgGUID: hjDmtN+jTNGEG8XwyaXEUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898961"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898961"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:34 -0700
X-CSE-ConnectionGUID: Tbyrq/1KSLmtAiTDImWmcw==
X-CSE-MsgGUID: ckYnkIyKTBiKebvn0wPHXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206338"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 01/14] wifi: mac80211_hwsim: limit TX of frames to the NAN DW
Date: Tue,  5 May 2026 19:42:06 +0300
Message-Id: <20260505194007.f3456f159655.Id6780e2f7f7cab03264299b7d696ba5b1269e451@changeid>
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
X-Rspamd-Queue-Id: 101BC4D185C
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
	TAGGED_FROM(0.00)[bounces-35925-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

From: Benjamin Berg <benjamin.berg@intel.com>

Frames submitted on the NAN device interface should only be transmitted
during one of the discovery windows (DWs). It is assumed that software
submits frames from the DW end notifications for the next DW period.

Simulate this behaviour by checking that we are currently in a DW before
transmitting from ieee80211_hwsim_wake_tx_queue. As frames will be
queued up at the start of a DW, wake the management TX queue every time
a DW is started. Do so with a randomized offset just to avoid every
client transmitting at the same time.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   |  3 +
 .../wireless/virtual/mac80211_hwsim_main.c    | 11 ++-
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 79 +++++++++++++++++++
 .../net/wireless/virtual/mac80211_hwsim_nan.h |  6 ++
 4 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index 6b2a5dccb106..5432de92beab 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -136,4 +136,7 @@ u64 mac80211_hwsim_boottime_to_tsf(struct mac80211_hwsim_data *data,
 u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif);
 
+void ieee80211_hwsim_wake_tx_queue(struct ieee80211_hw *hw,
+				   struct ieee80211_txq *txq);
+
 #endif /* __MAC80211_HWSIM_I_H */
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 3a0c4366dfdb..6740504b30e6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -2235,14 +2235,18 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	ieee80211_tx_status_irqsafe(hw, skb);
 }
 
-static void ieee80211_hwsim_wake_tx_queue(struct ieee80211_hw *hw,
-					  struct ieee80211_txq *txq)
+void ieee80211_hwsim_wake_tx_queue(struct ieee80211_hw *hw,
+				   struct ieee80211_txq *txq)
 {
 	struct ieee80211_tx_control control = {
 		.sta = txq->sta,
 	};
 	struct sk_buff *skb;
 
+	if (txq->vif->type == NL80211_IFTYPE_NAN &&
+	    !mac80211_hwsim_nan_txq_transmitting(hw, txq))
+		return;
+
 	while ((skb = ieee80211_tx_dequeue(hw, txq)))
 		mac80211_hwsim_tx(hw, &control, skb);
 }
@@ -5603,6 +5607,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		hrtimer_setup(&data->nan.slot_timer,
 			      mac80211_hwsim_nan_slot_timer,
 			      CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
+		hrtimer_setup(&data->nan.resume_txqs_timer,
+			      mac80211_hwsim_nan_resume_txqs_timer,
+			      CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
 	}
 
 	data->if_combination.radar_detect_widths =
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index aa4aef0920f4..22805c3723e6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
@@ -26,8 +26,13 @@
 static_assert(16 * DWST_TU * 1024 == 8192 * 1024);
 static_assert(DW0_TSF_MASK + 1 == 8192 * 1024);
 
+/* Quiet time at the end of each slot where TX is suppressed */
+#define NAN_CHAN_SWITCH_TIME_US		256
+
 static u8 hwsim_nan_cluster_id[ETH_ALEN];
 
+static void mac80211_hwsim_nan_resume_txqs(struct mac80211_hwsim_data *data);
+
 static u64 hwsim_nan_get_timer_tsf(struct mac80211_hwsim_data *data)
 {
 	ktime_t expires = hrtimer_get_expires(&data->nan.slot_timer);
@@ -130,6 +135,8 @@ mac80211_hwsim_nan_slot_timer(struct hrtimer *timer)
 		cfg80211_next_nan_dw_notif(wdev, notify_dw_chan, GFP_ATOMIC);
 	}
 
+	mac80211_hwsim_nan_resume_txqs(data);
+
 	mac80211_hwsim_nan_schedule_slot(data, slot + 1);
 
 	return HRTIMER_RESTART;
@@ -190,6 +197,7 @@ int mac80211_hwsim_nan_stop(struct ieee80211_hw *hw,
 		return -EINVAL;
 
 	hrtimer_cancel(&data->nan.slot_timer);
+	hrtimer_cancel(&data->nan.resume_txqs_timer);
 	data->nan.device_vif = NULL;
 
 	spin_lock_bh(&hwsim_radio_lock);
@@ -231,3 +239,74 @@ int mac80211_hwsim_nan_change_config(struct ieee80211_hw *hw,
 
 	return 0;
 }
+
+static void mac80211_hwsim_nan_resume_txqs(struct mac80211_hwsim_data *data)
+{
+	u32 timeout_ns;
+
+	/* Nothing to do if we are not in a DW */
+	if (!mac80211_hwsim_nan_txq_transmitting(data->hw,
+						 data->nan.device_vif->txq_mgmt))
+		return;
+
+	/*
+	 * Wait a bit and also randomize things so that not everyone is TXing
+	 * at the same time. Each slot is 16 TU long, this waits between 100 us
+	 * and 5 ms before starting to TX (unless a new frame arrives).
+	 */
+	timeout_ns = get_random_u32_inclusive(100 * NSEC_PER_USEC,
+					      5 * NSEC_PER_MSEC);
+
+	hrtimer_start(&data->nan.resume_txqs_timer,
+		      ns_to_ktime(timeout_ns),
+		      HRTIMER_MODE_REL_SOFT);
+}
+
+enum hrtimer_restart
+mac80211_hwsim_nan_resume_txqs_timer(struct hrtimer *timer)
+{
+	struct mac80211_hwsim_data *data =
+		container_of(timer, struct mac80211_hwsim_data,
+			     nan.resume_txqs_timer);
+
+	guard(rcu)();
+
+	/* Wake TX queue for management frames on the NAN device interface */
+	if (mac80211_hwsim_nan_txq_transmitting(data->hw,
+						data->nan.device_vif->txq_mgmt))
+		ieee80211_hwsim_wake_tx_queue(data->hw,
+					      data->nan.device_vif->txq_mgmt);
+
+	return HRTIMER_NORESTART;
+}
+
+bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
+					 struct ieee80211_txq *txq)
+{
+	struct mac80211_hwsim_data *data = hw->priv;
+	u64 tsf;
+	u8 slot;
+
+	if (WARN_ON_ONCE(!data->nan.device_vif))
+		return true;
+
+	tsf = mac80211_hwsim_get_tsf(hw, data->nan.device_vif);
+	slot = hwsim_nan_slot_from_tsf(tsf);
+
+	/* Enforce a maximum channel switch time and guard against TX delays */
+	if (slot != hwsim_nan_slot_from_tsf(tsf + NAN_CHAN_SWITCH_TIME_US))
+		return false;
+
+	/* Check NAN device interface management frame transmission */
+	if (!txq->sta) {
+		/* Only transmit these during one of the DWs */
+		if (slot == SLOT_24GHZ_DW ||
+		    (slot == SLOT_5GHZ_DW &&
+		     (data->nan.bands & BIT(NL80211_BAND_5GHZ))))
+			return true;
+
+		return false;
+	}
+
+	return true;
+}
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
index e86e7f9e9a3c..6a0780797273 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_nan.h
@@ -15,11 +15,14 @@ struct mac80211_hwsim_nan_data {
 	struct ieee80211_channel *channel;
 
 	struct hrtimer slot_timer;
+	struct hrtimer resume_txqs_timer;
 	bool notify_dw;
 };
 
 enum hrtimer_restart
 mac80211_hwsim_nan_slot_timer(struct hrtimer *timer);
+enum hrtimer_restart
+mac80211_hwsim_nan_resume_txqs_timer(struct hrtimer *timer);
 
 int mac80211_hwsim_nan_start(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
@@ -33,4 +36,7 @@ int mac80211_hwsim_nan_change_config(struct ieee80211_hw *hw,
 				     struct cfg80211_nan_conf *conf,
 				     u32 changes);
 
+bool mac80211_hwsim_nan_txq_transmitting(struct ieee80211_hw *hw,
+					 struct ieee80211_txq *txq);
+
 #endif /* __MAC80211_HWSIM_NAN_H */
-- 
2.34.1


