Return-Path: <linux-wireless+bounces-919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F838173C6
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470FC1F22E36
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC73A1D5;
	Mon, 18 Dec 2023 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qORbmYsV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ItlK5PDY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEBC3A1C8
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702910228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD6FlXg8fJCspALTklpM7SCQ1whYQouNEOtnvE39Xhk=;
	b=qORbmYsVRSnTwHw1gM1+FP0nEeInpMfBSEdXNKEc66dsmyWPHwd1gFk9V3TBIhs0TjQksS
	m81Dl/R1tFC8cTuAbhK8FP9KxeDpe8fT5pVNvP1xVJMYIyfRmC4Q8RjrC1eGLxzeNhO7e5
	qGWx7GwijE28f2+67z6ovLX4/T+vWR+5aYnLMVS7CEyghvk/HgZqpTOoh1mdrhuxq/ntWF
	jLayXkOYfZgePbtiIeiPnyID4CBj0l7fx1YksG1kgp7ugjYIlvPWUFVBlpg7fU88liDaQA
	3q6cXuQ0bQHlMyhB+vnyLHxieJSxRhCJhWfLas0DSAfZRfbha7RrXj4W6tVc2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD6FlXg8fJCspALTklpM7SCQ1whYQouNEOtnvE39Xhk=;
	b=ItlK5PDYP3qqhdEyQfwmUeUZZ+vHTohDwqMjN7keJoRpQjPVvVcs9K+YWj8qmUcmcSyT6p
	MHDQKlbPz/IR1dBQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/20] wifi: rtl8xxxu: support multiple interfaces in set_aifs()
Date: Mon, 18 Dec 2023 15:36:34 +0100
Message-Id: <20231218143645.433356-10-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
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
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 2b546bce01237..827e715f0e585 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4913,14 +4913,18 @@ static void rtl8xxxu_set_aifs(struct rtl8xxxu_priv *priv, u8 slot_time)
 	u8 aifs, aifsn, sifs;
 	int i;
 
-	if (priv->vif) {
-		struct ieee80211_sta *sta;
+	for (i = 0; i < ARRAY_SIZE(priv->vifs); i++) {
+		if (priv->vifs[i]) {
+			struct ieee80211_sta *sta;
 
-		rcu_read_lock();
-		sta = ieee80211_find_sta(priv->vif, priv->vif->bss_conf.bssid);
-		if (sta)
-			wireless_mode = rtl8xxxu_wireless_mode(priv->hw, sta);
-		rcu_read_unlock();
+			rcu_read_lock();
+			sta = ieee80211_find_sta(priv->vifs[i], priv->vifs[i]->bss_conf.bssid);
+			if (sta)
+				wireless_mode = rtl8xxxu_wireless_mode(priv->hw, sta);
+			rcu_read_unlock();
+		}
+		if (wireless_mode)
+			break;
 	}
 
 	if (priv->hw->conf.chandef.chan->band == NL80211_BAND_5GHZ ||
-- 
2.39.2


