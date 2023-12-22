Return-Path: <linux-wireless+bounces-1235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5388181C7FD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E6D28443F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BCA18047;
	Fri, 22 Dec 2023 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lDvcIQYz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uawn56sd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F1A17730
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703240089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eryH5zA3yic32Y48S4s6Nib6FNvxlkIlksAClAdIqQM=;
	b=lDvcIQYzyzNBEoHb+6ntjMgHlZ3oDWvSkdf4ZmMrrk5SI4Zcl+vnNqkErTnod62KjShonS
	XRafU6mnuT4RQrssgWOyGNPcsd+bTIOw+gUmAQMEi9HE2D++ZgsU8fyJ4thYRGIwpLTG+v
	NVdKwE3ySCsZBzd7dQ/5XuBEYJ1LM6gdTFyi9vXAM1cGX2/N9v10pe7kdk0bpErgSalIPr
	zIDMrw0N7J7sTG/gqHXGvsRZRAtWNMO4WKGyTGmOVVkWtHrNZvkNTKNSoEXlUDo6zgmLDn
	I+ed5ZoRrpyiDwPmbvddtxUCkaVhIg8g4yCjsC68bK1T7jwGHWjdZBJrN6fR3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703240089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eryH5zA3yic32Y48S4s6Nib6FNvxlkIlksAClAdIqQM=;
	b=uawn56sd7Fw0mZkcWC7ld1ZJqjX7XQ5UIBMrS7UPFnhm8AdsUlKO6Pqvy4JETMeBiQOTQB
	T1/QKy3hA4JOGoAg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 13/21] wifi: rtl8xxxu: support multiple interfaces in watchdog_callback()
Date: Fri, 22 Dec 2023 11:14:34 +0100
Message-Id: <20231222101442.626837-14-martin.kaistra@linutronix.de>
In-Reply-To: <20231222101442.626837-1-martin.kaistra@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check first whether priv->vifs[0] exists and is of type STATION, then go
to priv->vifs[1]. Make sure to call refresh_rate_mask for both
interfaces.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index c5b71892369c9..fd0108668bcda 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7200,11 +7200,15 @@ static void rtl8xxxu_watchdog_callback(struct work_struct *work)
 {
 	struct ieee80211_vif *vif;
 	struct rtl8xxxu_priv *priv;
+	int i;
 
 	priv = container_of(work, struct rtl8xxxu_priv, ra_watchdog.work);
-	vif = priv->vif;
+	for (i = 0; i < ARRAY_SIZE(priv->vifs); i++) {
+		vif = priv->vifs[i];
+
+		if (!vif || vif->type != NL80211_IFTYPE_STATION)
+			continue;
 
-	if (vif && vif->type == NL80211_IFTYPE_STATION) {
 		int signal;
 		struct ieee80211_sta *sta;
 
@@ -7215,22 +7219,21 @@ static void rtl8xxxu_watchdog_callback(struct work_struct *work)
 
 			dev_dbg(dev, "%s: no sta found\n", __func__);
 			rcu_read_unlock();
-			goto out;
+			continue;
 		}
 		rcu_read_unlock();
 
 		signal = ieee80211_ave_rssi(vif);
 
-		priv->fops->report_rssi(priv, 0,
+		priv->fops->report_rssi(priv, rtl8xxxu_get_macid(priv, sta),
 					rtl8xxxu_signal_to_snr(signal));
 
-		if (priv->fops->set_crystal_cap)
-			rtl8xxxu_track_cfo(priv);
-
 		rtl8xxxu_refresh_rate_mask(priv, signal, sta, false);
 	}
 
-out:
+	if (priv->fops->set_crystal_cap)
+		rtl8xxxu_track_cfo(priv);
+
 	schedule_delayed_work(&priv->ra_watchdog, 2 * HZ);
 }
 
-- 
2.39.2


