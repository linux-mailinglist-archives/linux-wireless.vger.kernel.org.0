Return-Path: <linux-wireless+bounces-930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36258173D5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7421C2459D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCACF498A4;
	Mon, 18 Dec 2023 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QXm2Cvhe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8mkHCakv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C443042042
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5kEICenyd2aan/48bm9RsqR2/tJuqTwqvQasfll+Ao=;
	b=QXm2Cvhe5fNPMf1gNfz4blI2D4fPOX4QPRBF8WRQY97WOOcg6A0HeQrqEMZcctyMcU4M91
	TSezvA/F810gB7iZ+0w9m6DnAAiOV2BCO9k6qpkroQOXuy7NkmGtPfO9ppbX8mcAF3F2vz
	jIyQ4b4FWAyMpn52RzS4yLnIjraYQjschrCTd09NmdZ9G9vi18WXsb9xOEUB9iuOOGeDcd
	E8aOtlmgyWwxtjO5VZuyLrk/wV6XTX3qVIhAwgSJmWus9Aio1P7Qh28wPjdk/aYgO+NFyV
	hGrqaRKxfSgpEUv3S/kAxu1URxI7HBBEyjqGenZJru1SDz2kwBAy/4RHL5RIvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5kEICenyd2aan/48bm9RsqR2/tJuqTwqvQasfll+Ao=;
	b=8mkHCakvvmxJLhrK+K1rnnFwLXFdoDwwKNf/y8ZK8U9l55N2fX8ZZZloIU0Bd7KT6C3eAs
	Bh0O6Gcr6HcVpZDg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 19/20] wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
Date: Mon, 18 Dec 2023 15:36:44 +0100
Message-Id: <20231218143645.433356-20-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the driver is used for concurrent mode, both virtual interfaces can
be set to station or AP mode, though only one can be in AP mode at the
same time.

In order to keep the code simple, use only hw port 0 for AP mode. When
an interface is added in AP mode which would be assigned to port 1, use
a switch_port function to transparently swap the mapping between virtual
interface and hw port.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 84 ++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 88730791091a7..595f447874f4d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6613,6 +6613,84 @@ static int rtl8xxxu_submit_int_urb(struct ieee80211_hw *hw)
 	return ret;
 }
 
