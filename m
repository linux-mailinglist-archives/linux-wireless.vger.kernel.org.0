Return-Path: <linux-wireless+bounces-1657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17088297B6
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 11:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33171F246DB
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 10:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E62E3FE3E;
	Wed, 10 Jan 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VJhlLE6A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KOLLwBNl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE63FE56
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704883153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4HZvDuKCWWBllTzkNxtQBDbNMdLDG1pzBZTJQntpfWM=;
	b=VJhlLE6APv2911FjMySEBgpKJl+BHYMSEA4VmvLvQlG5d7dtOVAM6Q3tnBEpIHomuxV1Eo
	VvnAL/LfdPm42XxPUQZyBiKC+JSo9+h/x7VdZjTD7IzV+8ajuFwzyfvWgHFNhDg2qzcSCI
	fInYZZH6h5Norzp/LS6EQc/puTk8ljebNDba9N0u+4ekZ+hPYcq6BYULmHPY5LGYhvTBtb
	Yb3qRkEnKjnCMpQ6F52WTEsf0OX/WVrJvBE00NhddJPElgQg2RRas5hcBShpeYq0xOZwm2
	/+D7EgM1XNv/no/1lLtUskLi1gbsg89UXBPihbNswvYQIa/KgxHZligKUodntQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704883153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4HZvDuKCWWBllTzkNxtQBDbNMdLDG1pzBZTJQntpfWM=;
	b=KOLLwBNlER5PZXpfjEWZGw/RYGxtC2ypkuIRf6vB8LTFvXHb4rusGyzfyTN11VeT9DNJxi
	4Bs86iX5y6k1x1BA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] wifi: rtl8xxxu: enable channel switch support
Date: Wed, 10 Jan 2024 11:39:09 +0100
Message-Id: <20240110103909.240514-1-martin.kaistra@linutronix.de>
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
changes v1->v2: use delayed_work instead of usleep_range
v1: https://lore.kernel.org/linux-wireless/20240108111103.121378-1-martin.kaistra@linutronix.de/
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |  2 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

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
index 5fddbd6594a24..2cacf17c2f0d7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4605,7 +4605,7 @@ static int rtl8xxxu_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
 
-	schedule_work(&priv->update_beacon_work);
+	schedule_delayed_work(&priv->update_beacon_work, 0);
 
 	return 0;
 }
@@ -5108,7 +5108,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	if (changed & BSS_CHANGED_BEACON)
-		schedule_work(&priv->update_beacon_work);
+		schedule_delayed_work(&priv->update_beacon_work, 0);
 
 error:
 	return;
@@ -5727,7 +5727,7 @@ static void rtl8xxxu_send_beacon_frame(struct ieee80211_hw *hw,
 static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
 {
 	struct rtl8xxxu_priv *priv =
-		container_of(work, struct rtl8xxxu_priv, update_beacon_work);
+		container_of(work, struct rtl8xxxu_priv, update_beacon_work.work);
 	struct ieee80211_hw *hw = priv->hw;
 	struct ieee80211_vif *vif = priv->vifs[0];
 
@@ -5736,6 +5736,14 @@ static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
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
 
@@ -7764,7 +7772,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	spin_lock_init(&priv->rx_urb_lock);
 	INIT_WORK(&priv->rx_urb_wq, rtl8xxxu_rx_urb_work);
 	INIT_DELAYED_WORK(&priv->ra_watchdog, rtl8xxxu_watchdog_callback);
-	INIT_WORK(&priv->update_beacon_work, rtl8xxxu_update_beacon_work_callback);
+	INIT_DELAYED_WORK(&priv->update_beacon_work, rtl8xxxu_update_beacon_work_callback);
 	skb_queue_head_init(&priv->c2hcmd_queue);
 
 	usb_set_intfdata(interface, hw);
@@ -7825,6 +7833,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);
 	hw->queues = 4;
 
+	hw->wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+
 	if (priv->fops->supports_concurrent) {
 		hw->wiphy->iface_combinations = rtl8xxxu_combinations;
 		hw->wiphy->n_iface_combinations = ARRAY_SIZE(rtl8xxxu_combinations);
-- 
2.39.2


