Return-Path: <linux-wireless+bounces-1239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E356481C802
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2131B1C2166B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A42199D1;
	Fri, 22 Dec 2023 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EoUizU3z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y1VEtt9Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105018AE4
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703240090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFviRyNSEaCCig/K0agE7VjOEKBHNbMhi6bLLQTlXkA=;
	b=EoUizU3zB/EliBNNUOE9qr15HQmh0qhNZ8ogtU4Twe4NVLEMQydYUuGXu9mEmegpEqvjMl
	s1pgVvrVYMwxuaNZJoFjPcf04IvuBEPgsnvPclOPRt4Ps2b80n6uHArTa3zoIyFiZXcIfi
	vNXtgWXklVRcpQPLHruL5DGyYDeQdyH/D02s33rvzpDKrywbAZDJNBHJRKpW+7hBdoq3ar
	QMREhLDp1hj+4d+ke7/Ceyb3l8vyIK3WrA/Z4uAFbhm70D6kKVBIpU/x6mcB2UNZg5p5XI
	LnPNoRfX4EY5MxTQb1h0n+2lLlvGX8xcvh8WML6VewJbZ6ygFX/FjRHs6h31cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFviRyNSEaCCig/K0agE7VjOEKBHNbMhi6bLLQTlXkA=;
	b=y1VEtt9QcJ3hRAbuWeiorQrKa24vPVIfAAOzCrze2/UfzvFVsdIWTYqfNJiJpUxHxW+FyD
	I7sFvg8GJYjo3eBg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 17/21] wifi: rtl8xxxu: add macids for STA mode
Date: Fri, 22 Dec 2023 11:14:38 +0100
Message-Id: <20231222101442.626837-18-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until now, the driver only assigned a dedicated macid for connections
made in AP mode, in STA mode the return value of rtl8xxxu_get_macid()
was simply 0.
To differentiate between port 0 and 1, when both are in STA mode,
allocate a second macid (with value 1) and set sta_info->macid according
to the used port_num in rtl8xxxu_sta_add().

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |  1 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 9d272da373a3c..6a58897446f4c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1774,6 +1774,7 @@ struct rtl8xxxu_cfo_tracking {
 #define RTL8XXXU_HW_LED_CONTROL	2
 #define RTL8XXXU_MAX_MAC_ID_NUM	128
 #define RTL8XXXU_BC_MC_MACID	0
+#define RTL8XXXU_BC_MC_MACID1	1
 
 struct rtl8xxxu_priv {
 	struct ieee80211_hw *hw;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 5e4e6c006cc1f..0b6eac14f60e5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4053,10 +4053,13 @@ static inline u8 rtl8xxxu_get_macid(struct rtl8xxxu_priv *priv,
 {
 	struct rtl8xxxu_sta_info *sta_info;
 
-	if (!priv->vif || priv->vif->type == NL80211_IFTYPE_STATION || !sta)
+	if (!sta)
 		return 0;
 
 	sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
+	if (!sta_info)
+		return 0;
+
 	return sta_info->macid;
 }
 
@@ -4536,6 +4539,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		rtl8188e_ra_info_init_all(&priv->ra_info);
 
 	set_bit(RTL8XXXU_BC_MC_MACID, priv->mac_id_map);
+	set_bit(RTL8XXXU_BC_MC_MACID1, priv->mac_id_map);
 
 exit:
 	return ret;
@@ -7375,6 +7379,7 @@ static int rtl8xxxu_sta_add(struct ieee80211_hw *hw,
 			    struct ieee80211_sta *sta)
 {
 	struct rtl8xxxu_sta_info *sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
+	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
 	struct rtl8xxxu_priv *priv = hw->priv;
 
 	if (vif->type == NL80211_IFTYPE_AP) {
@@ -7384,6 +7389,17 @@ static int rtl8xxxu_sta_add(struct ieee80211_hw *hw,
 
 		rtl8xxxu_refresh_rate_mask(priv, 0, sta, true);
 		priv->fops->report_connect(priv, sta_info->macid, H2C_MACID_ROLE_STA, true);
+	} else {
+		switch (rtlvif->port_num) {
+		case 0:
+			sta_info->macid = RTL8XXXU_BC_MC_MACID;
+			break;
+		case 1:
+			sta_info->macid = RTL8XXXU_BC_MC_MACID1;
+			break;
+		default:
+			break;
+		}
 	}
 
 	return 0;
-- 
2.39.2


