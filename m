Return-Path: <linux-wireless+bounces-1160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140AC81BC43
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76549B25A0C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1E05990A;
	Thu, 21 Dec 2023 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bepDixIK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qD2tXmYv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B55823D
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703177045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eryH5zA3yic32Y48S4s6Nib6FNvxlkIlksAClAdIqQM=;
	b=bepDixIKnHrgPtWPJeeo58k8/r2IJ4oD1uef5zDAigtIrgTpJ1SSDqib+UcKhph1a1vuWp
	gaDIXZ8GzGIPfXPw8GEZqLk8qr1oYE3AaMp8Eg1oMoWjZlU30/X0YWbJVGqKtFuTakziy2
	jTWWihQgXM54h40icj+QM3G0rO0tFHMQiFA/dXTMuAPaUhSSxbFcGaILKLOZgEgZT1Vno4
	zpL3nL2YSkCzI2tIlzkBXx2u1cUAV8tjicRm8wdhCszFGhbekIZHbS3cHTVqGn2xspkr40
	WkC2eUFfKzFqok0C61wbHwEyd7jmLVAbKIptNmTTmVZVH1tkLNPMRbNBV+IbZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eryH5zA3yic32Y48S4s6Nib6FNvxlkIlksAClAdIqQM=;
	b=qD2tXmYv3CymP+cEhRkdFI6j0mOues/eEI6VUXCfS1yRz7H/LvGAXeR/Y+G/dgcfs9SRXS
	258GwFW3clERSGBA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 13/21] wifi: rtl8xxxu: support multiple interfaces in watchdog_callback()
Date: Thu, 21 Dec 2023 17:43:45 +0100
Message-Id: <20231221164353.603258-14-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-1-martin.kaistra@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
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


