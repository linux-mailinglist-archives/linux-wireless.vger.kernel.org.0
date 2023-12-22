Return-Path: <linux-wireless+bounces-1228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E9181C7F7
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172A21C211AE
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F112D17742;
	Fri, 22 Dec 2023 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KVq+UF+w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lnOwaRmr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E1E171A3
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703240088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43NbwlNaFzVIc5XSe7laQbDtYbGsuzb24fzj9Y2JK7c=;
	b=KVq+UF+wlOcMtkm/bPN2YrtvPZl5y0yno3QRyoS9kbsueGCE0EwuTMR2ckVz5leGuv1fab
	OG86ZJznHJ+CjMbbHsrUmpemSf6YDQwDRVrUDOLE++y2xSqThp3NkpWmKcFHGqzrke8OFO
	8yRQNCq4ZUrTULj3VOnTvxRUiTbceKCLkjB3TTm/T417ksu052Ni8UC6fFvihEYIwvYdDl
	660oPX/m8QnaLVvNVm9wJ/63i0t3UdxWPde6x8sWHWKhPBQ5IxiKIwR5OewAV2zldycYpS
	mxUQ8lkmw710wTGN/rTX2COF6m8XjCcLhQE3mageILscQIhcbGWQUkQSqcL7Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=43NbwlNaFzVIc5XSe7laQbDtYbGsuzb24fzj9Y2JK7c=;
	b=lnOwaRmrpKqoqmECG6Dkj3EwtCrCdRQl0MKwgJV/fa8EKVxR/QbSuqqLeSitqxc11/R0bh
	kGSKZbCE1FzL78BQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 09/21] wifi: rtl8xxxu: support setting bssid register for multiple interfaces
Date: Fri, 22 Dec 2023 11:14:30 +0100
Message-Id: <20231222101442.626837-10-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
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


