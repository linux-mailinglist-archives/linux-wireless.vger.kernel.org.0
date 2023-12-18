Return-Path: <linux-wireless+bounces-928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C808173D2
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 15:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59CD282145
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4660A495DE;
	Mon, 18 Dec 2023 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WcO6ZQdr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S45vfUUQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985BA3A1CD
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
	bh=cGFf1462jmjJDfI3zTghugO4JTZsisFmQjKQY2enSjI=;
	b=WcO6ZQdr194p0k9USChMVAPsTUiu7RgiZio1bCcIjw+he2BsiIPZil+IEhJHnvagEFlQps
	Tx8AvA4ROybTwx96asGzqM47a5gDPHvTFaLLk9yeb/tu8rs2++15k2NP1cB2xQ2qMVSQNN
	NkEfCw3a9xVZ29/FhSC3JUIAY9YgIpMNmVWNz+vDi4K84qLLcqvSX92xuqgGbzFmSwTAbN
	ZrNfRHkhRRWS4NhFPdXTEGniDdFrgxncycSRwez/FKnURNWqYaXnPVEatJeB36jOY0pPg/
	ZoEOih6jLBtK0f/9uSm5Pjpx+f1JzyAFVtzWT4TCe5hogKChtT+6l98WPrQIrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702910230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGFf1462jmjJDfI3zTghugO4JTZsisFmQjKQY2enSjI=;
	b=S45vfUUQ9CVKB5Irta+PvLn3II4Rww1y+D1YKu3FhFwhF6AIuWmuwLsq7kd0z2/h/rL5gI
	3pclXDJP8Fg5+mBw==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 20/20] wifi: rtl8xxxu: declare concurrent mode support for 8188f
Date: Mon, 18 Dec 2023 15:36:45 +0100
Message-Id: <20231218143645.433356-21-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-1-martin.kaistra@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Everything is in place now for concurrent mode, we can tell the system
that we support it.
We will allow a maximum of 2 virtual interfaces, one of them can be in
AP mode.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  1 +
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |  1 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index a0222d2666000..f0c21a41b4b85 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1991,6 +1991,7 @@ struct rtl8xxxu_fileops {
 	u8 init_reg_rxfltmap:1;
 	u8 init_reg_pkt_life_time:1;
 	u8 init_reg_hmtfr:1;
+	u8 supports_concurrent:1;
 	u8 ampdu_max_time;
 	u8 ustime_tsf_edca;
 	u16 max_aggr_num;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 1e1c8fa194cb8..80f3c39c7444a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -1751,6 +1751,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.max_aggr_num = 0x0c14,
 	.supports_ap = 1,
 	.max_macid_num = 16,
+	.supports_concurrent = 1,
 	.adda_1t_init = 0x03c00014,
 	.adda_1t_path_on = 0x03c00014,
 	.trxff_boundary = 0x3f7f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 595f447874f4d..32fd723687e90 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7634,6 +7634,20 @@ static void rtl8xxxu_deinit_led(struct rtl8xxxu_priv *priv)
 	led_classdev_unregister(led);
 }
 
+struct ieee80211_iface_limit rtl8xxxu_limits[] = {
+	{ .max = 2, .types = BIT(NL80211_IFTYPE_STATION), },
+	{ .max = 1, .types = BIT(NL80211_IFTYPE_AP), },
+};
+
+struct ieee80211_iface_combination rtl8xxxu_combinations[] = {
+	{
+		.limits = rtl8xxxu_limits,
+		.n_limits = ARRAY_SIZE(rtl8xxxu_limits),
+		.max_interfaces = 2,
+		.num_different_channels = 1,
+	},
+};
+
 static int rtl8xxxu_probe(struct usb_interface *interface,
 			  const struct usb_device_id *id)
 {
@@ -7780,6 +7794,11 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);
 	hw->queues = 4;
 
+	if (priv->fops->supports_concurrent) {
+		hw->wiphy->iface_combinations = rtl8xxxu_combinations;
+		hw->wiphy->n_iface_combinations = ARRAY_SIZE(rtl8xxxu_combinations);
+	}
+
 	sband = &rtl8xxxu_supported_band;
 	sband->ht_cap.ht_supported = true;
 	sband->ht_cap.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
-- 
2.39.2