+static void rtl8xxxu_switch_ports(struct rtl8xxxu_priv *priv)
+{
+	u8 macid[ETH_ALEN], bssid[ETH_ALEN], macid_1[ETH_ALEN], bssid_1[ETH_ALEN];
+	u8 msr, bcn_ctrl, bcn_ctrl_1, atimwnd[2], atimwnd_1[2];
+	struct rtl8xxxu_vif *rtlvif;
+	struct ieee80211_vif *vif;
+	u8 tsftr[8], tsftr_1[8];
+	int i;
+
+	msr = rtl8xxxu_read8(priv, REG_MSR);
+	bcn_ctrl = rtl8xxxu_read8(priv, REG_BEACON_CTRL);
+	bcn_ctrl_1 = rtl8xxxu_read8(priv, REG_BEACON_CTRL_1);
+
+	for (i = 0; i < ARRAY_SIZE(atimwnd); i++)
+		atimwnd[i] = rtl8xxxu_read8(priv, REG_ATIMWND + i);
+	for (i = 0; i < ARRAY_SIZE(atimwnd_1); i++)
+		atimwnd_1[i] = rtl8xxxu_read8(priv, REG_ATIMWND_1 + i);
+
+	for (i = 0; i < ARRAY_SIZE(tsftr); i++)
+		tsftr[i] = rtl8xxxu_read8(priv, REG_TSFTR + i);
+	for (i = 0; i < ARRAY_SIZE(tsftr); i++)
+		tsftr_1[i] = rtl8xxxu_read8(priv, REG_TSFTR1 + i);
+
+	for (i = 0; i < ARRAY_SIZE(macid); i++)
+		macid[i] = rtl8xxxu_read8(priv, REG_MACID + i);
+
+	for (i = 0; i < ARRAY_SIZE(bssid); i++)
+		bssid[i] = rtl8xxxu_read8(priv, REG_BSSID + i);
+
+	for (i = 0; i < ARRAY_SIZE(macid_1); i++)
+		macid_1[i] = rtl8xxxu_read8(priv, REG_MACID1 + i);
+
+	for (i = 0; i < ARRAY_SIZE(bssid_1); i++)
+		bssid_1[i] = rtl8xxxu_read8(priv, REG_BSSID1 + i);
+
+	/* disable bcn function, disable update TSF */
+	rtl8xxxu_write8(priv, REG_BEACON_CTRL, (bcn_ctrl &
+			(~BEACON_FUNCTION_ENABLE)) | BEACON_DISABLE_TSF_UPDATE);
+	rtl8xxxu_write8(priv, REG_BEACON_CTRL_1, (bcn_ctrl_1 &
+			(~BEACON_FUNCTION_ENABLE)) | BEACON_DISABLE_TSF_UPDATE);
+
+	/* switch msr */
+	msr = (msr & 0xf0) | ((msr & 0x03) << 2) | ((msr & 0x0c) >> 2);
+	rtl8xxxu_write8(priv, REG_MSR, msr);
+
+	/* write port0 */
+	rtl8xxxu_write8(priv, REG_BEACON_CTRL, bcn_ctrl_1 & ~BEACON_FUNCTION_ENABLE);
+	for (i = 0; i < ARRAY_SIZE(atimwnd_1); i++)
+		rtl8xxxu_write8(priv, REG_ATIMWND + i, atimwnd_1[i]);
+	for (i = 0; i < ARRAY_SIZE(tsftr_1); i++)
+		rtl8xxxu_write8(priv, REG_TSFTR + i, tsftr_1[i]);
+	for (i = 0; i < ARRAY_SIZE(macid_1); i++)
+		rtl8xxxu_write8(priv, REG_MACID + i, macid_1[i]);
+	for (i = 0; i < ARRAY_SIZE(bssid_1); i++)
+		rtl8xxxu_write8(priv, REG_BSSID + i, bssid_1[i]);
+
+	/* write port1 */
+	rtl8xxxu_write8(priv, REG_BEACON_CTRL_1, bcn_ctrl & ~BEACON_FUNCTION_ENABLE);
+	for (i = 0; i < ARRAY_SIZE(atimwnd); i++)
+		rtl8xxxu_write8(priv, REG_ATIMWND_1 + i, atimwnd[i]);
+	for (i = 0; i < ARRAY_SIZE(tsftr); i++)
+		rtl8xxxu_write8(priv, REG_TSFTR1 + i, tsftr[i]);
+	for (i = 0; i < ARRAY_SIZE(macid); i++)
+		rtl8xxxu_write8(priv, REG_MACID1 + i, macid[i]);
+	for (i = 0; i < ARRAY_SIZE(bssid); i++)
+		rtl8xxxu_write8(priv, REG_BSSID1 + i, bssid[i]);
+
+	/* write bcn ctl */
+	rtl8xxxu_write8(priv, REG_BEACON_CTRL, bcn_ctrl_1);
+	rtl8xxxu_write8(priv, REG_BEACON_CTRL_1, bcn_ctrl);
+
+	vif = priv->vifs[0];
+	priv->vifs[0] = priv->vifs[1];
+	priv->vifs[1] = vif;
+	rtlvif = (struct rtl8xxxu_vif *)priv->vifs[1]->drv_priv;
+	rtlvif->port_num = 1;
+}
+
 static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif)
 {
@@ -6640,8 +6718,10 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 		}
 		break;
 	case NL80211_IFTYPE_AP:
-		if (port_num == 1)
-			return -EOPNOTSUPP;
+		if (port_num == 1) {
+			rtl8xxxu_switch_ports(priv);
+			port_num = 0;
+		}
 
 		rtl8xxxu_write8(priv, REG_BEACON_CTRL,
 				BEACON_DISABLE_TSF_UPDATE | BEACON_CTRL_MBSSID);
-- 
2.39.2


