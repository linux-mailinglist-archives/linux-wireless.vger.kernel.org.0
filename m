Return-Path: <linux-wireless+bounces-924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC38173CD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428D71F241AD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F4E42388;
	Mon, 18 Dec 2023 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gTTCbUHt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K8YrpWDS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A373A1D1
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcneGXt2hvyfvv+GoRP35BilSzvSdkuXP/2I+PBrCV0=;
	b=gTTCbUHt6UQ0gdqQrK/hokK9ogILjMecompGZaLG+UJoMxC7K+nR574obkylzJEfmotFoW
	9S6255dybMtal+/SfPXCAa6Tl3PcbNTWeGWs+Sk6NsXgJSnwVULFDbvQ8zgW3aane6rEk7
	RSX403I5bNFYKSCVkj9MjyjNcfmeBLytjsolKrzWSTJghN7oA5wbqZunfsNsFZ2K/kqdKR
	ZUPwk7ESWRuvVe6kNYduwYA39c9ibzWcR1unxyMUCLrKhNpPrlP/T6ITRnrq1yJfwdY7jl
	85lIIhIFpAa6BYHI76s871U7R/QgFAmSXsDgDNWvuDZ0kvgOUoEOdu8b6tRzHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UcneGXt2hvyfvv+GoRP35BilSzvSdkuXP/2I+PBrCV0=;
	b=K8YrpWDS5w6m+RzdQH1FQZ3cRZPXMsL/OcNbfTs8amp68Swuj0UMEGv2XqnsmKsj2Uvb07
	9Yvh5ea01U5wPuBA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 13/20] wifi: rtl8xxxu: support multiple interfaces in {add,remove}_interface()
Date: Mon, 18 Dec 2023 15:36:38 +0100
Message-Id: <20231218143645.433356-14-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a custom struct to store in vif->drv_priv with a reference to
port_num and fill it when a new interface is added. Choose a free
port_num for the newly added interface.

As we only want to support AP mode/sending beacons on port 0, only change
the beacon settings if a new interface is actually assigned to port 0.

Call set_linktype() and set_mac() with the appropriate port_num.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  4 ++
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 52 +++++++++++--------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index b63fe084de92b..9d272da373a3c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1921,6 +1921,10 @@ struct rtl8xxxu_sta_info {
 	u8 macid;
 };
 
+struct rtl8xxxu_vif {
+	int port_num;
+};
+
 struct rtl8xxxu_rx_urb {
 	struct urb urb;
 	struct ieee80211_hw *hw;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 0d171f61ac8e8..59dd50844f1ae 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6598,28 +6598,33 @@ static int rtl8xxxu_submit_int_urb(struct ieee80211_hw *hw)
 static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif)
 {
+	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
 	struct rtl8xxxu_priv *priv = hw->priv;
-	int ret;
+	int port_num;
 	u8 val8;
 
-	if (!priv->vif) {
-		priv->vif = vif;
-		priv->vifs[0] = vif;
-	} else {
+	if (!priv->vifs[0])
+		port_num = 0;
+	else if (!priv->vifs[1])
+		port_num = 1;
+	else
 		return -EOPNOTSUPP;
-	}
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
-		rtl8xxxu_stop_tx_beacon(priv);
+		if (port_num == 0) {
+			rtl8xxxu_stop_tx_beacon(priv);
 
-		val8 = rtl8xxxu_read8(priv, REG_BEACON_CTRL);
-		val8 |= BEACON_ATIM | BEACON_FUNCTION_ENABLE |
-			BEACON_DISABLE_TSF_UPDATE;
-		rtl8xxxu_write8(priv, REG_BEACON_CTRL, val8);
-		ret = 0;
+			val8 = rtl8xxxu_read8(priv, REG_BEACON_CTRL);
+			val8 |= BEACON_ATIM | BEACON_FUNCTION_ENABLE |
+				BEACON_DISABLE_TSF_UPDATE;
+			rtl8xxxu_write8(priv, REG_BEACON_CTRL, val8);
+		}
 		break;
 	case NL80211_IFTYPE_AP:
+		if (port_num == 1)
+			return -EOPNOTSUPP;
+
 		rtl8xxxu_write8(priv, REG_BEACON_CTRL,
 				BEACON_DISABLE_TSF_UPDATE | BEACON_CTRL_MBSSID);
 		rtl8xxxu_write8(priv, REG_ATIMWND, 0x0c); /* 12ms */
@@ -6636,31 +6641,32 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 		val8 = rtl8xxxu_read8(priv, REG_CCK_CHECK);
 		val8 &= ~BIT_BCN_PORT_SEL;
 		rtl8xxxu_write8(priv, REG_CCK_CHECK, val8);
-
-		ret = 0;
 		break;
 	default:
-		ret = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
-	rtl8xxxu_set_linktype(priv, vif->type, 0);
+	priv->vifs[port_num] = vif;
+	priv->vif = vif;
+	rtlvif->port_num = port_num;
+
+	rtl8xxxu_set_linktype(priv, vif->type, port_num);
 	ether_addr_copy(priv->mac_addr, vif->addr);
-	rtl8xxxu_set_mac(priv, 0);
+	rtl8xxxu_set_mac(priv, port_num);
 
-	return ret;
+	return 0;
 }
 
 static void rtl8xxxu_remove_interface(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif)
 {
+	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
 	struct rtl8xxxu_priv *priv = hw->priv;
 
 	dev_dbg(&priv->udev->dev, "%s\n", __func__);
 
-	if (priv->vif) {
-		priv->vif = NULL;
-		priv->vifs[0] = NULL;
-	}
+	priv->vif = NULL;
+	priv->vifs[rtlvif->port_num] = NULL;
 }
 
 static int rtl8xxxu_config(struct ieee80211_hw *hw, u32 changed)
@@ -7649,6 +7655,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	if (ret)
 		goto err_set_intfdata;
 
+	hw->vif_data_size = sizeof(struct rtl8xxxu_vif);
+
 	hw->wiphy->max_scan_ssids = 1;
 	hw->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
 	if (priv->fops->max_macid_num)
-- 
2.39.2


