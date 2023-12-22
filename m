Return-Path: <linux-wireless+bounces-1229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A3581C7F9
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188DCB24A69
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCCE17751;
	Fri, 22 Dec 2023 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FxJ803ht";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kiuhp64O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F1171C5
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
	bh=hasIo9oLKqyDGDcV1syjvPr5KcH/7zYo5xQ76onoqKU=;
	b=FxJ803htdPoLdADLhaC/y0NwGXLK/8jaO806PN7TU7pAfkNezn8zoRuVipYxDqwBLQJDbE
	g234A2E0r+pwZs5ocMnWY8rtTZZIFL2jPIB0TcwpAmTJpWarwDI9YBPsxJ06tqYbLDg23J
	330lIIgSZy1Cv9OXy+QqbY4e4M/ZdfQylpRyibmL73ZJ/n9eNE6hE8GkCfVy/Ks751068+
	zkS9CFk9K6Os96riXVvYHJatrMPY4LusPfXHCZpKdAl5XE8/xiLCavCEIFSzNK0RxdBzTw
	U9LercWBAxne6oQDUWd5j2qriqFQLo4yUwy/o+4eu4OtwCo18Fh/p1kObs9qrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hasIo9oLKqyDGDcV1syjvPr5KcH/7zYo5xQ76onoqKU=;
	b=kiuhp64ON5XCAirWDQlvpFB8Xh+OCR+fJjsZn1sa+dpbO8/MUUu9ZbjXNWReODWbkfu+DD
	cNfnvrt7ohnAycCA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 10/21] wifi: rtl8xxxu: support multiple interfaces in set_aifs()
Date: Fri, 22 Dec 2023 11:14:31 +0100
Message-Id: <20231222101442.626837-11-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In concurrent mode supported by this driver, both interfaces will use
the same channel and same wireless mode.
It is therefore possible to get the wireless mode by checking the first
connected interface.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 490f35d0d6199..99fe567e0f75b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4913,14 +4913,20 @@ static void rtl8xxxu_set_aifs(struct rtl8xxxu_priv *priv, u8 slot_time)
 	u8 aifs, aifsn, sifs;
 	int i;
 
-	if (priv->vif) {
+	for (i = 0; i < ARRAY_SIZE(priv->vifs); i++) {
+		if (!priv->vifs[i])
+			continue;
+
 		struct ieee80211_sta *sta;
 
 		rcu_read_lock();
-		sta = ieee80211_find_sta(priv->vif, priv->vif->bss_conf.bssid);
+		sta = ieee80211_find_sta(priv->vifs[i], priv->vifs[i]->bss_conf.bssid);
 		if (sta)
 			wireless_mode = rtl8xxxu_wireless_mode(priv->hw, sta);
 		rcu_read_unlock();
+
+		if (wireless_mode)
+			break;
 	}
 
 	if (priv->hw->conf.chandef.chan->band == NL80211_BAND_5GHZ ||
-- 
2.39.2


