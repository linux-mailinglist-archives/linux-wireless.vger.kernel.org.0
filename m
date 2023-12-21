Return-Path: <linux-wireless+bounces-1157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A381BC3F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76826B24DCA
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD2959923;
	Thu, 21 Dec 2023 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BXVG4kW4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5KgBtM6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F015459913
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703177044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43NbwlNaFzVIc5XSe7laQbDtYbGsuzb24fzj9Y2JK7c=;
	b=BXVG4kW4l4sA47u8Aoixs4AHERtlAmQ19532OfzxpT1YC9+p73VNiqPm5YNBloBfvQnn2E
	6L87QCnF5vtgbPqXNoxhcLaCRqUn4rhnfc0VL7OK9Gu3drlLsmwFLRs0zS/jNNyu8ohXT5
	0IXlBUka5/Wp6SsAhkz/KPiyEQIBxm9oK9UET5XFQxVwpFwqgO8/uxCsqS59+v2X/BmeG7
	L7Oi0DSqnXwdevZuRft/y/EB1+q1nBYiotbOtZYzbW7v0JZU5zKfG1NQXUGDRGjVFYBVLo
	gulnk37hhyumJ7LPOR5i3ACx81YCR3XLOS10EzlzV9I9poz+zE8Zj6fqtTftbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43NbwlNaFzVIc5XSe7laQbDtYbGsuzb24fzj9Y2JK7c=;
	b=5KgBtM6Qyji2vk/g7SQM2+LaiXrJ04glW91eXkiZzAaEaW9lhQIHgty1N2ZnEWby4UyyP4
	ykxXedCkU0pTnMDA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 09/21] wifi: rtl8xxxu: support setting bssid register for multiple interfaces
Date: Thu, 21 Dec 2023 17:43:41 +0100
Message-Id: <20231221164353.603258-10-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-1-martin.kaistra@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for concurrent mode, enhance rtl8xxxu_set_bssid() to write the
BSSID of the respective interface to REG_BSSID or REG_BSSID1.

Like done with rtl8xxxu_set_mac(), call rtl8xxxu_set_bssid() with
port_num = 0, until the callers also support multiple interfaces.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 6fff982f65253..490f35d0d6199 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -3603,14 +3603,24 @@ static int rtl8xxxu_set_mac(struct rtl8xxxu_priv *priv, int port_num)
 	return 0;
 }
 
-static int rtl8xxxu_set_bssid(struct rtl8xxxu_priv *priv, const u8 *bssid)
+static int rtl8xxxu_set_bssid(struct rtl8xxxu_priv *priv, const u8 *bssid, int port_num)
 {
 	int i;
 	u16 reg;
 
 	dev_dbg(&priv->udev->dev, "%s: (%pM)\n", __func__, bssid);
 
-	reg = REG_BSSID;
+	switch (port_num) {
+	case 0:
+		reg = REG_BSSID;
+		break;
+	case 1:
+		reg = REG_BSSID1;
+		break;
+	default:
+		WARN_ONCE("%s: invalid port_num\n", __func__);
+		return -EINVAL;
+	}
 
 	for (i = 0; i < ETH_ALEN; i++)
 		rtl8xxxu_write8(priv, reg + i, bssid[i]);
@@ -5068,7 +5078,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	if (changed & BSS_CHANGED_BSSID) {
 		dev_dbg(dev, "Changed BSSID!\n");
-		rtl8xxxu_set_bssid(priv, bss_conf->bssid);
+		rtl8xxxu_set_bssid(priv, bss_conf->bssid, 0);
 	}
 
 	if (changed & BSS_CHANGED_BASIC_RATES) {
@@ -5097,7 +5107,7 @@ static int rtl8xxxu_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct device *dev = &priv->udev->dev;
 
 	dev_dbg(dev, "Start AP mode\n");
-	rtl8xxxu_set_bssid(priv, vif->bss_conf.bssid);
+	rtl8xxxu_set_bssid(priv, vif->bss_conf.bssid, 0);
 	rtl8xxxu_write16(priv, REG_BCN_INTERVAL, vif->bss_conf.beacon_int);
 	priv->fops->report_connect(priv, RTL8XXXU_BC_MC_MACID, 0, true);
 
-- 
2.39.2


