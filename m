Return-Path: <linux-wireless+bounces-1156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8885B81BC3E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13281B22475
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3456659922;
	Thu, 21 Dec 2023 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SL22u6FE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jq6GzpWk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C95990A
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
	bh=iNyg5aqBG5urJxpU+rxykaqCxQCO72gRqKK8Ye1CjKI=;
	b=SL22u6FEwH27XAt3XUHG+ae6BabruNOzJ4leqbV+zMnughsIU8qBTtjiGsThYAvBJsJOWq
	22o++n2GGzIvuvKxV6JoEy2CHY2ntAPiOQeePNQIx/0RL/aath/96QzS2NvM5RSo1RCxiz
	xa79WZQIZMuVHBsjQA+QXyhBjTM2t6cWXbRi64R0GoQbJ/b6MlNb/EM3A/KSiB3HxdBpq3
	M4botKmsKvbVT/o+RGxR3kRoO+Qt6BQDmBIMJERP8G88+zmsRak1yvW6dFilBkFi6vxgv1
	/bAOsAL83f7QOFyxh5z/+W5ax/J9ai7n2DukRpr2nfrkHhVetY9bSxdMTrpYtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNyg5aqBG5urJxpU+rxykaqCxQCO72gRqKK8Ye1CjKI=;
	b=jq6GzpWk5vwQ1kM/IXeyPJtEsxyYY3CElP1yVWYjgQTCZFGmjMKpvshJZaAP0rmd1cWAF+
	xau8PI64hjwP6BAw==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 10/21] wifi: rtl8xxxu: support multiple interfaces in set_aifs()
Date: Thu, 21 Dec 2023 17:43:42 +0100
Message-Id: <20231221164353.603258-11-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-1-martin.kaistra@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
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


