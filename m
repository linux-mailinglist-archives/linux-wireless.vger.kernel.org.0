Return-Path: <linux-wireless+bounces-1738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233FA82B318
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494811C22CFF
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738CC5025B;
	Thu, 11 Jan 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ToKuYFl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bzo6R+uD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183D5024E
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704990995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iN6GSIO/rEn/FcRbHBi0y7MwzsWweP0cE1KUmloGCF0=;
	b=2ToKuYFlV3v6Pq8WobWdM4MVtHPU8oeZBPxk2DeXQrWICkodoqwE2oa3+5E5x15PFwabvV
	L8LOsyCDXwHS77vVv7ZOcsKAjR/OqodXfsB9+nLeHrX+caLo9TOGfRLosy5YVqzh2mu96M
	BQedoj29CxyhQs+/Ng3YvB1hH72RvWU7gD8NwfQ0Hf1jyh/bU6SkOyzRswmSCVvScwjjSv
	kFy4to/OoEnDQQYcHkCnkdTirXijU2ncNNQrl87i+sGKkdZHFmSsRNNB0dQcpoUKsHMIrG
	bX6c84O2GRxwJ34FzV8KDAAOR8UpOioZffDuWbd46jB2VKtuXxaJ5EG6w5wfqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704990995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iN6GSIO/rEn/FcRbHBi0y7MwzsWweP0cE1KUmloGCF0=;
	b=Bzo6R+uDm5fpOaGT5eDX6doGtUDi5xX0jqCZUCO4IHvBfKQOVA++sCS7WHWpzk2xGzTJno
	CESXe1PuGUf979Bw==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 2/2] wifi: rtl8xxxu: enable channel switch support
Date: Thu, 11 Jan 2024 17:36:28 +0100
Message-Id: <20240111163628.320697-3-martin.kaistra@linutronix.de>
In-Reply-To: <20240111163628.320697-1-martin.kaistra@linutronix.de>
References: <20240111163628.320697-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CSA countdown in the beacon frames, which are sent out by firmware,
needs to get updated by the driver. To achieve this, convert
update_beacon_work to delayed_work and schedule it with the beacon
interval in case CSA is active and the countdown is not complete.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  2 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 803c76b3209c4..03307da67c2c3 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1900,7 +1900,7 @@ struct rtl8xxxu_priv {
 	struct delayed_work ra_watchdog;
 	struct work_struct c2hcmd_work;
 	struct sk_buff_head c2hcmd_queue;
-	struct work_struct update_beacon_work;
+	struct delayed_work update_beacon_work;
 	struct rtl8xxxu_btcoex bt_coex;
 	struct rtl8xxxu_ra_report ra_report;
 	struct rtl8xxxu_cfo_tracking cfo_tracking;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 757ebd46452eb..521faa48803c7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4605,7 +4605,7 @@ static int rtl8xxxu_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
 
-	schedule_work(&priv->update_beacon_work);
+	schedule_delayed_work(&priv->update_beacon_work, 0);
 
 	return 0;
 }
@@ -5107,7 +5107,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	if (changed & BSS_CHANGED_BEACON)
-		schedule_work(&priv->update_beacon_work);
+		schedule_delayed_work(&priv->update_beacon_work, 0);
 
 error:
 	return;
@@ -5726,7 +5726,7 @@ static void rtl8xxxu_send_beacon_frame(struct ieee80211_hw *hw,
 static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
 {
 	struct rtl8xxxu_priv *priv =
-		container_of(work, struct rtl8xxxu_priv, update_beacon_work);
+		container_of(work, struct rtl8xxxu_priv, update_beacon_work.work);
 	struct ieee80211_hw *hw = priv->hw;
 	struct ieee80211_vif *vif = priv->vifs[0];
 
@@ -5735,6 +5735,14 @@ static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
 		return;
 	}
 
+	if (vif->bss_conf.csa_active) {
+		if (ieee80211_beacon_cntdwn_is_complete(vif)) {
+			ieee80211_csa_finish(vif);
+			return;
+		}
+		schedule_delayed_work(&priv->update_beacon_work,
+				      msecs_to_jiffies(vif->bss_conf.beacon_int));
+	}
 	rtl8xxxu_send_beacon_frame(hw, vif);
 }
 
@@ -7482,6 +7490,7 @@ static void rtl8xxxu_stop(struct ieee80211_hw *hw)
 
 	cancel_work_sync(&priv->c2hcmd_work);
 	cancel_delayed_work_sync(&priv->ra_watchdog);
+	cancel_delayed_work_sync(&priv->update_beacon_work);
 
 	rtl8xxxu_free_rx_resources(priv);
 	rtl8xxxu_free_tx_resources(priv);
@@ -7764,7 +7773,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	spin_lock_init(&priv->rx_urb_lock);
 	INIT_WORK(&priv->rx_urb_wq, rtl8xxxu_rx_urb_work);
 	INIT_DELAYED_WORK(&priv->ra_watchdog, rtl8xxxu_watchdog_callback);
-	INIT_WORK(&priv->update_beacon_work, rtl8xxxu_update_beacon_work_callback);
+	INIT_DELAYED_WORK(&priv->update_beacon_work, rtl8xxxu_update_beacon_work_callback);
 	skb_queue_head_init(&priv->c2hcmd_queue);
 
 	usb_set_intfdata(interface, hw);
@@ -7825,6 +7834,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);
 	hw->queues = 4;
 
+	hw->wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+
 	if (priv->fops->supports_concurrent) {
 		hw->wiphy->iface_combinations = rtl8xxxu_combinations;
 		hw->wiphy->n_iface_combinations = ARRAY_SIZE(rtl8xxxu_combinations);
-- 
2.39.2


