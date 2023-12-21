Return-Path: <linux-wireless+bounces-1165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766E481BC46
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBA41F26571
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3555E77;
	Thu, 21 Dec 2023 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lFPs1k4E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3Yka52/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2C7627FB
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
	bh=zRk4m+3M6izeZ0mA7nRGeJ3BoZePGHkX8ECIhqsMmgo=;
	b=lFPs1k4E96J3MiSWo9gyHk7fk3u8Mt6fJpZ99FIhEfFjy4SW5TtaJwK2hmig31LU1iyYcE
	rDvaBHdVzf3I/6jcybnq7Z8cOrCvREE4LhfQ+X9ndODfhv2CK7Bkr/tsDjjkA9oX3T/TDY
	/rkjHkq58e1Jyv9Iad4DEzyuet05oAFbDLMtWwZLwj/6+M4CcGonBwjNdOINDLbZJe1W9y
	kU9kQbdMH5XD9JhybMBRwbx+6Zva+NDvgltwdyCkpXrYJ4XGvertcbRzkv0vhsTEzJynQA
	ketswRdOBLwtKmRIougDLCe/eB8ouTj8d/hvfLHLzh6WK0Xc47n5z2EgMOxWWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRk4m+3M6izeZ0mA7nRGeJ3BoZePGHkX8ECIhqsMmgo=;
	b=a3Yka52/RESgpdPQ/a+dew5NTUCxfInLo6UcqTifML4cdtfKSuFw9AkD3DIHEEsp8waMsW
	j78HX68hwLleKjAQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 16/21] wifi: rtl8xxxu: support multiple interface in start_ap()
Date: Thu, 21 Dec 2023 17:43:48 +0100
Message-Id: <20231221164353.603258-17-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-1-martin.kaistra@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call set_bssid() with the correct port_num now.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index aa88e66c64d67..5e4e6c006cc1f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5111,11 +5111,12 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 static int rtl8xxxu_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			     struct ieee80211_bss_conf *link_conf)
 {
+	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct device *dev = &priv->udev->dev;
 
 	dev_dbg(dev, "Start AP mode\n");
-	rtl8xxxu_set_bssid(priv, vif->bss_conf.bssid, 0);
+	rtl8xxxu_set_bssid(priv, vif->bss_conf.bssid, rtlvif->port_num);
 	rtl8xxxu_write16(priv, REG_BCN_INTERVAL, vif->bss_conf.beacon_int);
 	priv->fops->report_connect(priv, RTL8XXXU_BC_MC_MACID, 0, true);
 
-- 
2.39.2


