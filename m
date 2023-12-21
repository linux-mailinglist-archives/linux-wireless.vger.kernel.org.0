Return-Path: <linux-wireless+bounces-1168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F8981BC49
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422F21F262B0
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3564F634FB;
	Thu, 21 Dec 2023 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x6+yi+iI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i7LFpfmf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EDD62815
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703177045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbPBCL8asc0tD7whYSrHIT9BZnwfAuyYIxS588VM4fE=;
	b=x6+yi+iIRRq4KOr4/nhWqVi+rCTU/HH7obCDWxKvpEALZIrbS66WLXqV0sfe+TsluU0jq6
	IjNsENBh6fqWGNY/eFlGnywKfSDoC22sjSB5atUdJ4KbGla1nl5pSj1CeUNjElUHYIoeBC
	b05+/mnZz1Ne7IJ+rR3VO2SVcAy/xMtRtl82MUvc3/wlYYJTTY52/OweTMy66DfgRYZfLB
	IlzMPIYNRJ4oJVOcqvTr/MMZyWqzNPDYmYFYKbzU2Ob0gGAfQvbA+cu8et+PQRfH/vURGu
	mtHbcedXoHRMbbxrAp7onJygPGmmtPm3kjxuwnnbTu+zR5D0rjoLY03etpAHrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbPBCL8asc0tD7whYSrHIT9BZnwfAuyYIxS588VM4fE=;
	b=i7LFpfmfxIu5ckT0XldwLGrZcPYJamiwlK3rf2r54vnfASg4WMwd7esvaGWNYnTC/mbdbP
	gilRSIyPqtkrQUBA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 17/21] wifi: rtl8xxxu: add macids for STA mode
Date: Thu, 21 Dec 2023 17:43:49 +0100
Message-Id: <20231221164353.603258-18-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-1-martin.kaistra@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
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


