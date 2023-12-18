Return-Path: <linux-wireless+bounces-921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751F58173C7
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F17283570
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C236841A9A;
	Mon, 18 Dec 2023 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TeH5JCh8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W5a10jTY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4B3A1C6
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+tTuJueFgF1b16ZFVsA+49UZjWzLyPqk2m4URHPvpI=;
	b=TeH5JCh8jf1b6blSg4qPHtX+VtXwOiviAkAvAOkRFA9d9GudP9u+z2OjdSvkLyoyTdEQEn
	SKcrtvC78D0ln95SeywMCHav2O2z9Cd1WixgXh2Bq90fbgXABCfqrSMmeLYLz/BxOFb7xD
	NlW5SDmpMZW4mQ+/ZzlxUtrzHa+gIKmi0R1d9mUMPecm9AHdl+msGhmvjTF7S8CIkHidap
	QFKWnPJeS2NVZcwl0tBcVHBNfHOHENvw/SPRzX8GMnmZkDheVdKXFI3+UBUiaLDzTOYEqo
	4P27++KI9prfuoWrsDTeLxNy+nz3DQwjoAbiw0PNGCWCkd6lfhJjpG/7OdgULg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+tTuJueFgF1b16ZFVsA+49UZjWzLyPqk2m4URHPvpI=;
	b=W5a10jTYf1rIoY5M1OsfbKHUpPIyoyUH7G+ZDBxp/X6tMWvK4sBlFeUOW4Ku3Wxrwza6CQ
	KbIl8uJBSEaT0JAA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 05/20] wifi: rtl8xxxu: support setting mac address register for both interfaces
Date: Mon, 18 Dec 2023 15:36:30 +0100
Message-Id: <20231218143645.433356-6-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for concurrent mode, enhance rtl8xxxu_set_mac() to write the
mac address of the respective interface to REG_MACID or REG_MACID1.

Remove the call to rtl8xxxu_set_mac() from the init function as we set
it in rtl8xxxu_add_interface() later anyway.

Until rtl8xxxu_add_interface() can handle both interfaces, call
rtl8xxxu_set_mac() with port_num = 0.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 305d6dd585dfa..c2ea8e92cd637 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3580,15 +3580,25 @@ void rtl8723a_phy_lc_calibrate(struct rtl8xxxu_priv *priv)
 		rtl8xxxu_write8(priv, REG_TXPAUSE, 0x00);
 }
 
-static int rtl8xxxu_set_mac(struct rtl8xxxu_priv *priv)
+static int rtl8xxxu_set_mac(struct rtl8xxxu_priv *priv, int port_num)
 {
 	int i;
 	u16 reg;
 
-	reg = REG_MACID;
+	switch (port_num) {
+	case 0:
+		reg = REG_MACID;
+		break;
+	case 1:
+		reg = REG_MACID1;
+		break;
+	default:
+		WARN_ONCE("%s: invalid port_num\n", __func__);
+		return -EINVAL;
+	}
 
 	for (i = 0; i < ETH_ALEN; i++)
-		rtl8xxxu_write8(priv, reg + i, priv->mac_addr[i]);
+		rtl8xxxu_write8(priv, reg + i, priv->vifs[port_num]->addr[i]);
 
 	return 0;
 }
@@ -4243,8 +4253,6 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		rtl8xxxu_write32(priv, REG_HIMR, 0xffffffff);
 	}
 
-	rtl8xxxu_set_mac(priv);
-
 	/*
 	 * Configure initial WMAC settings
 	 */
@@ -6619,7 +6627,7 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 
 	rtl8xxxu_set_linktype(priv, vif->type, 0);
 	ether_addr_copy(priv->mac_addr, vif->addr);
-	rtl8xxxu_set_mac(priv);
+	rtl8xxxu_set_mac(priv, 0);
 
 	return ret;
 }
-- 
2.39.2


