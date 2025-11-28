Return-Path: <linux-wireless+bounces-29412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45589C92516
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC9A34EB685
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5BD30ACF0;
	Fri, 28 Nov 2025 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="m+3pV8gI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C323C512
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339679; cv=none; b=iyKWERGzdMO9USH1FFtHuvVirP4aQSZnhqv7qGdcn+SX4l89bfXREEMJyv8qP6Do3NWOLs/CDKgUryh9EoXAPajqAOeFvwdEzY7klpluJ8nF3EAWy/jLE3j18bbtpvTseKoxRwZhHqeQzElKurCF2Q6EdVadRNJi7hAfL4Xf8C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339679; c=relaxed/simple;
	bh=+6kJWpRytFiHy3MT0cByOTKASXpWnqOfvtkeoDnAYmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyKGbps/yP7LIP7FL3R3s3AIoHNHser2om2X/d954kDn00SfQzhcQ6Xm2oBo150Qu0dbbjLt8u/Ww8+TOZ10F2tIOn54+dsV/Qk+2ttPx6FNW4xoQxQpbMzk859xUE+IzS8kARLh7GdCOPnuQ5sqKk8qY0ssApwIzh+rKpNnGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=m+3pV8gI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=arTCf76PI2C/mExXUmxMzjob7QF44d/FJaXEQ476/qk=;
	t=1764339677; x=1765549277; b=m+3pV8gIsrHGrAfFRkoHaT+F3XyFY6vZ7UXYWgpoWg88ZJX
	WCVYko34K5dg8GT9XHp0CZ+gWS/T4iXtvj7hVB6oVjY/Ipt7MzkNPfNtj8C9vTmeSwI4Eb6NEmDVO
	4XgU7VG7GHPfbw/nKTu9Xub1k51uQpM5+iJk4Rl1WE5hy9MhEBOnQl8BbHLFP4uJT3F3ecO6Mv9w2
	aquWx3q4LFIslHMKOKq3Y56VSvNm5D8INqTPsopAJBo+ueKpwz+zQGOEGlay2nMeExO8JV9iQUsLk
	f/KdSnZPdWxyjlYA1MxrUIXDekXamfe3o/fyr9JZjlTp1QaHxI8W+efB7bsiyd7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLW-00000003926-0l4N;
	Fri, 28 Nov 2025 15:21:14 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 12/18] wifi: mac80211_hwsim: limit TX of frames to the NAN DW
Date: Fri, 28 Nov 2025 15:15:50 +0100
Message-ID: <20251128151537.082e5e0b59fc.Id6780e2f7f7cab03264299b7d696ba5b1269e451@changeid>
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

Frames submitted on the NAN device interface should only be transmitted
during one of the discovery windows (DWs). It is assumed that software
submits frames from the DW end notifications for the next DW period.

Simulate this behaviour by checking that we are currently in a DW before
transmitting from ieee80211_hwsim_wake_tx_queue. As frames will be
queued up at the start of a DW, wake the management TX queue every time
a DW is started. Do so with a randomized offset just to avoid every
client transmitting at the same time.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 .../net/wireless/virtual/mac80211_hwsim_i.h   |  3 +
 .../wireless/virtual/mac80211_hwsim_main.c    | 11 ++-
 .../net/wireless/virtual/mac80211_hwsim_nan.c | 79 +++++++++++++++++++
 .../net/wireless/virtual/mac80211_hwsim_nan.h |  6 ++
 4 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_i.h b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
index 890bf8ac064a..0cc87205554e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_i.h
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_i.h
@@ -135,4 +135,7 @@ u64 mac80211_hwsim_boottime_to_tsf(struct mac80211_hwsim_data *data,
 u64 mac80211_hwsim_get_tsf(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif);
 
+void ieee80211_hwsim_wake_tx_queue(struct ieee80211_hw *hw,
+				   struct ieee80211_txq *txq);
+
 #endif /* __MAC80211_HWSIM_I_H */
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 8bfd6f984f1c..0f8769ccfd9a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -2062,14 +2062,18 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
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
@@ -5263,6 +5267,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		hrtimer_setup(&data->nan.slot_timer,
 			      mac80211_hwsim_nan_slot_timer,
 			      CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
+		hrtimer_setup(&data->nan.resume_txqs_timer,
+			      mac80211_hwsim_nan_resume_txqs_timer,
+			      CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
 	}
 
 	data->if_combination.radar_detect_widths =
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_nan.c b/drivers/net/wireless/virtual/mac80211_hwsim_nan.c
index f4191954ca9d..029499bf965f 100644
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
2.51.1


