Return-Path: <linux-wireless+bounces-1225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EBE81C7F4
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39EF2B22454
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDDD13FF4;
	Fri, 22 Dec 2023 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wPo/URiY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3b85BEWu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286861173C
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703240087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuh+ofRV0CoC+Gftj1zT66pmd0kQj5yDJl758CSUz3U=;
	b=wPo/URiYuHvNiI7FHeheV6vgtwd7EI62vBCHCVApOOsbFY0Slyv0wmefrvwrOEhK1u0sDT
	HYKPis8cBJTA+Cfx5MF+Z1AQ+IFWVyby/0gYRf6EI2PDt4nv+WwA7aABFNAC2/oCY0RHbs
	3M1FIbFQYyWG9qF1WdeVBwihDViI1aZ3D2Jsh5p8i87cWLp3TULaV5a+do/V8bOfazRL+u
	TWaeUgDPO1Igc+zzJqSkovuWoi6J217e4U+t1L8gsEBPVk3wFjIQQSe+epkZOikkIeXkHl
	3NCTg43gO8rbXj7g1VYCmSMJCrvjXTd8+P5E7Y3oKbt10HTnsDa6r+7+u55qkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuh+ofRV0CoC+Gftj1zT66pmd0kQj5yDJl758CSUz3U=;
	b=3b85BEWu3tNqfk/iUijtDPtwomlqOyFJDhtZAfA0BDj5z93/maf0k8oq5ilxZ54w2QIt9Y
	tdfDqMyJq5+fcdDw==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 03/21] wifi: rtl8xxxu: support setting linktype for both interfaces
Date: Fri, 22 Dec 2023 11:14:24 +0100
Message-Id: <20231222101442.626837-4-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for concurrent mode, enhance the set_linktype function to be
able to set the linktype in the MSR register for both hardware ports.

Until the users of set_linktype can handle multiple interfaces, use
port_num = 0.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 37 +++++++++++--------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 5b7c20970a973..305d6dd585dfa 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1633,33 +1633,41 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 }
 
 static void rtl8xxxu_set_linktype(struct rtl8xxxu_priv *priv,
-				  enum nl80211_iftype linktype)
+				  enum nl80211_iftype linktype, int port_num)
 {
-	u8 val8;
-
-	val8 = rtl8xxxu_read8(priv, REG_MSR);
-	val8 &= ~MSR_LINKTYPE_MASK;
+	u8 val8, type;
 
 	switch (linktype) {
 	case NL80211_IFTYPE_UNSPECIFIED:
-		val8 |= MSR_LINKTYPE_NONE;
+		type = MSR_LINKTYPE_NONE;
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		val8 |= MSR_LINKTYPE_ADHOC;
+		type = MSR_LINKTYPE_ADHOC;
 		break;
 	case NL80211_IFTYPE_STATION:
-		val8 |= MSR_LINKTYPE_STATION;
+		type = MSR_LINKTYPE_STATION;
 		break;
 	case NL80211_IFTYPE_AP:
-		val8 |= MSR_LINKTYPE_AP;
+		type = MSR_LINKTYPE_AP;
 		break;
 	default:
-		goto out;
+		return;
+	}
+
+	switch (port_num) {
+	case 0:
+		val8 = rtl8xxxu_read8(priv, REG_MSR) & 0x0c;
+		val8 |= type;
+		break;
+	case 1:
+		val8 = rtl8xxxu_read8(priv, REG_MSR) & 0x03;
+		val8 |= type << 2;
+		break;
+	default:
+		return;
 	}
 
 	rtl8xxxu_write8(priv, REG_MSR, val8);
-out:
-	return;
 }
 
 static void
@@ -4236,7 +4244,6 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	}
 
 	rtl8xxxu_set_mac(priv);
-	rtl8xxxu_set_linktype(priv, NL80211_IFTYPE_STATION);
 
 	/*
 	 * Configure initial WMAC settings
@@ -4964,7 +4971,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (changed & BSS_CHANGED_ASSOC) {
 		dev_dbg(dev, "Changed ASSOC: %i!\n", vif->cfg.assoc);
 
-		rtl8xxxu_set_linktype(priv, vif->type);
+		rtl8xxxu_set_linktype(priv, vif->type, 0);
 
 		if (vif->cfg.assoc) {
 			u32 ramask;
@@ -6610,7 +6617,7 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 		ret = -EOPNOTSUPP;
 	}
 
-	rtl8xxxu_set_linktype(priv, vif->type);
+	rtl8xxxu_set_linktype(priv, vif->type, 0);
 	ether_addr_copy(priv->mac_addr, vif->addr);
 	rtl8xxxu_set_mac(priv);
 
-- 
2.39.2


