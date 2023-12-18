Return-Path: <linux-wireless+bounces-914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDE18173C1
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED68283730
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259EC3786A;
	Mon, 18 Dec 2023 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3BuJlAqC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="umPYKHnq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD03786B
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mi4ELzo3FZhzcl+T/tLoCV1R4ur75BKpb4KlDpGL0C8=;
	b=3BuJlAqCPWbDWOBt/QriNe32VHuu7wLM0qexdFgKIm4b/a8oBYPq4Qg8+U42T76E1N35fo
	A90qzE3ZRzmDNb4fQdPLTxehbVZcBTWdOm/vmrmpgWrBaOC1T5QTEYAZrWKUsYyXuN+9WC
	DO0t8Ql+9WBvFmVq1w4UTBshlLdEjhkVt9xvSCOnYmkwVF1QzFZunz7GHU/WdtjI9yCT91
	jXkZBBYMNHKOZJZpiirobc6APHuo98qQuXFqxl8w2dKKo3iM6kW7Iux/08i2w31C+1LAdM
	GfTCbe1U2IOJF5iG20FhDtmc1nt+rvTJtu546HBHc5PYp9qbf2GUSUD7Ip+zUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mi4ELzo3FZhzcl+T/tLoCV1R4ur75BKpb4KlDpGL0C8=;
	b=umPYKHnq2m/oV6XobESfFSBEGLND2wqTWAjkeAd9LmExlCFj2GRsj/+Nw+ZeqNXcwWl76I
	loICFmKs9lrDq4AQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 03/20] wifi: rtl8xxxu: support setting linktype for both interfaces
Date: Mon, 18 Dec 2023 15:36:28 +0100
Message-Id: <20231218143645.433356-4-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
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


