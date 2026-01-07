Return-Path: <linux-wireless+bounces-30475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B83A7CFFE15
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 20:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8F5430AFCDC
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 19:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982A433D503;
	Wed,  7 Jan 2026 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rouOnbFS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A16339844
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795828; cv=none; b=JqXbRhIwEr7TXETYFu3TO3tFtXSxeKVPEXD4XCrr+9Xe7fDF3qYZVGC/0gCXkSAOscED6SbNhVIm8B9s+rkng4N7rlnIIQP3jUdroI3P28MfXeSTgEB0pU0F+SMev8DHf9kH21fD0y3Qayn5O5CZcNxUhAu8c+BATMxfFsmbnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795828; c=relaxed/simple;
	bh=0bZe4CbCCz0JJl/dDdIwaw9RdFyQz0SqhxIqAMe59gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeeDklj58NcnbhJzrWQFScV9sW5vyDT2yWnzYT6BhOJDr/Lx+R7MW6dHIpOjBl3OigSv52gsjlGN/bCQ9N/fKudF0Yh4DxPJ0OP+y0BosWF2PCIEO9jphShifU7kaiZMZwNzEWHvnw/tw0+M+ONFDDcYUsxCd9KdBB+P1JCXXo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rouOnbFS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0yaXq97XJnv+JkA4hkRhx7j8N19mSrgCoqMmico7Yos=;
	t=1767795826; x=1769005426; b=rouOnbFSR0AP893XAKP7U3+BLvNh17V775UugZEm1V84Dbw
	n68zub33CxVaNoM0oXbkHHRAbVlOG+BCZ8cb10QReXcXR1wralVOxOgeaFQ1exU7q5Bsv4MfQgZmN
	4oDe8/P6V/r/UdWDHVEgx/Hp/0EjdXDUciTG2MHS1dp+H8WgUoXl81HBPEG/fc6VOFFeFmsM8q6ZZ
	Jh2o7GfwN4cOvTHM+D3vCmVWWMamxcG7vOjdMTLepU3IvCoLIpPX+Cs93ZjR7gVKD/Uf81rB+r1lp
	wfP9G9jjICxnNXDZO6I/HH+jZ+c9gILObdm7a/8CeMTr97Rc7dcf1XO1z25uoqBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURs-00000005agF-0f7f;
	Wed, 07 Jan 2026 15:23:44 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC wireless-next 13/46] wifi: mac80211_hwsim: limit TX of frames to the NAN DW
Date: Wed,  7 Jan 2026 15:22:12 +0100
Message-ID: <20260107152325.ec224c859dd0.Id6780e2f7f7cab03264299b7d696ba5b1269e451@changeid>
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
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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
index 5a5caa614cb8..57e22f18bbd1 100644
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
2.52.0


