Return-Path: <linux-wireless+bounces-1169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9FC81BC4A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C89BB223B2
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7252555E73;
	Thu, 21 Dec 2023 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aAfvfNwh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JnZlu3Vk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472862812
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703177046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6l4OQsbFpZBLpWVJI1YsaprnNqPUA+43/F0f+wF66I=;
	b=aAfvfNwhdNcBBbwkuMRlsJof1XoH09V9KDJBqlAU4dpLNEsxAlBWeg89NmKM0SgRr7llwJ
	7srezNUVJCarfRVnLaTtwbBzJyiTE7xvKEGiHnlezRFgyhNhtLIvKVNHuU5/a2Uj+RgMjM
	Pb4Vf5qDoZPU7S1Z5sS8ExwoDWKCbVY/ZwzvDI1wk1Rkngj2juZX0JXqApuxMNwCKspgW+
	vNdwx1EOQRO2P7Hmuvu3jexay60mGAA4nP4QYdHGfGpwhfSkJ/bxsNWuEzligZAZkTSFsC
	usqui1NwE/gcy25xus8gGVh4DlCrydGAetRrVfOdeBQuHYZezU5Tf3NwfGNadg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6l4OQsbFpZBLpWVJI1YsaprnNqPUA+43/F0f+wF66I=;
	b=JnZlu3VklWO0A5z6f4gL5Ep76FbGb80OHa/9SNPtbTfkuvpbnxBTk7FB6PlFmKnpsi0DU1
	cLKBc4D9vmv6usBQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 20/21] wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
Date: Thu, 21 Dec 2023 17:43:52 +0100
Message-Id: <20231221164353.603258-21-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-1-martin.kaistra@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
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
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 92 ++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 7aafae9fe76b8..46b22d07c1ca8 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6624,6 +6624,92 @@ static int rtl8xxxu_submit_int_urb(struct ieee80211_hw *hw)
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
+
+	/*
+	 * priv->vifs[0] is NULL here, based on how this function is currently
+	 * called from rtl8xxxu_add_interface().
+	 * When this function will be used in the future for a different
+	 * scenario, please check whether vifs[0] or vifs[1] can be NULL and if
+	 * necessary add code to set port_num = 1.
+	 */
+	rtlvif = (struct rtl8xxxu_vif *)priv->vifs[1]->drv_priv;
+	rtlvif->port_num = 1;
+}
+
 static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif)
 {
@@ -6651,8 +6737,10 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
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


